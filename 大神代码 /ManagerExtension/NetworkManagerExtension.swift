//
//  NetworkManagerExtension.swift
//  Portal
//
//  Created by Kilin on 16/3/29.
//  Copyright © 2016年 Eli Lilly and Company. All rights reserved.
//

import UIKit

//Extension of Sync data
extension NetworkManager
{    
    func syncDataWithPOSTMethod(url : String , parameters : [ String : AnyObject] , completion : (state : NetworkResponseState , results : AnyObject?) -> Void) {
        guard self.isNetworkEnable() else
        {
            completion(state: .NetworkNotReachable, results: nil)
            return
        }
        
        NetworkManager.sharedManager.postDataTo(url, parameters: parameters) { (response) in
            if let responseJSON = response.result.value
            {
                let responseState = NetworkResponseState.checkSOAGResponse(HelperManager.convertDataToString(responseJSON))
                completion(state: responseState, results: responseState == .Success ? responseJSON : nil)
            }else
            {
                completion(state: response.result.error?.code == -1001 ? .Timeout : .OtherError,results: nil)
            }
        }
    }
    
    func postDeviceToken(token : String)
    {
        NetworkManager.sharedManager.postDataTo(URLManager.sharedManager.postDeviceTokenURL, parameters: self.generateDeviceTokenParameters(token)) { (response) in
        }
    }
}

//Extension of Generate data
extension NetworkManager
{
    func generateAppVersionData(parameters : [ String : AnyObject ]) -> [String : AnyObject]
    {
        let content = String(data: HelperManager.convertAnyObjectToData(parameters) , encoding: NSUTF8StringEncoding)
        return self.generateServerData("SalesPortalManager", opid: "GetApplicationList", content: content ?? "")
    }
    
    func generateDeviceTokenParameters(token : String) -> [String : AnyObject]
    {
        let parameters = [ "DeviceToken" : token ]
        let content = String(data: HelperManager.convertAnyObjectToData(parameters) , encoding: NSUTF8StringEncoding)
        return self.generateServerData("PushNotificationManager", opid: "CreateDeviceToken", content: content ?? "")
    }
    
    func generateDBParameters(parameters : [ String : AnyObject ]) -> [String : AnyObject]
    {
        let content = String(data: HelperManager.convertAnyObjectToData(parameters) , encoding: NSUTF8StringEncoding)
        return self.generateServerData("Manager", opid: "Sync", content: content ?? "")
    }
    
    private func generateServerData(ownerClass : String , opid : String , content : String) -> [ String : AnyObject ] {
        let dic : [String : AnyObject] = [
            "OwnerClass"   : ownerClass,
            "OPID"         : opid,
            "IsOK"         : true,
            "Message"      : "",
            "Content"      : content,
            "FromFlag"     : 0,
            "Files"        : "",
            "LillyAccount" : UserManager.sharedManager.username ?? "" ,
            "Version"      : PROJECT_VERSION
        ]
        return dic
    }
}
