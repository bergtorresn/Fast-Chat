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
    @IBOutlet weak var constraintHeightViewMsg: NSLayoutConstraint! // 50 keyboard close | 308 keyboard open
    
    let arrayMsg = ["Opa", "Blz?", "Meu nome é Rosemberg Torres Nunes, sou natural de Jaguaribe-Ce, atualmente estou morando em Fortaleza-Ce, trabalhando como Desenvolvedor Mobile.", "Qual é o seu nome? =D"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configTableView()
        textFieldMsg.delegate = self

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
        tableViewChat.addGestureRecognizer(tapGesture)
    }
    
    @objc func tableViewTapped() {
        textFieldMsg.endEditing(true)
    }
    
    fileprivate func configTableView() {
        tableViewChat.delegate = self
        tableViewChat.dataSource = self
        tableViewChat.rowHeight = UITableViewAutomaticDimension
        tableViewChat.estimatedRowHeight = 120.0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func actionSendMsg(_ sender: Any) {
        FirebaseServices.insertMessage(message: self.textFieldMsg.text!) { (result) in
            if !result {
                Alerts.genericAlert(title: "Atenção", msg: "Não foi possível enviar a mensagem, tente novamente.", viewController: self)
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
