//
//  CalculatorPageController.swift
//  VAT Calculator
//
//  Created by Lap on 14.03.2023.
//

// TODO: знаки после запятой на втором экране
// TODO: применить вычисляемые свойства в модели
// TODO: добавить поле для тотал ват
// TODO: вывести тотал ват если включен свич
// TODO: скрыть vatOnSc если выключен свич
// TODO: поднимать экран, чтобы было видно вводимое поле

import UIKit

class CalculatorPageController: UIViewController {
    // MARK: - View Lifecycle
    init(vatPercent: Double, feePercent: Double, serviceChargePercent: Double, calculateVatOnSc: Bool) {
        super.init(nibName: nil, bundle: nil)
        calculatorPageModel.initCharges(vatPercent: vatPercent, feePercent: feePercent, serviceChargePercent: serviceChargePercent, calculateVatOnSc: calculateVatOnSc)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        UserDefaultsManager.loadCalculatorPageGrossSales(&calculatorPageModel)
        updateElements(.initiatedByGross)
    }

    // MARK: - Private properties
    private var calculatorView = CalculatorPageView()
    private var calculatorPageModel = CalculatorPageModel()
}

// MARK: - Private methods
private extension CalculatorPageController {
    func initialize() {
        configureNavigationBar()
        initDelegates()
        
        view.addSubview(calculatorView)
        calculatorView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configureNavigationBar() {
        navigationItem.title = UIConstants.calculatorPageNavigationTitle
    }
    
    func initDelegates() {
        calculatorView.netAmountTF.delegate = self
        calculatorView.grossAmountTF.delegate = self
    }
    
    func updateNet(_ calculatorUpdateType: CalculatorUpdateType) {
        let net = calculatorPageModel.getNet(calculatorUpdateType)
        let netText = String(format: "%.2f", net)
        calculatorView.netAmountTF.text = netText
    }
    
    func updateVat(_ calculatorUpdateType: CalculatorUpdateType) {
        let vat = calculatorPageModel.getVat(calculatorUpdateType)
        let vatText = String(format: "%.2f", vat)
        calculatorView.vatAmountLabel.text = vatText
    }
    
    func updateFee(_ calculatorUpdateType: CalculatorUpdateType) {
        let fee = calculatorPageModel.getFee(calculatorUpdateType)
        let feeText = String(format: "%.2f", fee)
        calculatorView.feeAmountLabel.text = feeText
    }
    
    func updateServiceCharge(_ calculatorUpdateType: CalculatorUpdateType) {
        let serviceCharge = calculatorPageModel.getServiceCharge(calculatorUpdateType)
        let serviceChargeText = String(format: "%.2f", serviceCharge)
        calculatorView.serviceChargeAmountLabel.text = serviceChargeText
    }
    
    func updateVatOnServiceCharge(_ calculatorUpdateType: CalculatorUpdateType) {
        let vatOnSc = calculatorPageModel.getVatOnSc(calculatorUpdateType)
        let vatOnScText = String(format: "%.2f", vatOnSc)
        calculatorView.vatOnScAmountLabel.text = vatOnScText
    }
    
    func updateGross(_ calculatorUpdateType: CalculatorUpdateType) {        
        let gross = calculatorPageModel.getGross(calculatorUpdateType)
        let grossText = String(format: "%.2f", gross)
        calculatorView.grossAmountTF.text = grossText
    }
    
    func updateElements(_ calculatorUpdateType: CalculatorUpdateType) {
        updateNet(calculatorUpdateType)
        updateGross(calculatorUpdateType)
        updateVat(calculatorUpdateType)
        updateFee(calculatorUpdateType)
        updateServiceCharge(calculatorUpdateType)
        updateVatOnServiceCharge(calculatorUpdateType)
    }
}

extension CalculatorPageController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }

    func getChoosenTextField(_ textField: UITextField) -> String {
        let field: String
        switch textField {
        case calculatorView.netAmountTF:
            field = String(UIConstants.netName.dropLast(3))
        case calculatorView.grossAmountTF:
            field = String(UIConstants.grossName.dropLast(3))
        default:
            field = "some"
        }
        return field
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        guard let text = textField.text else { return true }
        guard !text.isEmpty else { return true }
        var result = true
        if Double(text) == nil {
            let field = getChoosenTextField(textField)
            let alert = AlertManager.incorrectValueAlert(field: field, textField: textField)
            present(alert, animated: true)
            result = false
        }
        return result
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }

        switch textField {
        case calculatorView.netAmountTF:
            let netSales = Double(text) ?? 0.0
            calculatorPageModel.setNet(netSales)
            updateElements(.initiatedByNet)
        case calculatorView.grossAmountTF:
            let grossSales = Double(text) ?? 0
            calculatorPageModel.setGross(grossSales)
            updateElements(.initiatedByGross)
        default: return
        }
        
        UserDefaultsManager.saveCalculatorPageGrossSales(calculatorPageModel.getGross(.initiatedByGross))
    }
}
