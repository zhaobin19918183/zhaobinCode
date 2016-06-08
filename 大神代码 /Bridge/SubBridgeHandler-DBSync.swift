//
//  SSTBridgeHandler-DBSync.swift
//  Portal
//
//  Created by Kilin on 16/4/1.
//  Copyright © 2016年 Eli Lilly and Company. All rights reserved.
//

import UIKit
import ZipArchive
import SWXMLHash

var forceSyncDBCount = 0

//MARK: - PROPERTY & VALUE TYPE
extension SubBridgeHandler
{
    var dataFileNameWithoutExtension : String{
        return UserManager.sharedManager.username + "_" + self.entity.applicationCode!
    }
    
    var dbNameWithExtension : String{
        return self.dataFileNameWithoutExtension + ".db"
    }
    
    var xmlNameWithExtension : String{
        return self.dataFileNameWithoutExtension + ".xml"
    }
    
    var zipNameWithExtension : String{
        return self.dataFileNameWithoutExtension + ".zip"
    }
    
    var zipPackagePath : String {
        return PATH_FOLDER_TEMP + self.zipNameWithExtension
    }
    
    var dbTempUnzipedPath : String{
        return PATH_FOLDER_DB + UserManager.sharedManager.username + ".db"
    }
    
    var xmlTempUnzipedPath : String{
        return PATH_FOLDER_XML + UserManager.sharedManager.username + ".xml"
    }
    
    var dbDestinationPath : String{
        return PATH_FOLDER_DB + self.dbNameWithExtension
    }
    
    var xmlDestinationPath : String{
        return PATH_FOLDER_XML + self.xmlNameWithExtension
    }
    
    enum SynchronizationStep : Int {
        case Unknown    = 0
        case Request    = 1
        case Downloaded = 2
        case Unziped    = 3
        case ExecuteSQL = 4
        case Completed  = 5
    }
    
    struct IndexStepParameters
    {
        var step : SynchronizationStep
        var recordID : String
        var forceSync : Bool
        var syncUpToDate : String
        
        init(forceSync : Bool)
        {
            self.step = .Unknown
            self.recordID = ""
            self.forceSync = forceSync
            self.syncUpToDate = ""
        }
        
        init(syncUpToDate : String)
        {
            self.step = .Unknown
            self.recordID = ""
            self.forceSync = false
            self.syncUpToDate = syncUpToDate
        }
        
        init(step : SynchronizationStep, parameters : IndexStepParameters)
        {
            self.step = step
            self.recordID = parameters.recordID
            self.forceSync = parameters.forceSync
            self.syncUpToDate = parameters.syncUpToDate
        }
        
        init(step : SynchronizationStep, recordID : String , parameters : IndexStepParameters)
        {
            self.step = step
            self.recordID = recordID
            self.forceSync = parameters.forceSync
            self.syncUpToDate = parameters.syncUpToDate
        }
    }
}

//MARK: - DB SYNC PROGRESS
extension SubBridgeHandler
{
    func handleSyncDBAutomatic(data: AnyObject , completion : (result : String) -> Void)
    {
        guard let userDatabaseRecord : Entity_UserDatabase = self.validateUserDatabaseRecord() else
        {
            self.executeSyncStepIndex(data,completion: completion)
            return
        }
        
        guard self.validateDatabaseUpdatable(data , entity: userDatabaseRecord) == false else
        {
            self.deleteFileAt(self.dbDestinationPath)
            self.executeSyncStepIndex(data,completion: completion)
            return
        }
        
        guard self.validateSqliteConnectable() == true else
        {
            self.executeSyncStepIndex(data,completion: completion)
            return
        }
        
        if let recordEntity = SyncRecordsDAO.retriveLatestRecordEntity()
        {
            if Int(recordEntity.syncStep!) == SynchronizationStep.Completed.rawValue
            {
                completion(result: self.createResponseToJSWith("This is the latest version.",Status: true))
            }else
            {
                completion(result: self.createResponseToJSWith("Last update failed",Status: true))
            }
        }else
        {
            self.executeSyncStepIndex(data,completion: completion)
        }
    }
    
    func handleSyncDBManual(data: AnyObject , completion : (result : String) -> Void)
    {
        let syncUpToDate = data["Params"] as! String
        self.syncStepIndex(IndexStepParameters(syncUpToDate: syncUpToDate), completion: { (response) in
            completion(result: response.result)
        })
    }
}

//MARK: - Synchronization
extension SubBridgeHandler
{
    func executeSyncStepIndex(data : AnyObject ,completion : (result : String) -> Void) -> Void
    {
        self.syncStepIndex(IndexStepParameters(forceSync: true), completion: { (response) in
            if response.isCompleted == true
            {
                self.updateUserdatabaseWith(Version: self.getNewUserDatabaseVersion(data))
            }
            completion(result: response.result)
        })
    }
    
    //MARK: - STEP FUNCTION
    private func syncStepIndex(parameters : IndexStepParameters , completion : (isCompleted : Bool, result : String) -> Void)
    {
        guard self.checkNetworkEnable() == true else
        {
            //TODO:TRANSLATION
            self.updateSyncDBUI?(step: .Unknown, warningContent: "无网络连接", forceSync : parameters.forceSync)
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(TIME_ALERT_ERROR * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { () -> Void in
                completion(isCompleted: false,result: self.createResponseToJSWith("无网络连接",Status: false))
                parameters.forceSync == true ? self.backToHomeFunction?() : {}()
            }
            return
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(TIME_ALERT_DELAY * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { () -> Void in
            switch parameters.step {
            case .Unknown:
                self.syncStepUnknown(parameters,completion: completion)
            case .Request:
                self.syncStepRequest(parameters, completion: completion)
            case .Downloaded:
                self.syncStepDownloaded(parameters, completion: completion)
            case .Unziped:
                self.syncStepUnziped(parameters, completion: completion)
            case .ExecuteSQL:
                self.syncStepExecuteSQL(parameters, completion: completion)
            case .Completed:
                self.updateSyncRecordWith(parameters.recordID, step: SynchronizationStep.Completed)
                self.updateSyncDBUI?(step: .Completed, warningContent: "" , forceSync : parameters.forceSync)
                SyncRecordsDAO.updateRecordEntityWith(parameters.recordID, updateClosure: { (entity) in
                    entity?.syncStep = SynchronizationStep.Completed.rawValue
                    entity?.syncDateTo = NSDate()
                })
                completion(isCompleted: true,result: self.createResponseToJSWith("同步完成",Status: true))
            }
        }
    }
    
    private func syncStepUnknown(parameters : IndexStepParameters , completion : (isCompleted : Bool, result : String) -> Void)
    {
        self.updateSyncDBUI?(step: .Unknown, warningContent: "", forceSync : parameters.forceSync)
        self.syncStepIndex(IndexStepParameters(step: .Request, parameters: parameters), completion: completion)
    }
    
    private func syncStepRequest(parameters : IndexStepParameters, completion : (isCompleted : Bool, result : String) -> Void)
    {
        self.updateSyncDBUI?(step: .Request, warningContent: "", forceSync : parameters.forceSync)
        
        let recordID = self.createSyncRecord()
        let postParameters = NetworkManager.sharedManager.generateDBParameters([ "ForceSync" : parameters.forceSync ,"RecordId" : recordID ,"SyncUpToDate" : parameters.syncUpToDate == "" ? "" : HelperManager.convertStringToAnyObject(parameters.syncUpToDate)!])
        NetworkManager.sharedManager.syncDataWithPOSTMethod(self.entity.dataTransferInterface!, parameters: postParameters) { (state, results) in
            switch state
            {
            case .Success :
                guard let isOK = self.chechSyncDBSuccess(results) where isOK == true else {
                    SyncRecordsDAO.updateRecordEntityWith(recordID, updateClosure: { (entity) in
                        entity?.syncStep = -100
                        entity?.syncDateTo = NSDate()
                    })
                    self.updateSyncDBUI?(step: .Request, warningContent: "下载数据包失败", forceSync : parameters.forceSync)
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(TIME_ALERT_ERROR * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { () -> Void in
                        completion(isCompleted: false,result: self.createResponseToJSWith("下载数据包失败",Status: false))
                    }
                    return
                }
                
                let contentString = results!["Content"] as! String
                let content = HelperManager.convertStringToAnyObject(contentString)
                guard let needSync = self.chechDBNeedUpdate(content) where needSync == true else
                {
                    SyncRecordsDAO.updateRecordEntityWith(recordID, updateClosure: { (entity) in
                        entity?.needSync = 2
                        entity?.syncDateTo = NSDate()
                    })
                    self.updateSyncDBUI?(step: .Request, warningContent: "本次不需要更新", forceSync : parameters.forceSync)
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(TIME_ALERT_ERROR * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { () -> Void in
                        completion(isCompleted: false,result: self.createResponseToJSWith("本次不需要更新",Status: false))
                    }
                    return
                }

                SyncRecordsDAO.updateRecordEntityWith(recordID, updateClosure: { (entity) in
                    let packageID = content!["PackageId"] as? NSNumber
                    entity?.packageID = packageID
                    entity?.needSync = 1
                })
                
                let base64String = content?["Package"] as? String
                let zipedFileData = NSData(base64EncodedString: base64String ?? "", options: .IgnoreUnknownCharacters)
                zipedFileData?.writeToFile(self.zipPackagePath, atomically: true)
                self.updateSyncRecordWith(recordID, step: SynchronizationStep.Downloaded)
                self.syncStepIndex(IndexStepParameters(step: .Downloaded, recordID: recordID, parameters: parameters), completion: completion)
            default:
                if parameters.forceSync == true && forceSyncDBCount == 0
                {
                    self.syncStepRequestWhileError(IndexStepParameters(step: .Request, recordID: recordID, parameters: parameters), completion: completion)
                    forceSyncDBCount += 1
                }else
                {
                    self.updateSyncDBUI?(step: .Request, warningContent: "下载数据包失败", forceSync : parameters.forceSync)
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(TIME_ALERT_ERROR * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { () -> Void in
                        completion(isCompleted: false,result: self.createResponseToJSWith("下载数据包失败",Status: false))
                    }
                }
            }
        }
    }
    
    //Just for server data is so big , soag disconnection.
    private func syncStepRequestWhileError(parameters : IndexStepParameters, completion : (isCompleted : Bool, result : String) -> Void)
    {
        let postParameters = NetworkManager.sharedManager.generateDBParameters([ "ForceSync" : parameters.forceSync ,"RecordId" : parameters.recordID ,"SyncUpToDate" : parameters.syncUpToDate])
        NetworkManager.sharedManager.syncDataWithPOSTMethod(self.entity.dataTransferInterface!, parameters: postParameters) { (state, results) in
            switch state
            {
            case .Success :
                guard let isOK = self.chechSyncDBSuccess(results) where isOK == true else {
                    SyncRecordsDAO.updateRecordEntityWith(parameters.recordID, updateClosure: { (entity) in
                        entity?.syncStep = -100
                        entity?.syncDateTo = NSDate()
                    })
                    self.updateSyncDBUI?(step: .Request, warningContent: "下载数据包失败", forceSync : parameters.forceSync)
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(TIME_ALERT_ERROR * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { () -> Void in
                        completion(isCompleted: false,result: self.createResponseToJSWith("下载数据包失败",Status: false))
                    }
                    return
                }
                
                let contentString = results!["Content"] as! String
                let content = HelperManager.convertStringToAnyObject(contentString)
                guard let needSync = self.chechDBNeedUpdate(content) where needSync == true else
                {
                    SyncRecordsDAO.updateRecordEntityWith(parameters.recordID, updateClosure: { (entity) in
                        entity?.needSync = 2
                        entity?.syncDateTo = NSDate()
                    })
                    self.updateSyncDBUI?(step: .Request, warningContent: "本次不需要更新", forceSync : parameters.forceSync)
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(TIME_ALERT_ERROR * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { () -> Void in
                        completion(isCompleted: false,result: self.createResponseToJSWith("本次不需要更新",Status: false))
                    }
                    return
                }
                
                SyncRecordsDAO.updateRecordEntityWith(parameters.recordID, updateClosure: { (entity) in
                    let packageID = content!["PackageId"] as? NSNumber
                    entity?.packageID = packageID
                    entity?.needSync = 1
                })
                
                let base64String = content?["Package"] as? String
                let zipedFileData = NSData(base64EncodedString: base64String ?? "", options: .IgnoreUnknownCharacters)
                zipedFileData?.writeToFile(self.zipPackagePath, atomically: true)
                self.updateSyncRecordWith(parameters.recordID, step: SynchronizationStep.Downloaded)
                self.syncStepIndex(IndexStepParameters(step: .Downloaded, recordID: parameters.recordID, parameters: parameters), completion: completion)
            default:
                self.updateSyncDBUI?(step: .Request, warningContent: "下载数据包失败", forceSync : parameters.forceSync)
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(TIME_ALERT_ERROR * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { () -> Void in
                    completion(isCompleted: false,result: self.createResponseToJSWith("下载数据包失败",Status: false))
                }
            }
        }
    }
    
    private func syncStepDownloaded(parameters : IndexStepParameters, completion : (isCompleted : Bool, result : String) -> Void)
    {
        let destination = parameters.forceSync == true ? PATH_FOLDER_DB : PATH_FOLDER_XML
        
        self.updateSyncDBUI?(step: .Downloaded, warningContent: "", forceSync : parameters.forceSync)
        SSZipArchive.unzipFileAtPath(self.zipPackagePath, toDestination: destination, progressHandler: nil, completionHandler: { (path , success, error) in
            if success == true
            {
                FolderManager.deleteFileAt(self.zipPackagePath)
                self.updateUnzipedFileName(parameters.forceSync)
                
                self.updateSyncRecordWith(parameters.recordID, step: SynchronizationStep.Unziped)
                self.syncStepIndex(IndexStepParameters(step: .Unziped, parameters: parameters), completion: completion)
            }else
            {
                SyncRecordsDAO.updateRecordEntityWith(parameters.recordID, updateClosure: { (entity) in
                    entity?.syncDateTo = NSDate()
                    entity?.syncStep = -98
                })
                self.updateSyncDBUI?(step: .Downloaded, warningContent: "解压失败", forceSync : parameters.forceSync)
                completion(isCompleted: false,result: self.createResponseToJSWith("解压失败",Status: false))
            }
        })
    }
    
    private func syncStepUnziped(parameters : IndexStepParameters, completion : (isCompleted : Bool, result : String) -> Void)
    {
        self.updateSyncDBUI?(step: .Unziped, warningContent: "", forceSync : parameters.forceSync)
        if parameters.forceSync == true
        {
            self.syncStepIndex(IndexStepParameters(step: .Completed, parameters: parameters), completion: completion)
        }else
        {
            self.updateSyncRecordWith(parameters.recordID, step: SynchronizationStep.ExecuteSQL)
            self.syncStepIndex(IndexStepParameters(step: .ExecuteSQL, parameters: parameters), completion: completion)
        }
    }
    
    private func syncStepExecuteSQL(parameters : IndexStepParameters, completion : (isCompleted : Bool, result : String) -> Void)
    {
        self.updateSyncDBUI?(step: .ExecuteSQL, warningContent: "", forceSync : parameters.forceSync)
        if let xmlData = NSData(contentsOfFile: self.xmlDestinationPath)
        {
            let xmlParser = SWXMLHash.parse(xmlData)
            let sqlStatements = xmlParser["SyncData"]["SqlStatement"].all.map({ $0.element!.text! })

            DBManager.sharedManager.executeSQLStatementWithTransaction(sqlStatements, completion: { 
                self.deleteFileAt(self.xmlDestinationPath)
                self.syncStepIndex(IndexStepParameters(step: .Completed, parameters: parameters), completion: completion)
            })
        }else
        {
            SyncRecordsDAO.updateRecordEntityWith(parameters.recordID, updateClosure: { (entity) in
                entity?.syncDateTo = NSDate()
                entity?.syncStep = -99
            })
            self.updateSyncDBUI?(step: .Request, warningContent: "无法读取XML文件", forceSync : parameters.forceSync)
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(TIME_ALERT_ERROR * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { () -> Void in
                completion(isCompleted: false,result: self.createResponseToJSWith("无法读取XML文件",Status: false))
            }
        }
    }
}

//MARK: - VALIDATE & OTHER FUNCTION
extension SubBridgeHandler
{
    //MARK: - VALIDATE
    //Validate if there entity in userdatabase
    private func validateUserDatabaseRecord() -> Entity_UserDatabase?
    {
        return UserDatabaseDAO.retriveUserDatabaseEntityWith(UserManager.sharedManager.username, dbName: self.dbNameWithExtension)
    }
    
    //Compare new db version get from js and exist db version load from local coredata.
    private func validateDatabaseUpdatable(data : AnyObject, entity : Entity_UserDatabase) -> Bool
    {
        return self.getNewUserDatabaseVersion(data) > Float(entity.dbVersion!)
    }
    
    //Try to cennect with sqlite
    private func validateSqliteConnectable() -> Bool
    {
        return DBManager.sharedManager.tryConnectDB(self.dbDestinationPath)
    }
    
    //Check network is enable
    private func checkNetworkEnable() -> Bool
    {
        return NetworkManager.sharedManager.isNetworkEnable()
    }
    
    //Check response from synced db with server
    private func chechSyncDBSuccess( results : AnyObject? ) -> Bool?
    {
        if let dictionary = results
        {
            return dictionary["IsOK"] as? Bool
        }else
        {
            return nil
        }
    }
    
    private func chechDBNeedUpdate( results : AnyObject? ) -> Bool?
    {
        if let dictionary = results
        {
            return dictionary["NeedSync"] as? Bool
        }else
        {
            return nil
        }
    }
    
    //MARK: - GET
    //Get new userdatabase version from js
    private func getNewUserDatabaseVersion(data : AnyObject) -> Float?
    {
        if let parameters = data["Params"] as? String
        {
            let dictionary = HelperManager.convertStringToAnyObject(parameters) as? [String : AnyObject]
            let dbVersionString = dictionary!["DBVersion"] as? String
            return Float(dbVersionString!)
        }else
        {
            return 0
        }
    }
    
    //MARK: - CREATOR
    //Generate response JSON string to js
    private func createResponseToJSWith(message : String , Status : Bool) -> String
    {
        var responseDictionary : [ String : AnyObject ] = self.generateDefaultCallbackDataWith(nil)
        responseDictionary["Message"] = message
        responseDictionary["Status"] = Status
        return HelperManager.convertDataToString(responseDictionary)
    }
    
    //MARK: - UPDATE COREDATA
    //Generate syncedRecord
    private func createSyncRecord() ->  String
    {
        let recordID = NSUUID().UUIDString
        SyncRecordsDAO.createRecordEntityWith{ (entity) in
            entity.recordID = recordID
            entity.systemID = UserManager.sharedManager.username
            entity.dbName = self.dbNameWithExtension
            entity.syncStep = SynchronizationStep.Request.rawValue
            entity.packageID = 0
            entity.syncDateFrom = NSDate()
            entity.syncDateTo = nil
            entity.needSync = 0
        }
        return recordID
    }
    
    //Update syncedRecord
    private func updateSyncRecordWith(recordID : String , step : SynchronizationStep)
    {
        SyncRecordsDAO.updateRecordEntityWith(recordID, updateClosure: { (entity) in
            entity!.syncStep = step.rawValue
        })
    }
    
    //Update userdatabase version
    private func updateUserdatabaseWith(Version newDBVersion : Float?)
    {
        UserDatabaseDAO.updateUserDatabaseEntityWith(UserManager.sharedManager.username, dbName: self.dbNameWithExtension, updateClosure: { (entity) in
            entity?.dbName    = self.dbNameWithExtension
            entity?.dbVersion = newDBVersion
            entity?.systemID  = UserManager.sharedManager.username
        })
    }
    
    //MARK: - OTHER
    private func updateUnzipedFileName( forceSync : Bool )
    {
        let originPath = forceSync == true ? self.dbTempUnzipedPath : self.xmlTempUnzipedPath
        let targetPath = forceSync == true ? self.dbDestinationPath : self.xmlDestinationPath
        do
        {
            try NSFileManager.defaultManager().moveItemAtPath(originPath, toPath: targetPath)
        }catch{}
    }
    
    private func deleteFileAt(path : String)
    {
        let fileManager = NSFileManager.defaultManager()
        do{
            try fileManager.removeItemAtPath(path)
        }catch{}
    }
    
    //Connection DB
    func connectionDB()
    {
        DBManager.sharedManager.connectionDB(self.dbDestinationPath)
    }
}













