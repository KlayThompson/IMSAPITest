//
//  ShowLogViewController.swift
//  IMSAPITest
//
//  Created by Kim on 2017/8/22.
//  Copyright © 2017年 Brain. All rights reserved.
//

import UIKit

class ShowLogViewController: UIViewController {

    @IBOutlet weak var logLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clearLogButtonPress(_ sender: Any) {
        logLabel.text = ""
        print("clear log...")
    }

    @IBAction func sendLogButtonPress(_ sender: Any) {
        print("send log...")
    }
    
   

}
