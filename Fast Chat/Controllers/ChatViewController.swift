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
    
    let arrayMsg = ["Opa", "Blz?", "Meu nome é Rosemberg Torres Nunes, sou natural de Jaguaribe-Ce, atualmente estou morando em Fortaleza-Ce, trabalhando como Desenvolvedor Mobile.", "Qual é o seu nome? =D"]
    
    fileprivate func configTableView() {
        self.tableViewChat.delegate = self
        self.tableViewChat.dataSource = self
        self.tableViewChat.rowHeight = UITableViewAutomaticDimension
        self.tableViewChat.estimatedRowHeight = 120.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configTableView()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func actionSendMsg(_ sender: Any) {
        
    }
    @IBAction func actionsSignOutt(_ sender: Any) {
        FirebaseServices.signOut { (isSucessed, err) in
            if isSucessed {
                self.navigationController?.popToRootViewController(animated: true)
            } else{
                Alerts.genericAlert(title: "Atenção", msg: err!, viewController: self)
            }
        }
    }
}

extension ChatViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayMsg.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewChat.dequeueReusableCell(withIdentifier: "CellMsgSender", for: indexPath) as! MessageCell
        
        cell.labelTextMesg.text = arrayMsg[indexPath.row]
        
        return cell
    }
    
}
