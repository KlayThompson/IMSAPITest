//
//  NetworkManager.swift
//  IMSAPITest
//
//  Created by Kim on 2017/8/22.
//  Copyright © 2017年 Brain. All rights reserved.
//

import Foundation

import UIKit
import AFNetworking//直接导入文件夹名称


/// 发起网络请求枚举类型
///
/// - GET: GET请求
/// - POST: POST请求
enum RequestMethod {
    case GET
    case POST
}

class NetWorkManager: AFHTTPSessionManager {
    
    
    //创建单利
    static let shareManager:NetWorkManager = {
        
        let instance = NetWorkManager()
        
        return instance
    }()
    
    
    var authToken: String?
    
    var csrfToken: String?
    
    var udid: String?
    
    
    /// 用户登录状态
    var userLogin: Bool {
        return authToken != nil
    }
    
    /// 包含token的网络请求直接调用此方法
    func requestNetWorkWithToken(requestMethod: RequestMethod = .GET, url: String, params: [String: Any]?, completion: @escaping (_ resultJson: AnyObject?, _ isSuccess: Bool) -> ()) {
        
        //先判断token是否存在，不存在直接返回
        if authToken == nil {
            print("Token为空，请登录")
            
            completion(nil, false)
            return
        }
        
        //判断参数params是否为空，为空则创建字典
        var params = params
        
        if params == nil {
            params = [String: Any]()
        }
        guard let token = authToken else {
            print("Token 为空")
            return
        }
        params?["authToken"] = token
        
        requestNetWork(requestMethod: requestMethod, url: url, params: params, completion: completion)
    }
    
    
    
    /// 封装的post 和 get 网络请求
    ///
    /// - Parameters:
    ///   - requestMethod: post或者get
    ///   - url: url字符串
    ///   - params: 请求参数
    ///   - completion: 完成回调json数据和isSuccess是否成功
    func requestNetWork(requestMethod: RequestMethod = .GET, url: String, params: [String: Any]?, completion: @escaping (_ resultJson: AnyObject?, _ isSuccess: Bool) -> ()) {
        
        //创建闭包
        let success = { (dataTask: URLSessionDataTask, json: Any?) -> () in
            completion(json as AnyObject, true)
        }
        print("")
        let failure = { (dataTask: URLSessionDataTask?, error: Error) -> () in
            completion(nil, false)
            
            //如果token失效，403，则提示用户重新登录
            if (dataTask?.response as? HTTPURLResponse)?.statusCode == 403 {
                
                print("Token失效。提示用户重新登录")
            }
            
            print("网络请求错误-----\(error)")
        }
        
        if requestMethod == .GET {
            get(url, parameters: params, progress: nil, success: success, failure: failure)
            guard let params = params else {
                print("接口URL ----:\(url)")
                return
            }
            var paramsString = "?"
            
            for (key,value) in params {
                paramsString = paramsString + "\(key)=\(value)&"
            }
            paramsString.remove(at: paramsString.index(before: paramsString.endIndex))
            paramsString = url + paramsString
            print("接口URL ----:\(paramsString)")
        } else {
            post(url, parameters: params, progress:nil, success: success, failure: failure)
        }
        
    }
}
