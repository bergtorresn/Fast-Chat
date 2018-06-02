//
//  RegisterViewController.swift
//  Fast Chat
//
//  Created by Rosemberg Torres Nunes on 02/06/2018.
//  Copyright © 2018 Rosemberg Torres Nunes. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPswd: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func actionSendData(_ sender: Any) {
        if Validators.isValidEmail(email: textFieldEmail.text!){
            if Validators.isValidPassword(pswd: textFieldPswd.text!){
                FirebaseServices.registerUser(email: textFieldEmail.text!, pswd: textFieldEmail.text!) { (result, err) in
                    if result {
                        self.performSegue(withIdentifier: "segueChat", sender: self)
                    } else {
                        Alerts.genericAlert(title: "Atenção", msg: err!, viewController: self)
                    }
                }
            } else {
                Alerts.genericAlert(title: "Atenção", msg: "Senha inválida", viewController: self)
            }
        } else {
            Alerts.genericAlert(title: "Atenção", msg: "Email inválido", viewController: self)
        }
    }
}
