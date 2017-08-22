//
//  AuthTokenViewController.swift
//  IMSAPITest
//
//  Created by Kim on 2017/8/22.
//  Copyright © 2017年 Brain. All rights reserved.
//

import UIKit

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
        
        dic.updateValue(userIdField.text ?? "", forKey: "UserId")
        dic.updateValue(passwordField.text ?? "", forKey: "Password")
        dic.updateValue(serialNumField.text ?? "L123456", forKey: "Serial Num")
        dic.updateValue(latitudefield.text ?? "0", forKey: "Latitude")
        dic.updateValue(longitudeField.text ?? "0", forKey: "Longitude")
        dic.updateValue(historyLimitField.text ?? "10", forKey: "History Limit")
        dic.updateValue(incidentCheckOnlySwitch.isOn, forKey: "Incident Check Only")

        
        doneBlock?(dic)
        
        navigationController?.popViewController(animated: true)
    }


}
