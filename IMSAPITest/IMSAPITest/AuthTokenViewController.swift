//
//  AuthTokenViewController.swift
//  IMSAPITest
//
//  Created by Kim on 2017/8/22.
//  Copyright © 2017年 Brain. All rights reserved.
//

import UIKit
import AFNetworking

class AuthTokenViewController: UIViewController {

    @IBOutlet weak var doneButton: UIButton!
    
    @IBOutlet weak var userIdField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var serialNumField: UITextField!
    @IBOutlet weak var latitudefield: UITextField!
    @IBOutlet weak var longitudeField: UITextField!
    @IBOutlet weak var historyLimitField: UITextField!
    @IBOutlet weak var incidentCheckOnlySwitch: UISwitch!

    /// 点击完成回调闭包
    var doneBlock: ((_ dic: [String : Any]) -> ())?

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func doneButtonPress(_ sender: Any) {
        
        var dic = [String : Any]()
        
        dic.updateValue(userIdField.text ?? "", forKey: "userId")
        dic.updateValue(passwordField.text ?? "", forKey: "password")
        dic.updateValue(serialNumField.text ?? "L123456", forKey: "s")
        dic.updateValue(latitudefield.text ?? "0", forKey: "lat")
        dic.updateValue(longitudeField.text ?? "0", forKey: "lng")
        dic.updateValue(historyLimitField.text ?? "10", forKey: "limit")
        dic.updateValue(incidentCheckOnlySwitch.isOn ? "1" : "0", forKey: "check")
        dic.updateValue(NetWorkManager.shareManager.csrfToken ?? "", forKey: "fuel_csrf_token")
        doneBlock?(dic)
        navigationController?.popViewController(animated: true)
        
        //存储到本地一份，下次启动直接读取
        UserDefaults.standard.setValue(dic, forKey: IMS_API_PARAMETERS)
    }
}
