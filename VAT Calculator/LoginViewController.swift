//
//  ViewController.swift
//  VAT Calculator
//
//  Created by Lap on 01.02.2023.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func loginButtonTapped() {
        guard loginTF.text == "228" else {
            showAlert(title: "Incorrect id", message: "Please enter correct Telegram id")
            return
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "MainMenuViewControllerIdentifier")
        
        self.present(viewController, animated: true) {
            guard let mainMenuVC = viewController as? MainMenuViewController else { return }
            if self.loginTF.text == "228" {
                mainMenuVC.vatTF.text = "5"
                mainMenuVC.feeTF.text = "7"
                mainMenuVC.serviceChargeTF.text = "10"
                mainMenuVC.vatOnSC.isOn = true
                mainMenuVC.vat = 5
                mainMenuVC.fee = 7
                mainMenuVC.serviceCharge = 10
                let gross = 100 + mainMenuVC.vat + mainMenuVC.fee + mainMenuVC.serviceCharge + (mainMenuVC.vatOnSC.isOn ? mainMenuVC.serviceCharge * mainMenuVC.vat / 100 : 0)
                mainMenuVC.grossLabel.text = "\(gross.formatted(.number))"
            }
        }
    }
    
    @IBAction func skipButtonTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "MainMenuViewControllerIdentifier")
        
        present(viewController, animated: true)
    }
}

extension LoginViewController {
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Okay", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

extension LoginViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginTF {
            loginButtonTapped()
        } else {
            view.endEditing(true)
        }
        return true
    }
}
