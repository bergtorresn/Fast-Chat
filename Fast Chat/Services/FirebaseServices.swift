//
//  FirebaseServices.swift
//  Fast Chat
//
//  Created by Rosemberg Torres Nunes on 02/06/2018.
//  Copyright © 2018 Rosemberg Torres Nunes. All rights reserved.
//

import Foundation

import Foundation
import FirebaseAuth

class FirebaseServices {
    
    // MARK: - Register
    
    static func registerUser(email: String, pswd: String, completion: @escaping (_ result: Bool, _ err: String?) ->()){
        
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
    
    static func singIn(email: String, pswd: String, completion: @escaping (_ result: Bool, _ err: String?) ->()){
        
        let auth = Auth.auth()
        auth.signIn(withEmail: email, password: pswd) { (user, error) in
            if error == nil{
                completion(true, nil)
                print("***** usuário logado com sucesso")
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
    
    // MARK: - Logout
    
    static func logOut(completion: (_ result: Bool) ->()){
        let auth = Auth.auth()
        do {
            try auth.signOut()
            completion(true)
        } catch let err {
            print(err)
            completion(false)
        }
    }
}
