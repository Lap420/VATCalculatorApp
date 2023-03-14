//
//  MainPageController.swift
//  VAT Calculator
//
//  Created by Lap on 12.03.2023.
//

// TODO: beautify view part with constants and etc.

import SnapKit
import UIKit

class MainPageController: UIViewController {
    // MARK: Public methods

    
    // MARK: ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //initialize()
        
        view.backgroundColor = UIConstants.backgroundColor
        navigationItem.title = UIConstants.mainPageNavigationTitle
        self.navigationController?.navigationBar.titleTextAttributes = UIConstants.navigationTitleAttributes
        navigationController?.navigationBar.tintColor = UIConstants.accentColor
        
        loadUserSettings()
        updateElements()
        
        mainView.vatAmountTF.delegate = self
        mainView.feeAmountTF.delegate = self
        mainView.serviceChargeAmountTF.delegate = self
        mainView.vatOnScSwitch.addTarget(nil, action: #selector(vatOnScSwitched), for: .valueChanged)
        mainView.openCalculatorButton.addTarget(nil, action: #selector(openCalculatorButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Private properties
    private let userDefaults = UserDefaults.standard
    private let mainView = MainPageView()
    
    private var vatPercent = 0.0
    private var feePercent = 0.0
    private var serviceChargePercent = 0.0
    private var calculateVatOnSc = false
}


// MARK: Private methods
private extension MainPageController {
    
    
    func updateSlider() {
        var isEnabled = false
        if let serviceChargeAmount = Double(mainView.serviceChargeAmountTF.text ?? "0") {
            isEnabled = serviceChargeAmount > 0.0
        }
        mainView.vatOnScSwitch.isEnabled = isEnabled
        mainView.vatOnScNameLabel.isEnabled = isEnabled
    }
    
    func updateGross() {
        vatPercent = Double(mainView.vatAmountTF.text ?? "0") ?? 0.0
        feePercent = Double(mainView.feeAmountTF.text ?? "0") ?? 0.0
        serviceChargePercent = Double(mainView.serviceChargeAmountTF.text ?? "0") ?? 0.0
        calculateVatOnSc = mainView.vatOnScSwitch.isOn
        let vatOnSc = calculateVatOnSc ? serviceChargePercent * vatPercent / 100.0 : 0.0
        let gross = 100.0 + vatPercent + feePercent + serviceChargePercent + vatOnSc
        mainView.grossAmountLabel.text = "\(gross.formatted(.number))"
    }
    
    func updateElements() {
        updateSlider()
        updateGross()
    }
    
    func loadUserSettings() {
        mainView.vatAmountTF.text = userDefaults.string(forKey: TaxKeys.vat.rawValue)
        mainView.feeAmountTF.text = userDefaults.string(forKey: TaxKeys.fee.rawValue)
        mainView.serviceChargeAmountTF.text = userDefaults.string(forKey: TaxKeys.serviceCharge.rawValue)
        mainView.vatOnScSwitch.isOn = userDefaults.bool(forKey: TaxKeys.vatOnSc.rawValue)
    }
    
    func updateUserDefaults(_ textField: UITextField) {
        let userDefaultsValue = textField.text ?? ""
        let userDefaultsKey: String
        
        switch textField {
        case mainView.vatAmountTF:
            userDefaultsKey = TaxKeys.vat.rawValue
        case mainView.feeAmountTF:
            userDefaultsKey = TaxKeys.fee.rawValue
        case mainView.serviceChargeAmountTF:
            userDefaultsKey = TaxKeys.serviceCharge.rawValue
        default:
            return
        }
        
        userDefaults.set(userDefaultsValue, forKey: userDefaultsKey)
    }
    
    func showAlert(textField: UITextField, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Okay", style: .default)
        let clearAction = UIAlertAction(title: "Clear", style: .destructive) {_ in
            textField.text = nil
        }

        alert.addAction(clearAction)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    @objc func vatOnScSwitched(_ sender: UISwitch) {
        updateElements()
        userDefaults.set(sender.isOn, forKey: TaxKeys.vatOnSc.rawValue)
    }
    
    @objc func openCalculatorButtonTapped() {
        let nextVC = CalculatorPageController(vatPercent: vatPercent,
                                              feePercent: feePercent,
                                              serviceChargePercent: serviceChargePercent,
                                              calculateVatOnSc: calculateVatOnSc)
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension MainPageController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        guard let text = textField.text else { return true }
        let enteredAmount = Double(text) ?? 0.0
        guard enteredAmount > 1000 else { return true }
        
        let field: String
        switch textField {
        case mainView.vatAmountTF:
            field = UIConstants.vatName
        case mainView.feeAmountTF:
            field = UIConstants.feeName
        case mainView.serviceChargeAmountTF:
            field = UIConstants.serviceChargeName
        default:
            field = "some"
        }
        showAlert(textField: textField,
                  title: "Value too high",
                  message: "You entered too high value to \"\(field)\" field")
        return false
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        updateElements()
        updateUserDefaults(textField)
    }
}


