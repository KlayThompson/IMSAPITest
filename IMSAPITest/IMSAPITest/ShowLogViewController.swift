//
//  ShowLogViewController.swift
//  IMSAPITest
//
//  Created by Kim on 2017/8/22.
//  Copyright © 2017年 Brain. All rights reserved.
//

import UIKit

class ShowLogViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 500
        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clearLogButtonPress(_ sender: Any) {
        LOG_STRING = ""
        tableView.reloadData()
        print("clear log...")
    }

    @IBAction func sendLogButtonPress(_ sender: Any) {
        //分享
        let activityController = UIActivityViewController(activityItems: [LOG_STRING], applicationActivities: nil)
        
        self.present(activityController, animated: true, completion: nil)
        print("send log...")
    }
    
}

extension ShowLogViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! LogCell
        
        cell.logLabel.text = LOG_STRING
        
        return cell
    }
}
