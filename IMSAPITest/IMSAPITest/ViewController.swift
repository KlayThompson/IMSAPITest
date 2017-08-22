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
        guard let string = NetWorkManager.shareManager.csrfToken else {
            return
        }
        bottomTipLabel.text = string
        print(string)
        
        NetWorkManager.shareManager.requestAccessToken(params: params) { (isSuccess) in
            print("")
        }
        
    }
    
    @IBAction func checkIncidentButtonPress(_ sender: Any) {
        
    }
    
    @IBAction func getHistoryButtonPress(_ sender: Any) {
    }
    
    @IBAction func getProjectsButtonPress(_ sender: Any) {
    }
    
    @IBAction func showLogButtonPress(_ sender: Any) {
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
       
        bottomTipLabel.text = "开发手机话费卡垃圾收费卡红烧豆腐卡和房东拉口红的是福利卡号的福利卡号等法律卡萨丁话费卡好地方卡号东方卡"
        
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
