//
//  SubBridgeHandler.swift
//  Portal
//
//  Created by Kilin on 16/3/29.
//  Copyright © 2016年 Eli Lilly and Company. All rights reserved.
//

import UIKit
import ZipArchive

struct SubBridgeHandler : SubBridgeHandlerProtocol
{
    var showAlertFunction : ((title : String , message : String , confirmTitle : String , cancelTitle : String? , completion : (isConfirmed : Bool) -> Void) -> Void)?
    var updateSyncDBUI : ( (step : SubBridgeHandler.SynchronizationStep , warningContent : String , forceSync : Bool) -> Void )?
    var backToHomeFunction : (() -> Void)?
    var entity : Entity_App
    
    init (entity : Entity_App)
    {
        self.entity = entity
    }
    
    func handleLogin(data: AnyObject) -> String
    {
        var responseDictionary : [ String : AnyObject ] = self.generateDefaultCallbackDataWith(data)
        if UserManager.sharedManager.username.isEmpty
        {
            responseDictionary["Status"] = false
            responseDictionary["Message"] = "Can not get LillyID"
        }else
        {
            responseDictionary["Params"] = ["LillyAccount" : "\(UserManager.sharedManager.username)"]
            self.connectionDB()
        }
        
        return HelperManager.convertDataToString(responseDictionary)
    }
    
    func handleCheckOnline(Data data : AnyObject) -> String
    {
        var responseDictionary : [ String : AnyObject ] = self.generateDefaultCallbackDataWith(data)
        responseDictionary["Status"] = NetworkManager.sharedManager.isNetworkEnable()
        return HelperManager.convertDataToString(responseDictionary)
    }
    
    func handleSQLStatement(Data data : AnyObject) -> String
    {
        var responseDictionary : [ String : AnyObject ] = self.generateDefaultCallbackDataWith(data)
        
        //Check SQL statement is empty
        var statement = ""
        if let element = data["SQL"] as? String
        {
            statement = element
        }else
        {
            responseDictionary["Status"]  = false
            responseDictionary["Message"] = "SQL satement is empty!"
            return HelperManager.convertDataToString(responseDictionary)
        }
        
        //Check SQL schema is empty
        var schema = [String]()
        if let element = data["SQLSchema"] as? [String]
        {
            schema = element
        }else
        {
            responseDictionary["Status"]  = false
            responseDictionary["Message"] = "SQL schema is empty!"
            return HelperManager.convertDataToString(responseDictionary)
        }

        //Execute SQL statement
        if let resultsOfSQLStatement = try? DBManager.sharedManager.executeSQLStatement(statement, schemaList: schema)
        {
            responseDictionary["Params"] = resultsOfSQLStatement
        }else
        {
            responseDictionary["Status"] = false
            responseDictionary["Message"] = "SQL statement execute failed!"
        }
        
        return HelperManager.convertDataToString(responseDictionary)
    }
    
    func handleBatchSQLStatement(Data data: AnyObject) -> String
    {
        var responseDictionary : [ String : AnyObject ] = self.generateDefaultCallbackDataWith(data)
        
        //Check SQL statement is empty
        var statement = ""
        if let element = data["SQL"] as? String
        {
            statement = element
        }else
        {
            responseDictionary["Status"]  = false
            responseDictionary["Message"] = "SQL satement is empty!"
            return HelperManager.convertDataToString(responseDictionary)
        }
        
        //Execute SQL statement
        do {
            try DBManager.sharedManager.executeBatchSqlStatement(statement)
        }catch
        {
            responseDictionary["Status"]  = false
            responseDictionary["Message"] = "Execute SQL satement failed!"
            return HelperManager.convertDataToString(responseDictionary)
        }
        
        return HelperManager.convertDataToString(responseDictionary)
    }
    
    func handleShowAlert(Data data : AnyObject, completion : (result : String) -> Void)
    {
        let paramsString          = data["Params"] as! String
        let params                = HelperManager.convertStringToAnyObject(paramsString)
        let title                 = params!["Title"] as! String
        let message               = params!["Message"] as! String
        let confirmTitle          = params!["ConfirmName"] as! String
        let cancelTitle : String? = params!["CancelName"] as? String
        
        self.showAlertFunction?(title: title, message: message, confirmTitle: confirmTitle, cancelTitle: cancelTitle!, completion: { (isConfirmed) in
            var responseDictionary : [ String : AnyObject ] = self.generateDefaultCallbackDataWith(data)
            responseDictionary["Status"] = isConfirmed
            completion(result: HelperManager.convertDataToString(responseDictionary))
        })
    }
    
    func handleNetwork(Data data : AnyObject, completion : (result : String) -> Void)
    {
        if let dataDic = data as? [String : AnyObject]
        {
            let url = dataDic["SOAG"] as! String
            let requestURL = url.isEmpty == true ? self.entity.dataTransferInterface! : url
            NetworkManager.sharedManager.syncDataWithPOSTMethod(requestURL, parameters: dataDic) { (state, results) in
                switch state
                {
                case .Timeout:
                    completion(result: HelperManager.convertDataToString(self.generateNetworkCallbackErrorData("IOS-100")))
                case .AuthenticateFailed:
                    completion(result: HelperManager.convertDataToString(self.generateNetworkCallbackErrorData("IOS-101")))
                case .SOAGError:
                    completion(result: HelperManager.convertDataToString(self.generateNetworkCallbackErrorData("IOS-102")))
                case .OtherError:
                    completion(result: HelperManager.convertDataToString(self.generateNetworkCallbackErrorData("IOS-103")))
                case .DataError:
                    completion(result: HelperManager.convertDataToString(self.generateNetworkCallbackErrorData("IOS-104")))
                case .NetworkNotReachable:
                    completion(result: HelperManager.convertDataToString(self.generateNetworkCallbackErrorData("IOS-105")))
                case .Success:
                    completion(result: HelperManager.convertDataToString(results))
                }
            }
        }else
        {
            let callbackData = self.generateNetworkCallbackErrorData("Data struct wrong")
            completion(result: HelperManager.convertDataToString(callbackData))
        }
    }
    
    func handleRetriveSyncRecords(Data data: AnyObject, completion: (result: String) -> Void)
    {
        let dateformatter = NSDateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let records = SyncRecordsDAO.retriveRecordEntityWith(UserManager.sharedManager.username, dbName: self.dbNameWithExtension)?.map({ (syncRecord) -> [String : AnyObject] in
            var dictionary = [String : AnyObject]()
            dictionary["packageID"] = syncRecord.packageID
            dictionary["recordID"]  = syncRecord.recordID
            dictionary["syncDateFrom"] = dateformatter.stringFromDate(syncRecord.syncDateFrom!)
            dictionary["syncDateTo"] = syncRecord.syncDateTo == nil ? "" : dateformatter.stringFromDate(syncRecord.syncDateTo!)
            dictionary["syncStep"] = syncRecord.syncStep
            dictionary["systemID"] = syncRecord.systemID
            dictionary["needSync"] = syncRecord.needSync
            return dictionary
        })
        
        var responseDictionary : [ String : AnyObject ] = self.generateDefaultCallbackDataWith(data)
        responseDictionary["Params"] = HelperManager.convertDataToString(records)
        completion(result: HelperManager.convertDataToString(responseDictionary))
    }
    
    func handleRegistLocalNotifications(Data data: AnyObject, completion: (result: String) -> Void)
    {
        UIApplication.sharedApplication().cancelAllLocalNotifications()
        
        if let dataDic = data as? [String : AnyObject]
        {
            guard let content = dataDic["Params"] as? String else
            {
                var responseDictionary : [ String : AnyObject ] = self.generateDefaultCallbackDataWith(data)
                responseDictionary["Status"] = true
                responseDictionary["Message"] = "Notify is null"
                completion(result: HelperManager.convertDataToString(responseDictionary))
                return
            }
            
            guard let informations = HelperManager.convertStringToAnyObject(content) as? [[String : String]] else
            {
                var responseDictionary : [ String : AnyObject ] = self.generateDefaultCallbackDataWith(data)
                responseDictionary["Status"] = false
                responseDictionary["Message"] = "Data struct wrong"
                completion(result: HelperManager.convertDataToString(responseDictionary))
                return
            }
            
            for information in informations
            {
                let localNotification = UILocalNotification()
                localNotification.soundName = UILocalNotificationDefaultSoundName
                
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                localNotification.fireDate = dateFormatter.dateFromString(information["FireDate"]!)
                localNotification.alertBody = information["AlertContent"]!
                localNotification.applicationIconBadgeNumber = 1
                UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
            }
            
            let responseDictionary : [ String : AnyObject ] = self.generateDefaultCallbackDataWith(data)
            completion(result: HelperManager.convertDataToString(responseDictionary))
        }else
        {
            var responseDictionary : [ String : AnyObject ] = self.generateDefaultCallbackDataWith(data)
            responseDictionary["Status"] = false
            responseDictionary["Message"] = "Data struct wrong"
            completion(result: HelperManager.convertDataToString(responseDictionary))
        }
    }
    
    func handleBackToHome()
    {
        self.backToHomeFunction?()
    }
    
    func handleDeleteUserData(Data data: AnyObject, completion: (result: String) -> Void)
    {
        SyncRecordsDAO.deleteRecordWith(UserManager.sharedManager.username, dbName: self.dbNameWithExtension)
        UserDatabaseDAO.deleteUserDatabaseWith(UserManager.sharedManager.username, dbName: self.dbNameWithExtension)
        FolderManager.deleteFileAt(self.dbDestinationPath)
        
        var responseDictionary : [ String : AnyObject ] = self.generateDefaultCallbackDataWith(data)
        responseDictionary["Message"] = "User cleared"
        completion(result: HelperManager.convertDataToString(responseDictionary))
    }
}

//MARK: - GENERATOR
extension SubBridgeHandler
{
    func generateDefaultCallbackDataWith(data : AnyObject?) -> [ String : AnyObject]
    {
        var responseDictionary : [ String : AnyObject ] = Dictionary()
        if let functionName = data?["FunctionName"] as? String
        {
            responseDictionary["FunctionName"] = functionName
        }else
        {
            responseDictionary["FunctionName"] = ""
        }
        responseDictionary["LillyAccount"] = ""
        responseDictionary["SQL"]          = ""
        responseDictionary["SQLSchema"]    = ""
        responseDictionary["Status"]       = true
        responseDictionary["Message"]      = ""
        responseDictionary["Params"]       = ""
        
        return responseDictionary
    }
    
    func generateNetworkCallbackErrorData(message : String) -> [ String : AnyObject]
    {
        var callbackData = [String : AnyObject]()
        callbackData["OwnerClass"] = ""
        callbackData["OPID"] = ""
        callbackData["IsOK"] = false
        callbackData["Message"] = message
        callbackData["Content"] = ""
        callbackData["FromFlag"] = ""
        callbackData["Files"] = ""
        callbackData["LillyAccount"] = UserManager.sharedManager.username ?? ""
        return callbackData
    }
}

//MARK: - GET FUNCTION
extension SubBridgeHandler
{
    func getIndexHTMLPath() -> (Bool , String)
    {
        var state = false
        let appFolderPath = HelperManager.getUnzipedAppPathWith(self.entity)
        var indexHTMLPath = ""
        if SchemaManager.sharedManager.isLaunchBySchema == true
        {
            let sepeartString = "smartsalestool://" + SchemaManager.sharedManager.appName
            let subPaths = SchemaManager.sharedManager.schema.stringByRemovingPercentEncoding?.componentsSeparatedByString(sepeartString)
            let subPath : String? = subPaths!.last
            indexHTMLPath = appFolderPath + subPath!
        }else
        {
            indexHTMLPath = appFolderPath + "/index.html"
        }
        
        if NSFileManager.defaultManager().fileExistsAtPath(indexHTMLPath)
        {
            state = true
            return (state , indexHTMLPath)
        }else
        {
            return (state , "")
        }
    }
}

















