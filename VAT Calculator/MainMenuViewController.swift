//
//  MainMenuViewController.swift
//  VAT Calculator
//
//  Created by Lap on 01.02.2023.
//

import UIKit

class MainMenuViewController: UIViewController {

    @IBOutlet weak var vatTF: UITextField!
    @IBOutlet weak var feeTF: UITextField!
    @IBOutlet weak var serviceChargeTF: UITextField!
    @IBOutlet weak var vatOnSC: UISwitch!
    @IBOutlet weak var grossLabel: UILabel!
    
    var vat = 0.0
    var fee = 0.0
    var serviceCharge = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func backToLoginPageButtonTapped() {
        self.dismiss(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? TestingViewController else { return }
        
        destinationVC.vat = vat
        destinationVC.fee = fee
        destinationVC.serviceCharge = serviceCharge
        destinationVC.calculateVatOnSc = vatOnSC.isOn
    }
    
    @IBAction func goTestingButtonTapped() {
        performSegue(withIdentifier: "goToTesting", sender: nil)
    }
    
    @IBAction func unwindSegueFromTestingToMain(segue: UIStoryboardSegue) {}
    
    @IBAction func vatOnSCSwitched() {
        let gross = 100 + vat + fee + serviceCharge + (vatOnSC.isOn ? serviceCharge * vat / 100 : 0)
        grossLabel.text = "\(gross.formatted(.number))"
    }
}

extension MainMenuViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        switch textField {
        case vatTF:
            vat = Double(text) ?? 0
        case feeTF:
            fee = Double(text) ?? 0
        case serviceChargeTF:
            serviceCharge = Double(text) ?? 0
        default: return
        }
        
        let gross = 100 + vat + fee + serviceCharge + (vatOnSC.isOn ? serviceCharge * vat / 100 : 0)
        grossLabel.text = "\(gross.formatted(.number))"
    }
}
