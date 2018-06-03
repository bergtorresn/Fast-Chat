//
//  ChatViewController.swift
//  Fast Chat
//
//  Created by Rosemberg Torres Nunes on 02/06/2018.
//  Copyright © 2018 Rosemberg Torres Nunes. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableViewChat: UITableView!
    @IBOutlet weak var textFieldMsg: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func actionSendMsg(_ sender: Any) {
        
    }
    @IBAction func actionLogOut(_ sender: Any) {
        
    }
}

extension ChatViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewChat.dequeueReusableCell(withIdentifier: "Cell")
        
        return cell!
    }
    
}
