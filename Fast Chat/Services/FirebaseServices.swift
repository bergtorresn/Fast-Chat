//
//  FirebaseServices.swift
//  Fast Chat
//
//  Created by Rosemberg Torres Nunes on 02/06/2018.
//  Copyright © 2018 Rosemberg Torres Nunes. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

class FirebaseServices {
    
    // MARK: - Firebase Auth
    
    // MARK: - Register
    static func registerUser(email: String, pswd: String, completion: @escaping (_ result: Bool, _ err: String?) -> Void){
        
        let auth = Auth.auth()
        auth.createUser(withEmail: email, password: pswd) { (user, error) in
            
            if error == nil {
                completion(true, nil)
                print("***** Sucesso ao cadastrar usuário")
            } else {
                let err = error! as NSError
                if let erroCod = err.userInfo["error_name"] {
                    let erroText = erroCod as! String
                    completion(false, erroText)
                }
                print("***** Erro ao cadastrar usuário \(String(describing: error?.localizedDescription))")
            }
        }
    }
    
    // MARK: - SingIn
    static func singIn(email: String, pswd: String, completion: @escaping (_ result: Bool, _ err: String?) -> Void){
        
        let auth = Auth.auth()
        auth.signIn(withEmail: email, password: pswd) { (user, error) in
            if error == nil{
                completion(true, nil)
                print("***** usuário entrou na conta com sucesso")
            }else{
                let err = error! as NSError
                if let erroCod = err.userInfo["error_name"] {
                    let erroText = erroCod as! String
                    completion(false, erroText)
                    print("***** Erro no login \(String(describing: erroText))")
                }
                print("***** Erro no login \(String(describing: error?.localizedDescription))")
            }
        }
    }
    
    // MARK: - signOut
    static func signOut(completion: (_ result: Bool, _ err: String?) -> Void){
        let auth = Auth.auth()
        do {
            try auth.signOut()
            completion(true, nil)
            print("***** usuário saiu da conta com sucesso")
        } catch let err {
            print("***** \(err)")
            completion(false, err.localizedDescription)
        }
    }
    
    
    // MARK: - UserExist
    static func isUser(completion: @escaping (_ result: Bool) -> Void) {
        let auth = Auth.auth()
        
        if auth.currentUser != nil {
            completion(true)
        } else{
            completion(false)
        }
    }
    
    // MARK: - Firebase Database
    
    // MARK: - insertMessage
    static func insertMessage(message: String, completion: @escaping (_ result: Bool) -> Void){
        
        let referenceDatabase = Database.database().reference()
        let currentUser = Auth.auth().currentUser?.email
        
        let child = referenceDatabase.child("Messages")
        let messageDict = ["Sender" : currentUser, "MessageBody" : message]
        
        child.childByAutoId().setValue(messageDict) { (error, reference ) in
            if error != nil {
                print("****** Error ao enviar a mensagem: \(error.debugDescription)")
                completion(false)
            } else{
                completion(true)
                print("****** Mensagem enviada com sucesso")
            }
        }
    }
    
    static func getMessages(completion: @escaping(_ message: String, _ sender: String) -> Void) {
        
        let referenceDatabase = Database.database().reference()
        let child = referenceDatabase.child("Messages")
        
        child.observe(.childAdded) { (snapshot) in
            let snapshotValue = snapshot.value as! Dictionary<String, String>
            let message = snapshotValue["MessageBody"]!
            let sender = snapshotValue["Sender"]!
            completion(message, sender)
        }
    }

}
