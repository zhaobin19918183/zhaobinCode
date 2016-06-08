//
//  NetworkManager.swift
//  Portal
//
//  Created by Kilin on 16/3/15.
//  Copyright © 2016年 Innocellence. All rights reserved.
//

import UIKit
import Alamofire

typealias completionWithResponse     = (request : NSURLRequest? , response : NSHTTPURLResponse? , data : NSData? , error : NSError?) -> Void
typealias completionWithResponseJSON = Alamofire.Response<AnyObject, NSError> -> Void

struct NetworkManager
{
    let manager : Manager
    
    static let sharedManager = NetworkManager()
    private init()
    {
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.HTTPAdditionalHeaders = Manager.defaultHTTPHeaders
        configuration.timeoutIntervalForRequest = 300
        self.manager = Manager(configuration: configuration, delegate: Manager.SessionDelegate(), serverTrustPolicyManager: nil)
        
        self.addAuthenticationChallenge()
        self.addNetworkStateListening()
    }
    
    private var networkReachabilityManager : NetworkReachabilityManager? = NetworkReachabilityManager()
    private func addNetworkStateListening()
    {
        self.networkReachabilityManager?.startListening()
        self.networkReachabilityManager?.networkReachabilityStatus
    }
    
    func isNetworkEnable() -> Bool
    {
        if let isReachable = self.networkReachabilityManager?.isReachable
        {
            return isReachable
        }else
        {
            return false
        }
    }
    
    private func addAuthenticationChallenge()
    {
        self.manager.delegate.sessionDidReceiveChallenge = { session, challenge in
            var disposition: NSURLSessionAuthChallengeDisposition = .PerformDefaultHandling
            var credential: NSURLCredential?
            
            if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
                disposition = NSURLSessionAuthChallengeDisposition.UseCredential
                credential = NSURLCredential(forTrust: challenge.protectionSpace.serverTrust!)
            } else {
                if challenge.previousFailureCount > 0 {
                    disposition = .CancelAuthenticationChallenge
                } else {
                    if let identify = UserManager.sharedManager.identify
                    {
                        credential = NSURLCredential(identity: identify, certificates: nil, persistence: .ForSession)
                    }else
                    {
                        credential = nil
                    }
                    if credential != nil {
                        disposition = .UseCredential
                    }
                }
            }
            return (disposition, credential)
        }
    }
    
    func postDataTo(url : String? , parameters : [String : AnyObject] , completion: completionWithResponseJSON)
    {
        guard let requestURL = url else
        {
            return
        }
        
        manager
            .request(.POST, requestURL, parameters: parameters, encoding: .JSON)
            .authenticate(user: UserManager.sharedManager.username, password: UserManager.sharedManager.password)
            .responseJSON{ response in
                completion(response)
        }
    }
    
    func downloadFrom(url : String , completeBytes : (completeBytes : Int) -> () ,completion : completionWithResponse)
    {
        let destination = Alamofire.Request.suggestedDownloadDestination(directory: .CachesDirectory, domain: .UserDomainMask)
        manager
            .download(.GET, url, destination: destination)
            .progress { (bytesRead, totalBytesRead, totalBytesExpectedToRead) -> Void in
                dispatch_async(dispatch_get_main_queue(), {
                    completeBytes(completeBytes: Int(totalBytesRead))
                })
            }.response { (request:NSURLRequest?,response: NSHTTPURLResponse?,data: NSData?,error : NSError?) -> Void in
                completion(request: request , response: response , data: data , error: error)
        }
    }
    
    enum NetworkResponseState {
        case NetworkNotReachable
        case AuthenticateFailed
        case SOAGError
        case DataError
        case OtherError
        case Timeout
        case Success
        
        static func checkSOAGResponse(response : String?) -> NetworkResponseState
        {
            let authenticationFailedString1 = "<message>authentication failed</message>"
            let authenticationFailedString2 = "policyResult status=\"Authentication Required\""
            let authenticationFailedString3 = "policyResult status=\"Authentication Failed\""
            let soagErrorString             = "policyResult status=\""
            
            if let message = response
            {
                if message.containsString(authenticationFailedString1) || message.containsString(authenticationFailedString2) || message.containsString(authenticationFailedString3)
                {
                    return .AuthenticateFailed
                }else if message.containsString(soagErrorString)
                {
                    return .SOAGError
                }else
                {
                    return .Success
                }
            }else
            {
                return .OtherError
            }
        }
    }
}











