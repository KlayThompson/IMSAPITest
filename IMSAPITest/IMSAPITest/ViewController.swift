//
//  ViewController.swift
//  IMSAPITest
//
//  Created by Kim on 2017/8/22.
//  Copyright © 2017年 Brain. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var authTokenButton: UIButton!
    
    @IBOutlet weak var checkIncidentButton: UIButton!
    
    @IBOutlet weak var getHistoryButton: UIButton!
    
    @IBOutlet weak var getProjectsButton: UIButton!
    
    @IBOutlet weak var showLogButton: UIButton!
    
    @IBOutlet weak var bottomTipLabel: UILabel!
    
    //上一级界面带回来的dic
    var params: [String : Any]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       setupUI()
    }

    // MARK: - Actions
    @IBAction func getAuthTokenPress(_ sender: Any) {
//        guard let string = NetWorkManager.shareManager.csrfToken else {
//            return
//        }
        bottomTipLabel.text = "get authToken..."
        //因为每次的csrfToken必须更新，所以目前采用较笨的方法，每次请求网络前都调用一次获取csrfToken方法
        NetWorkManager.shareManager.requestCSRFToken { (isSuccess) in
            if isSuccess {
                //更新参数的csrfToken
                self.params?.updateValue(NetWorkManager.shareManager.csrfToken ?? "", forKey: "fuel_csrf_token")
                NetWorkManager.shareManager.requestAccessToken(params: self.params) { (isSuccess, josn) in
                    if isSuccess {
                        guard let json = josn else { return }
                        let jsonDic = json as! [String : Any]
                        self.bottomTipLabel.text = jsonDic.description
                    } else {
                        self.bottomTipLabel.text = "get authToken error"
                    }
                    
                }
            } else {
                self.bottomTipLabel.text = "get csrfToken error..."
            }
        }
        
    }
    
    @IBAction func checkIncidentButtonPress(_ sender: Any) {
        bottomTipLabel.text = "check incident now..."
        //因为每次的csrfToken必须更新，所以目前采用较笨的方法，每次请求网络前都调用一次获取csrfToken方法
        NetWorkManager.shareManager.requestCSRFToken { (isSuccess) in
            if isSuccess {
                NetWorkManager.shareManager.requestCheckIncidentWithAuthToken(params: self.params, completion: { (isSuccess, jsonObj) in
                    if isSuccess {
                        let jsonDic = jsonObj as? [String : Any]
                        self.bottomTipLabel.text = jsonDic?.description
                    } else {
                        self.bottomTipLabel.text = "check incident error..."
                    }
                })
            } else {
                self.bottomTipLabel.text = "get csrfToken error..."
            }
        }
    }
    
    @IBAction func getHistoryButtonPress(_ sender: Any) {
        bottomTipLabel.text = "getting history now..."
        //因为每次的csrfToken必须更新，所以目前采用较笨的方法，每次请求网络前都调用一次获取csrfToken方法
        NetWorkManager.shareManager.requestCSRFToken { (isSuccess) in
            if isSuccess {
                NetWorkManager.shareManager.requestHistoryWithAuthToken(params: self.params, completion: { (isSuccess, jsonObj) in
                    if isSuccess {
                        let jsonDic = jsonObj as? [String : Any]
                        self.bottomTipLabel.text = jsonDic?.description
                    } else {
                        self.bottomTipLabel.text = "get history error..."
                    }
                })
            } else {
                self.bottomTipLabel.text = "get csrfToken error..."
            }
        }
    }
    
    @IBAction func getProjectsButtonPress(_ sender: Any) {
        bottomTipLabel.text = "getting projects now..."
        //因为每次的csrfToken必须更新，所以目前采用较笨的方法，每次请求网络前都调用一次获取csrfToken方法
        NetWorkManager.shareManager.requestCSRFToken { (isSuccess) in
            if isSuccess {
                NetWorkManager.shareManager.requestProjectsWithAuthToken(params: self.params, completion: { (isSuccess, jsonObj) in
                    if isSuccess {
                        let jsonDic = jsonObj as? [String : Any]
                        self.bottomTipLabel.text = jsonDic?.description
                    } else {
                        self.bottomTipLabel.text = "get projects error..."
                    }
                })
            } else {
                self.bottomTipLabel.text = "get csrfToken error..."
            }
        }
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "setupapi" {
            let auth = segue.destination as! AuthTokenViewController
            auth.doneBlock = { dic in
                self.params = dic
            }
            print("可以传递数据了")
        }
    }
    
}

// MARK: - 设置界面
private extension ViewController {

    func setupUI() {
               
        authTokenButton.layer.borderWidth = 1
        authTokenButton.layer.borderColor = UIColor.gray.cgColor
        
        checkIncidentButton.layer.borderWidth = 1
        checkIncidentButton.layer.borderColor = UIColor.gray.cgColor
        
        getHistoryButton.layer.borderWidth = 1
        getHistoryButton.layer.borderColor = UIColor.gray.cgColor
        
        getProjectsButton.layer.borderWidth = 1
        getProjectsButton.layer.borderColor = UIColor.gray.cgColor
        
        showLogButton.layer.borderWidth = 1
        showLogButton.layer.borderColor = UIColor.gray.cgColor
    }
}
