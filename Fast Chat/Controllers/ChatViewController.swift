//
//  ChatViewController.swift
//  Fast Chat
//
//  Created by Rosemberg Torres Nunes on 02/06/2018.
//  Copyright © 2018 Rosemberg Torres Nunes. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {
    
    //MARK: - UI Elements
    
    @IBOutlet weak var tableViewChat: UITableView!
    @IBOutlet weak var textFieldMsg: UITextField!
    @IBOutlet weak var constraintHeightViewMsg: NSLayoutConstraint! // 50 keyboard close | 308 keyboard open
    
    //MARK: - Properties
    
    var messageArray = [Message]()
    
    //MARK: - ViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFieldMsg.delegate = self
        tableViewChat.delegate = self
        tableViewChat.dataSource = self
    
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
        tableViewChat.addGestureRecognizer(tapGesture)
        
        fetchMessages()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Methods
    
    @objc func tableViewTapped() {
        textFieldMsg.endEditing(true)
    }
    
    fileprivate func configTableView() {
        tableViewChat.rowHeight = UITableViewAutomaticDimension
        tableViewChat.estimatedRowHeight = 120.0
        tableViewChat.reloadData()
    }
    
    func fetchMessages() {
        FirebaseServices.getMessages { (message, sender) in
            let newMessage = Message()
            newMessage.messageBody = message
            newMessage.sender = sender
            
            self.messageArray.append(newMessage)
            self.textFieldMsg.endEditing(true)
            self.configTableView()
        }
    }
    
    
    // MARK: Buttons Actions
    
    @IBAction func actionSendMsg(_ sender: Any) {
        FirebaseServices.insertMessage(message: self.textFieldMsg.text!) { (result) in
            if !result {
                Alerts.genericAlert(title: "Atenção", msg: "Não foi possível enviar a mensagem, tente novamente.", viewController: self)
            } else {
                self.textFieldMsg.text = ""
            }
        }
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

// MARK: TableView Delegate & DataSource

extension ChatViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewChat.dequeueReusableCell(withIdentifier: "CellMsgSender", for: indexPath) as! MessageCell
        
        cell.labelTextMesg.text = messageArray[indexPath.row].messageBody
        
        return cell
    }
}

// MARK: Textfield Delegate

extension ChatViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.4) {
            self.constraintHeightViewMsg.constant = 310
            self.view.layoutIfNeeded()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.4) {
            self.constraintHeightViewMsg.constant = 50
            self.view.layoutIfNeeded()
        }
    }
    
}
