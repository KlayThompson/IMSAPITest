//
//  NetWorkManager+Extension.swift
//  IMSAPITest
//
//  Created by Kim on 2017/8/22.
//  Copyright © 2017年 Brain. All rights reserved.
//

import Foundation

// MARK: - 获取csrfToken
extension NetWorkManager {

    func requestCSRFToken(completion: @escaping (_ isSuccess: Bool, _ jsonObject: AnyObject?)->()) {
        
        let urlString = IMS_SERVER_NAME + IMS_GET_CSRF_URL

        requestNetWork(url: urlString, params: nil) { (json, isSuccess) in
            
            let jsonDic = json as? NSDictionary
            self.csrfToken = jsonDic?.object(forKey: "csrfToken") as? String
            print(json ?? "0")
            completion(isSuccess,json)
        }
        
    }
    
}
    	
// MARK: - 获取用户AccessToken
extension NetWorkManager {
    
    func requestAccessToken(params: [String : Any]?, completion: @escaping (_ isSucces: Bool, _ json: AnyObject?)->()) {
        
        let urlString = IMS_SERVER_NAME + IMS_AUTH_URL
        
        
        requestNetWork(requestMethod: .POST, url: urlString, params: params) { (json, isSuccess) in
            print("获取AccessToken -----\(String(describing: json))")
            
            if isSuccess {
                let jsonDic = json as? [String : Any]
                self.authToken = jsonDic?["authToken"] as? String
            }
            //回调
            completion(isSuccess, json)
            
        }
    }
}

// MARK: - 获取Incident
extension NetWorkManager {
    
    func requestCheckIncidentWithAuthToken(params: [String : Any]?, completion: @escaping (_ isSuccess: Bool, _ json: AnyObject?)->()) {
        let urlString = IMS_SERVER_NAME + IMS_CREATE_INCIDENT
        
        var param = params
        if param == nil {
            param = [String : Any]()
        }
        param?["fuel_csrf_token"] = csrfToken ?? ""
        
        //参数还需拼接deviceId和project中的一个code
        param?["appid"] = "3"
        param?["d"] = udid ?? ""
        requestNetWork(requestMethod: .POST, url: urlString, params: param) { (jsonObj, isSuccess) in
            completion(isSuccess, jsonObj)
        }
    }
}

// MARK: - 获取history
extension NetWorkManager {
    
    func requestHistoryWithAuthToken(params: [String : Any]?, completion: @escaping (_ isSuccess: Bool, _ json: AnyObject?)->()) {
        let urlString = IMS_SERVER_NAME + IMS_GET_HISTORY
        
        var param = params
        if param == nil {
            param = [String : Any]()
        }
        param?["fuel_csrf_token"] = csrfToken ?? ""
        
        //参数还需拼接deviceId
        param?["d"] = udid ?? ""
        
        requestNetWorkWithToken(url: urlString, params: param) { (jsonObj, isSuccess) in
            completion(isSuccess, jsonObj)
        }
    }
}

// MARK: - 获取projects
extension NetWorkManager {
    
    func requestProjectsWithAuthToken(params: [String : Any]?, completion: @escaping (_ isSuccess: Bool, _ json: AnyObject?)->()) {
        let urlString = IMS_SERVER_NAME + IMS_GET_PROJECTS
        
        var param = params
        if param == nil {
            param = [String : Any]()
        }
        param?["fuel_csrf_token"] = csrfToken ?? ""
        
        //参数还需拼接deviceId
        param?["d"] = udid ?? ""
        
        requestNetWorkWithToken(url: urlString, params: param) { (jsonObj, isSuccess) in
            completion(isSuccess, jsonObj)
        }
    }
}
