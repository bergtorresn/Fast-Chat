//
//  Alerts.swift
//  Fast Chat
//
//  Created by Rosemberg Torres Nunes on 02/06/2018.
//  Copyright © 2018 Rosemberg Torres Nunes. All rights reserved.
//

import UIKit

class Alerts {
    static func genericAlert(title: String, msg: String, viewController: UIViewController){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        viewController.present(alert, animated: true)
    }
}
