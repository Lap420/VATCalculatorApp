//
//  CalculatorPageController.swift
//  VAT Calculator
//
//  Created by Lap on 14.03.2023.
//

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
    }

    // MARK: - Private properties
    private var calculatorPageView = CalculatorPageView()
    private var calculatorPageModel = CalculatorPageModel()
    private var rounding = 2
}

// MARK: - Private methods
private extension CalculatorPageController {
    func initialize() {
        view.backgroundColor = UIConstants.backgroundColor
        UserDefaultsManager.loadCalculatorPageGrossSales(&calculatorPageModel)
        disableZeroLines()
        hideOrShowZeroLines(UserDefaultsManager.loadSettingsPageHideZeroLines())
        rounding = UserDefaultsManager.loadSettingsPageRounding()
        updateElements(.initiatedByGross)
        configureNavigationBar()
        initDelegates()
        
        view.addSubview(calculatorPageView)
        calculatorPageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview().inset(UIConstants.contentHorizontalInset)
        }
    }
    
    
    func disableZeroLines() {
        if calculatorPageModel.vatPercent == 0 {
            calculatorPageView.vatNameLabel.isEnabled = false
            calculatorPageView.vatAmountLabel.isEnabled = false
        }
        if calculatorPageModel.feePercent == 0 {
            calculatorPageView.feeNameLabel.isEnabled = false
            calculatorPageView.feeAmountLabel.isEnabled = false
        }
        if calculatorPageModel.serviceChargePercent == 0 {
            calculatorPageView.serviceChargeNameLabel.isEnabled = false
            calculatorPageView.serviceChargeAmountLabel.isEnabled = false
        }
        if !calculatorPageModel.calculateVatOnSc || calculatorPageModel.serviceChargePercent == 0 || calculatorPageModel.vatPercent == 0 {
            calculatorPageView.vatOnScNameLabel.isEnabled = false
            calculatorPageView.vatOnScAmountLabel.isEnabled = false
            calculatorPageView.totalVatStack.isHidden = true
        }
    }
    
    func hideOrShowZeroLines(_ hideZeroLines: Bool) {
        if calculatorPageModel.vatPercent == 0 {
            calculatorPageView.vatStack.isHidden = hideZeroLines
        }
        if calculatorPageModel.feePercent == 0 {
            calculatorPageView.feeStack.isHidden = hideZeroLines
        }
        if calculatorPageModel.serviceChargePercent == 0 {
            calculatorPageView.serviceChargeStack.isHidden = hideZeroLines
        }
        if !calculatorPageModel.calculateVatOnSc || calculatorPageModel.serviceChargePercent == 0 || calculatorPageModel.vatPercent == 0 {
            calculatorPageView.vatOnScStack.isHidden = hideZeroLines
        }
    }
    
    func configureNavigationBar() {
        navigationItem.title = UIConstants.calculatorPageNavigationTitle
        let settingsButton = UIBarButtonItem(image: .init(systemName: UIConstants.settingsIconName), style: .plain, target: self, action: #selector(openCalculatorSettingButtonTapped))
        navigationItem.setRightBarButton(settingsButton, animated: true)
    }
    
    func initDelegates() {
        calculatorPageView.netAmountTF.delegate = self
        calculatorPageView.grossAmountTF.delegate = self
    }
    
    func updateNet(_ calculatorUpdateType: CalculatorUpdateType) {
        let net = calculatorPageModel.getNet(calculatorUpdateType)
        let netText = String(format: "%.\(rounding)f", net)
        calculatorPageView.netAmountTF.text = netText
    }
    
    func updateVat(_ calculatorUpdateType: CalculatorUpdateType) {
        let vat = calculatorPageModel.getVat(calculatorUpdateType)
        let vatText = String(format: "%.\(rounding)f", vat)
        calculatorPageView.vatAmountLabel.text = vatText
    }
    
    func updateFee(_ calculatorUpdateType: CalculatorUpdateType) {
        let fee = calculatorPageModel.getFee(calculatorUpdateType)
        let feeText = String(format: "%.\(rounding)f", fee)
        calculatorPageView.feeAmountLabel.text = feeText
    }
    
    func updateServiceCharge(_ calculatorUpdateType: CalculatorUpdateType) {
        let serviceCharge = calculatorPageModel.getServiceCharge(calculatorUpdateType)
        let serviceChargeText = String(format: "%.\(rounding)f", serviceCharge)
        calculatorPageView.serviceChargeAmountLabel.text = serviceChargeText
    }
    
    func updateVatOnServiceCharge(_ calculatorUpdateType: CalculatorUpdateType) {
        let vatOnSc = calculatorPageModel.getVatOnSc(calculatorUpdateType)
        let vatOnScText = String(format: "%.\(rounding)f", vatOnSc)
        calculatorPageView.vatOnScAmountLabel.text = vatOnScText
    }
    
    func updateTotalVat(_ calculatorUpdateType: CalculatorUpdateType) {
        let totalVat = calculatorPageModel.getTotalVat(calculatorUpdateType)
        let totalVatText = String(format: "%.\(rounding)f", totalVat)
        calculatorPageView.totalVatAmountLabel.text = totalVatText
    }
    
    func updateGross(_ calculatorUpdateType: CalculatorUpdateType) {        
        let gross = calculatorPageModel.getGross(calculatorUpdateType)
        let grossText = String(format: "%.\(rounding)f", gross)
        calculatorPageView.grossAmountTF.text = grossText
    }
    
    func updateElements(_ calculatorUpdateType: CalculatorUpdateType) {
        updateNet(calculatorUpdateType)
        updateGross(calculatorUpdateType)
        updateVat(calculatorUpdateType)
        updateFee(calculatorUpdateType)
        updateServiceCharge(calculatorUpdateType)
        updateVatOnServiceCharge(calculatorUpdateType)
        updateTotalVat(calculatorUpdateType)
    }
    
    @objc func openCalculatorSettingButtonTapped() {
        let nextVC = SettingsPageController()
        nextVC.calculatorPageDelegate = self
        self.navigationController?.pushViewController(nextVC, animated: true)
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
        case calculatorPageView.netAmountTF:
            field = String(UIConstants.netName.dropLast(3))
        case calculatorPageView.grossAmountTF:
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
        case calculatorPageView.netAmountTF:
            let netSales = Double(text) ?? 0.0
            calculatorPageModel.setNet(netSales)
            updateElements(.initiatedByNet)
        case calculatorPageView.grossAmountTF:
            let grossSales = Double(text) ?? 0
            calculatorPageModel.setGross(grossSales)
            updateElements(.initiatedByGross)
        default: return
        }
        
        UserDefaultsManager.saveCalculatorPageGrossSales(calculatorPageModel.getGross(.initiatedByGross))
    }
}

extension CalculatorPageController: CalculatorPageDelegate {
    func updateRounding(_ rounding: Int) {
        self.rounding = rounding
        updateElements(.initiatedByGross)
    }
    
    func updateHideZeroLines(_ hideZeroLines: Bool) {
        hideOrShowZeroLines(hideZeroLines)
    }
}

protocol CalculatorPageDelegate {
    func updateRounding(_ rounding: Int)
    func updateHideZeroLines(_ hideZeroLines: Bool)
}
