//
//  NetWorkManager.swift
//  EveryOne
//
//  Created by Zhao.bin on 16/1/22.
//  Copyright © 2016年 Zhao.bin. All rights reserved.
//

import UIKit
import Foundation
import Alamofire


extension String {

    var newdata: NSData {
        return self.dataUsingEncoding(NSUTF8StringEncoding)!
    }
}
/* Swift 2.0 Network request packaging*/

class NetWorkRequest {
     
    static func request(method: String, url: String, params: Dictionary<String, AnyObject> = Dictionary<String, AnyObject>(), callback: (data: NSString!, response: NSURLResponse!, error: NSError!) -> Void){
        
        let manager = NetWorkSwiftManager(url: url, method: method,params:params,callback: callback)
        manager.fire()
    }
    
    /*get request，With no Arguments*/
    static func get(url: String, callback: (data: NSString!, response: NSURLResponse!, error: NSError!) -> Void) {
        let manager = NetWorkSwiftManager(url: url, method: "GET", callback: callback)
        manager.fire()
    }
    
    /*get request，With Arguments*/
    static func get(url: String, params: Dictionary<String, AnyObject>, callback: (data: NSString!, response: NSURLResponse!, error: NSError!) -> Void) {
        let manager = NetWorkSwiftManager(url: url, method: "GET", params: params, callback: callback)
        manager.fire()
    }
    
    /*POST request，With no Arguments*/
    static func post(url: String, callback: (data: NSString!, response: NSURLResponse!, error: NSError!) -> Void) {
        let manager = NetWorkSwiftManager(url: url, method: "POST", callback: callback)
        manager.fire()
    }
    
    /*POST request，With Arguments*/
    static func post(url: String, params: Dictionary<String, AnyObject>, callback: (data: NSString!, response: NSURLResponse!, error: NSError!) -> Void) {
        let manager = NetWorkSwiftManager(url: url, method: "POST", params: params, callback: callback)
        manager.fire()
    }
    
    /*PUT request，With no Arguments*/
    static func put(url: String,  callback: (data: NSString!, response: NSURLResponse!, error: NSError!) -> Void) {
        let manager = NetWorkSwiftManager(url: url, method: "PUT", callback: callback)
        manager.fire()
    }
    
    /*PUT request，With Arguments*/
    static func put(url: String, params: Dictionary<String, AnyObject>, callback: (data: NSString!, response: NSURLResponse!, error: NSError!) -> Void) {
        let manager = NetWorkSwiftManager(url: url, method: "PUT", params: params, callback: callback)
        manager.fire()
    }
    
    /*DELETE request，With Arguments*/
    static func delete(url: String, params: Dictionary<String, AnyObject>, callback: (data: NSString!, response: NSURLResponse!, error: NSError!) -> Void) {
        let manager = NetWorkSwiftManager(url: url, method: "DELETE", params: params, callback: callback)
        manager.fire()
    }
    
    
    
}
/*ententions*/



class NetWorkSwiftManager {
    
    let method: String!
    let params: Dictionary<String, AnyObject>
    let callback: (data: NSString!, response: NSURLResponse!, error: NSError!) -> Void
    
    
    var session = NSURLSession.sharedSession()
    let url: String!
    var request: NSMutableURLRequest!
    var task: NSURLSessionTask!

    /*带参数 构造器*/
    init(url: String, method: String, params: Dictionary<String, AnyObject> = Dictionary<String, AnyObject>(), callback: (data: NSString!, response: NSURLResponse!, error: NSError!) -> Void) {
        self.url = url
        self.request = NSMutableURLRequest(URL: NSURL(string: url)!)
        self.method = method
        self.params = params
        self.callback = callback
    }
    
    
    
    func buildRequest() {
        if self.method == "GET" && self.params.count > 0 {
            self.request = NSMutableURLRequest(URL: NSURL(string: url + "?" + buildParams(self.params))!)
        }
        
        request.HTTPMethod = self.method
        
        if self.params.count > 0 {
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        }
    }
    func buildBody() {
        if self.params.count > 0 && self.method != "GET" {
            request.HTTPBody = buildParams(self.params).newdata
        }
    }
    func fireTask() {
   
        task = session.dataTaskWithRequest(request,completionHandler: { (data, response, error) -> Void in
            self.callback(data: NSString(data:data!, encoding: NSUTF8StringEncoding), response: response, error: error)
        })
        task.resume()
    }
    
    
    //借用 Alamofire 函数
    func buildParams(parameters: [String: AnyObject]) -> String {
        
        var components: [(String, String)] = []
        
        for key in  parameters.keys.sort() {
            let value: AnyObject! = parameters[key]
            //拼接url
            components += self.queryComponents(key, value)
        }
        
        return (components.map { "\($0)=\($1)" } as [String]).joinWithSeparator("&")
        
    }
    
    
    func queryComponents(key: String, _ value: AnyObject) -> [(String, String)] {
        var components: [(String, String)] = []
        if let dictionary = value as? [String: AnyObject] {
            for (nestedKey, value) in dictionary {
                components += queryComponents("\(key)[\(nestedKey)]", value)
            }
        } else if let array = value as? [AnyObject] {
            for value in array {
                components += queryComponents("\(key)", value)
            }
        } else {
            components.appendContentsOf([(escape(key), escape("\(value)"))])
        }
        
        return components
    }
    
    
    func escape(string: String) -> String {
        let legalURLCharactersToBeEscaped: CFStringRef = ":&=;+!@#$()',*"
        
        return string.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.init(contentsOfFile: legalURLCharactersToBeEscaped as String)!)!
    }
    
    func fire() {
        buildRequest()
        buildBody()
        fireTask()
    }
    
}