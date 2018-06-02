//
//  Validators.swift
//  Fast Chat
//
//  Created by Rosemberg Torres Nunes on 02/06/2018.
//  Copyright © 2018 Rosemberg Torres Nunes. All rights reserved.
//

import Foundation

class Validators {
    
    static func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: email)
    }
    
    static func isValidPassword(pswd: String) -> Bool {
        let pswdRegEx = "(?=.*[0-9].*[0-9]).{6,}$" // String has minimum 6 characters and has two digits
        
        let pswdPredicate = NSPredicate(format:"SELF MATCHES %@", pswdRegEx)
        return pswdPredicate.evaluate(with: pswd)
    }
    
}
