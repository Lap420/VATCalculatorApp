//
//  AlertManager.swift
//  VAT Calculator
//
//  Created by Lap on 14.03.2023.
//

import UIKit

struct AlertManager {
    static func showCommonAlert(_ vc: UIViewController, textField: UITextField, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Okay", style: .default)
        let clearAction = UIAlertAction(title: "Clear", style: .destructive) {_ in
            textField.text = nil
        }

        alert.addAction(clearAction)
        alert.addAction(okAction)
        vc.present(alert, animated: true)
    }
    
    static func valueTooHighAlert(field: String, textField: UITextField) -> UIAlertController {
        let alert = UIAlertController(title: "Value too high",
                                      message: "The number you entered in \"\(field)\" field is too large",
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Okay", style: .default)
        let clearAction = UIAlertAction(title: "Clear", style: .destructive) { _ in
            textField.text = nil
        }
        alert.addAction(clearAction)
        alert.addAction(okAction)
        return alert
    }
    
    static func incorrectValueAlert(field: String, textField: UITextField) -> UIAlertController {
        let alert = UIAlertController(title: "Incorrect value",
                                      message: "The value you entered in \"\(field)\" field is not a number",
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Okay", style: .default)
        let clearAction = UIAlertAction(title: "Clear", style: .destructive) { _ in
            textField.text = nil
        }
        alert.addAction(clearAction)
        alert.addAction(okAction)
        return alert
    }
}
