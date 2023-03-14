//
//  CalculatorPageController.swift
//  VAT Calculator
//
//  Created by Lap on 14.03.2023.
//

// TODO: знаки после запятой на втором экране

import UIKit

class CalculatorPageController: UIViewController {
    // MARK: - Publ properties

    
    // MARK: - View Lifecycle
    init(vatPercent: Double, feePercent: Double, serviceChargePercent: Double, calculateVatOnSc: Bool) {
        super.init(nibName: nil, bundle: nil)
        self.vatPercent = vatPercent
        self.feePercent = feePercent
        self.serviceChargePercent = serviceChargePercent
        self.calculateVatOnSc = calculateVatOnSc
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()        
    }

    // MARK: - Private properties
    private var vatPercent = 0.0
    private var feePercent = 0.0
    private var serviceChargePercent = 0.0
    private var calculateVatOnSc = false
}

// MARK: - Private methods
private extension CalculatorPageController {
    func initialize() {
        view.backgroundColor = UIConstants.backgroundColor
        navigationItem.title = UIConstants.calculatorPageNavigationTitle
    }
}

extension CalculatorPageController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }

//    func textFieldDidEndEditing(_ textField: UITextField) {
//        guard let text = textField.text else { return }
//
//        switch textField {
//        case netSalesTF:
//            netSales = Double(text) ?? 0
//            vatLabel.text = String(format: "%.2f", (netSales * vat / 100))
//            feeLabel.text = String(format: "%.2f", (netSales * fee / 100))
//            serviceChargeLabel.text = String(format: "%.2f", (netSales * serviceCharge / 100))
//            vatOnServiceChargeLabel.text = String(format: "%.2f", (netSales * serviceCharge / 100 * 5 / 100))
//            grossSalesTextField.text = String(format: "%.2f", (netSales * (100 + vat + fee + serviceCharge + (calculateVatOnSc ? serviceCharge * vat / 100 : 0)) / 100))
//        case grossSalesTextField:
//            grossSales = Double(text) ?? 0
//            vatLabel.text = String(format: "%.2f", (grossSales / (100 + vat + fee + serviceCharge + (calculateVatOnSc ? serviceCharge * vat / 100 : 0)) * vat))
//            feeLabel.text = String(format: "%.2f", (grossSales / (100 + vat + fee + serviceCharge + (calculateVatOnSc ? serviceCharge * vat / 100 : 0)) * fee))
//            serviceChargeLabel.text = String(format: "%.2f", (grossSales / (100 + vat + fee + serviceCharge + (calculateVatOnSc ? serviceCharge * vat / 100 : 0)) * serviceCharge))
//            vatOnServiceChargeLabel.text = String(format: "%.2f", ((grossSales / (100 + vat + fee + serviceCharge + (calculateVatOnSc ? serviceCharge * vat / 100 : 0)) * serviceCharge) * (calculateVatOnSc ? vat / 100 : 0)))
//            netSalesTF.text = String(format: "%.2f", (grossSales / (100 + vat + fee + serviceCharge + (calculateVatOnSc ? serviceCharge * vat / 100 : 0)) * 100))
//        default: return
//        }
//    }
}
