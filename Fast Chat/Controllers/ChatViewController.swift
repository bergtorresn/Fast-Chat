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
    @IBOutlet weak var constraintHeightViewMsg: NSLayoutConstraint! // 50 keyboard closed | 308 keyboard open
    
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
        
        configTableView()
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
    }
    
    func fetchMessages() {
        FirebaseServices.getMessages { (message, sender) in
            let newMessage = Message()
            newMessage.messageBody = message
            newMessage.sender = sender
            
            self.messageArray.append(newMessage)
            self.textFieldMsg.endEditing(true)
            self.configTableView()
            self.tableViewChat.reloadData()
            self.scrollToBottom()
        }
    }
    
    func scrollToBottom() {
        let indexPath = IndexPath(row: self.messageArray.count-1, section: 0)
        self.tableViewChat.scrollToRow(at: indexPath, at: .bottom, animated: true)
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
        self.constraintHeightViewMsg.constant = 310
        UIView.animate(withDuration: 0.2, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }) { (completed) in
            self.scrollToBottom()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.constraintHeightViewMsg.constant = 50
        UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }) { (completed) in
        }
    }
    
}
