//
//  CalculatorPageController.swift
//  VAT Calculator
//
//  Created by Lap on 14.03.2023.
//

// TODO: знаки после запятой на втором экране
// TODO: отдать модели расчет гросса и состояния свича
// TODO: автоочистка текст филдов

import UIKit

class CalculatorPageController: UIViewController {
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
    private let calculatorView = CalculatorPageView()
    private var vatPercent = 0.0
    private var feePercent = 0.0
    private var serviceChargePercent = 0.0
    private var netSales = 0.0
    private var grossSales = 0.0
    private var calculateVatOnSc = false
}

// MARK: - Private methods
private extension CalculatorPageController {
    func configureNavigationBar() {
        navigationItem.title = UIConstants.calculatorPageNavigationTitle
    }
    
    func initialize() {
        configureNavigationBar()
        
        view.addSubview(calculatorView)
        calculatorView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        calculatorView.netAmountTF.delegate = self
        calculatorView.grossAmountTF.delegate = self
    }
    
//    func updateGross() {
//        vatPercent = Double(mainView.vatAmountTF.text ?? "0") ?? 0.0
//        feePercent = Double(mainView.feeAmountTF.text ?? "0") ?? 0.0
//        serviceChargePercent = Double(mainView.serviceChargeAmountTF.text ?? "0") ?? 0.0
//        calculateVatOnSc = mainView.vatOnScSwitch.isOn
//        let vatOnSc = calculateVatOnSc ? serviceChargePercent * vatPercent / 100.0 : 0.0
//        let gross = 100.0 + vatPercent + feePercent + serviceChargePercent + vatOnSc
//        mainView.grossAmountLabel.text = "\(gross.formatted(.number))"
//    }
//    
//    func updateElements() {
//        updateSlider()
//        updateGross()
//    }
}

extension CalculatorPageController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        guard let text = textField.text else { return true }
        guard !text.isEmpty else { return true }
        var result = true
        if Double(text) == nil {
            let field: String
            switch textField {
            case calculatorView.netAmountTF:
                field = String(UIConstants.netName.dropLast(3))
            case calculatorView.grossAmountTF:
                field = String(UIConstants.grossName.dropLast(3))
            default:
                field = "some"
            }
            AlertManager.showMainPageAlert(self,
                                           textField: textField,
                                           title: "Incorrect value",
                                           message: "The value you entered in \"\(field)\" field is not a number")
            result = false
        }
        return result
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }

        switch textField {
        case calculatorView.netAmountTF:
            netSales = Double(text) ?? 0.0
            let netText = String(format: "%.2f", netSales)
            let vatText = String(format: "%.2f", netSales * vatPercent / 100)
            let feeText = String(format: "%.2f", netSales * feePercent / 100)
            let scText = String(format: "%.2f", netSales * serviceChargePercent / 100)
            let vatOnScText = String(format: "%.2f", netSales * serviceChargePercent / 100 * (calculateVatOnSc ? vatPercent / 100 : 0))
            grossSales = netSales * (100 + vatPercent + feePercent + serviceChargePercent + (calculateVatOnSc ? serviceChargePercent * vatPercent / 100 : 0)) / 100
            let grossText = String(format: "%.2f", grossSales)
            calculatorView.netAmountTF.text = netText
            calculatorView.vatAmountLabel.text = vatText
            calculatorView.feeAmountLabel.text = feeText
            calculatorView.serviceChargeAmountLabel.text = scText
            calculatorView.vatOnScAmountLabel.text = vatOnScText
            calculatorView.grossAmountTF.text = grossText
        case calculatorView.grossAmountTF:
            grossSales = Double(text) ?? 0
            netSales = grossSales / (100 + vatPercent + feePercent + serviceChargePercent + (calculateVatOnSc ? serviceChargePercent * vatPercent / 100 : 0)) * 100
            let netText = String(format: "%.2f", netSales)
            let vatText = String(format: "%.2f", grossSales / (100 + vatPercent + feePercent + serviceChargePercent + (calculateVatOnSc ? serviceChargePercent * vatPercent / 100 : 0)) * vatPercent)
            let feeText = String(format: "%.2f", grossSales / (100 + vatPercent + feePercent + serviceChargePercent + (calculateVatOnSc ? serviceChargePercent * vatPercent / 100 : 0)) * feePercent)
            let scText = String(format: "%.2f", grossSales / (100 + vatPercent + feePercent + serviceChargePercent + (calculateVatOnSc ? serviceChargePercent * vatPercent / 100 : 0)) * serviceChargePercent)
            let vatOnScText = String(format: "%.2f", (grossSales / (100 + vatPercent + feePercent + serviceChargePercent + (calculateVatOnSc ? serviceChargePercent * vatPercent / 100 : 0)) * serviceChargePercent) * (calculateVatOnSc ? vatPercent / 100 : 0))
            let grossText = String(format: "%.2f", grossSales)
            calculatorView.netAmountTF.text = netText
            calculatorView.vatAmountLabel.text = vatText
            calculatorView.feeAmountLabel.text = feeText
            calculatorView.serviceChargeAmountLabel.text = scText
            calculatorView.vatOnScAmountLabel.text = vatOnScText
            calculatorView.grossAmountTF.text = grossText
        default: return
        }
    }
}
