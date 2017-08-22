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

    func requestCSRFToken(completion: @escaping (_ isSuccess: Bool)->()) {
        
        let urlString = IMS_SERVER_NAME + IMS_GET_CSRF_URL

        requestNetWork(url: urlString, params: nil) { (json, isSuccess) in
            
            let jsonDic = json as? NSDictionary
            self.csrfToken = jsonDic?.object(forKey: "csrfToken") as? String
            print(json ?? "0")
            completion(isSuccess)
        }
        
    }
    
}

// MARK: - 获取用户AccessToken
extension NetWorkManager {
    
    func requestAccessToken(params: [String : Any]?, completion: @escaping (_ isSucces: Bool)->()) {
        
        let urlString = IMS_SERVER_NAME + IMS_AUTH_URL
        
        
        requestNetWork(requestMethod: .POST, url: urlString, params: params) { (json, isSuccess) in
            print("获取AccessToken -----\(String(describing: json))")
            
          
            
        }
    }
}
