//
//  ChatViewController.swift
//  Parse-Chat
//
//  Created by Aarnav Ram on 23/02/17.
//  Copyright © 2017 Aarnav Ram. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageField: UITextField!
    var messageArray:[PFObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 75
        
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(onTimer), userInfo: nil, repeats: true)
        


        // Do any additional setup after loading the view.
    }
    
    func onTimer() {
        // Add code to be run periodically
        let query = PFQuery(className:"Message")
        query.order(byDescending: "createdAt")
        query.limit = 20
        query.findObjectsInBackground { (object, error) in
            if let messages = object {
                self.messageArray = messages
                self.tableView.reloadData()
            } else {
                print(error?.localizedDescription)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onSendPressed(_ sender: AnyObject) {
        
        var message = PFObject(className:"Message")
        message["text"] = self.messageField.text!
        
        message.saveInBackground { (success: Bool, error: Error?) in
            if success {
                print(message["text"])
            } else {
                print(error?.localizedDescription)
            }
        }
        
        self.messageField.text = ""
        print(messageArray)
        onTimer()

        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let message = messageArray[indexPath.row]
        
        
        let messageString = message["text"] as? String
        
        if let messageString = messageString {
            cell.textLabel?.text = "\(messageString)"

        }
        
        return cell
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
