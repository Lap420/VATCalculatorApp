//
//  AlertManager.swift
//  VAT Calculator
//
//  Created by Lap on 14.03.2023.
//

import UIKit

struct AlertManager {
    static func showMainPageAlert(_ vc: UIViewController, textField: UITextField, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Okay", style: .default)
        let clearAction = UIAlertAction(title: "Clear", style: .destructive) {_ in
            textField.text = nil
        }

        alert.addAction(clearAction)
        alert.addAction(okAction)
        vc.present(alert, animated: true)
    }
}
