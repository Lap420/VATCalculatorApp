//
//  TestingViewController.swift
//  VAT Calculator
//
//  Created by Lap on 02.02.2023.
//

import UIKit

class TestingViewController: UIViewController {

    @IBOutlet weak var netSalesTF: UITextField!
    @IBOutlet weak var vatLabel: UILabel!
    @IBOutlet weak var feeLabel: UILabel!
    @IBOutlet weak var serviceChargeLabel: UILabel!
    @IBOutlet weak var vatOnServiceChargeLabel: UILabel!
    @IBOutlet weak var grossSalesTextField: UITextField!
    
    var netSales = 0.0
    var vat = 0.0
    var fee = 0.0
    var serviceCharge = 0.0
    var calculateVatOnSc = true
    var grossSales = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
/// HUUUUUUUUUUUUUUUUUUUUUUMUS
extension TestingViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        switch textField {
        case netSalesTF:
            netSales = Double(text) ?? 0
            vatLabel.text = String(format: "%.2f", (netSales * vat / 100))
            feeLabel.text = String(format: "%.2f", (netSales * fee / 100))
            serviceChargeLabel.text = String(format: "%.2f", (netSales * serviceCharge / 100))
            vatOnServiceChargeLabel.text = String(format: "%.2f", (netSales * serviceCharge / 100 * 5 / 100))
            grossSalesTextField.text = String(format: "%.2f", (netSales * (100 + vat + fee + serviceCharge + (calculateVatOnSc ? serviceCharge * vat / 100 : 0)) / 100))
        case grossSalesTextField:
            grossSales = Double(text) ?? 0
            vatLabel.text = String(format: "%.2f", (grossSales / (100 + vat + fee + serviceCharge + (calculateVatOnSc ? serviceCharge * vat / 100 : 0)) * vat))
            feeLabel.text = String(format: "%.2f", (grossSales / (100 + vat + fee + serviceCharge + (calculateVatOnSc ? serviceCharge * vat / 100 : 0)) * fee))
            serviceChargeLabel.text = String(format: "%.2f", (grossSales / (100 + vat + fee + serviceCharge + (calculateVatOnSc ? serviceCharge * vat / 100 : 0)) * serviceCharge))
            vatOnServiceChargeLabel.text = String(format: "%.2f", ((grossSales / (100 + vat + fee + serviceCharge + (calculateVatOnSc ? serviceCharge * vat / 100 : 0)) * serviceCharge) * (calculateVatOnSc ? vat / 100 : 0)))
            netSalesTF.text = String(format: "%.2f", (grossSales / (100 + vat + fee + serviceCharge + (calculateVatOnSc ? serviceCharge * vat / 100 : 0)) * 100))
        default: return
        }
    }
}
