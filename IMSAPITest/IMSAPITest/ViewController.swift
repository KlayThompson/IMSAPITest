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
    
//    @IBOutlet weak var bottomTipLabel: UILabel!
    
    @IBOutlet weak var logTableView: UITableView!
    //上一级界面带回来的dic
    var params: [String : Any]?
    
    let cellId = "cellId"
    
    var logString: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        //取出本地的api参数字典
        let dic = UserDefaults.standard.object(forKey: IMS_API_PARAMETERS) as? [String : Any]
        
        guard let paramDic = dic else {
            logString = "Setup API Parameters first..."
            logTableView.reloadData()
            return
        }
        params = paramDic
        print("这")
    }

    // MARK: - Actions
    @IBAction func getAuthTokenPress(_ sender: Any) {
        
        logString = "get authToken..."
        logTableView.reloadData()
        //因为每次的csrfToken必须更新，所以目前采用较笨的方法，每次请求网络前都调用一次获取csrfToken方法
        NetWorkManager.shareManager.requestCSRFToken { (isSuccess, jsonObj) in
            if isSuccess {
                LOG_STRING = "获取AuthToken的csrfToken成功：\(String(describing: jsonObj))"
                
                //更新参数的csrfToken
                self.params?.updateValue(NetWorkManager.shareManager.csrfToken ?? "", forKey: "fuel_csrf_token")
                NetWorkManager.shareManager.requestAccessToken(params: self.params) { (isSuccess, josn) in
                    if isSuccess {
                        guard let json = josn else { return }
                        let jsonDic = json as! [String : Any]
                        self.logString = jsonDic.description
                        LOG_STRING = "   获取AuthToekn成功： \(jsonDic.description)" + LOG_STRING
                    } else {
                        self.logString = "get authToken error"
                    }
                    self.logTableView.reloadData()
                }
            } else {
                self.logString = "get csrfToken error..."
            }
            self.logTableView.reloadData()
        }
        
    }
    
    @IBAction func checkIncidentButtonPress(_ sender: Any) {
        logString = "check incident now..."
        logTableView.reloadData()
        //因为每次的csrfToken必须更新，所以目前采用较笨的方法，每次请求网络前都调用一次获取csrfToken方法
        NetWorkManager.shareManager.requestCSRFToken { (isSuccess, jsonObj) in
            if isSuccess {
                LOG_STRING = "获取checkIncident的csrfToken成功：\(String(describing: jsonObj))" + LOG_STRING

                NetWorkManager.shareManager.requestCheckIncidentWithAuthToken(params: self.params, completion: { (isSuccess, jsonObj) in
                    if isSuccess {
                        let jsonDic = jsonObj as? [String : Any]
                        self.logString = jsonDic?.description
                        LOG_STRING = "check incident 成功，结果为：\(String(describing: jsonDic?.description))" + LOG_STRING
                    } else {
                        self.logString = "check incident error..."
                    }
                    self.logTableView.reloadData()
                })
            } else {
                self.logString = "get csrfToken error..."
            }
            self.logTableView.reloadData()
        }
    }
    
    @IBAction func getHistoryButtonPress(_ sender: Any) {
        logString = "getting history now..."
        logTableView.reloadData()
        NetWorkManager.shareManager.requestHistoryWithAuthToken(params: self.params, completion: { (isSuccess, jsonObj) in
            if isSuccess {
                let jsonDic = jsonObj as? [String : Any]
                self.logString = jsonDic?.description
                LOG_STRING = "Get History 成功：\(String(describing: jsonDic?.description))" + LOG_STRING
            } else {
                self.logString = "get history error..."
            }
            self.logTableView.reloadData()
        })
    }
    
    @IBAction func getProjectsButtonPress(_ sender: Any) {
        logString = "getting projects now..."
        logTableView.reloadData()
        NetWorkManager.shareManager.requestProjectsWithAuthToken(params: self.params, completion: { (isSuccess, jsonObj) in
            if isSuccess {
                let jsonDic = jsonObj as? [String : Any]
                self.logString = jsonDic?.description
                LOG_STRING = "Get Projects 成功：\(String(describing: jsonDic?.description))" + LOG_STRING
            } else {
                self.logString = "get projects error..."
            }
            self.logTableView.reloadData()
        })
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "setupapi" {
            let auth = segue.destination as! AuthTokenViewController
            auth.doneBlock = { dic in
                self.params = dic
                self.logString = ""
            }
            print("可以传递数据了")
        }
    }
    
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! LogCell
        
        cell.logLabel.text = logString
        
        return cell
    }
}

// MARK: - 设置界面
private extension ViewController {

    func setupUI() {
        
        logTableView.rowHeight = UITableViewAutomaticDimension
        logTableView.estimatedRowHeight = 300
        logTableView.tableFooterView = UIView()
        
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
