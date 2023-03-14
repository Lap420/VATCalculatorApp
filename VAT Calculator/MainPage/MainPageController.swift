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

    
    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        
        view.backgroundColor = UIConstants.backgroundColor
        navigationItem.title = UIConstants.mainPageNavigationTitle
        self.navigationController?.navigationBar.titleTextAttributes = UIConstants.navigationTitleAttributes
        navigationController?.navigationBar.tintColor = UIConstants.accentColor
        
        loadUserSettings()
        updateElements()
        
        vatAmountTF.delegate = self
        feeAmountTF.delegate = self
        serviceChargeAmountTF.delegate = self
        vatOnScSwitch.addTarget(nil, action: #selector(vatOnScSwitched), for: .valueChanged)
        openCalculatorButton.addTarget(nil, action: #selector(openCalculatorButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Private properties
    private let userDefaults = UserDefaults.standard
    private var vatPercent = 0.0
    private var feePercent = 0.0
    private var serviceChargePercent = 0.0
    private var calculateVatOnSc = false
    
    private let mainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = UIConstants.menuItemsOffset
        stack.alignment = .center
        return stack
    }()
    
    private let netStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        return stack
    }()
    
    private let netNameLabel: UILabel = {
        let label = UILabel()
        label.text = UIConstants.netName
        label.font = UIConstants.fontSemibold
        label.textAlignment = .left
        return label
    }()
    
    private let netAmountLabel: UILabel = {
        let label = UILabel()
        label.text = UIConstants.netAmount
        label.font = UIConstants.fontRegular
        label.textAlignment = .right
        return label
    }()
    
    private let vatStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        return stack
    }()
    
    private let vatNameLabel: UILabel = {
        let label = UILabel()
        label.text = UIConstants.vatName
        label.font = UIConstants.fontSemibold
        label.textAlignment = .left
        return label
    }()
    
    private let vatAmountTF: UITextField = {
        let textField = UITextField()
        textField.placeholder = UIConstants.placeholder
        textField.font = UIConstants.fontRegular
        textField.textAlignment = .right
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .whileEditing
        textField.keyboardType = .decimalPad
        textField.returnKeyType = .next
        return textField
    }()
    
    private let feeStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        return stack
    }()
    
    private let feeNameLabel: UILabel = {
        let label = UILabel()
        label.text = UIConstants.feeName
        label.font = UIConstants.fontSemibold
        label.textAlignment = .left
        return label
    }()
    
    private let feeAmountTF: UITextField = {
        let textField = UITextField()
        textField.placeholder = UIConstants.placeholder
        textField.font = UIConstants.fontRegular
        textField.textAlignment = .right
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .whileEditing
        textField.keyboardType = .decimalPad
        textField.returnKeyType = .next
        return textField
    }()
    
    private let serviceChargeStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        return stack
    }()
    
    private let serviceChargeNameLabel: UILabel = {
        let label = UILabel()
        label.text = UIConstants.serviceChargeName
        label.font = UIConstants.fontSemibold
        label.textAlignment = .left
        return label
    }()
    
    private let serviceChargeAmountTF: UITextField = {
        let textField = UITextField()
        textField.placeholder = UIConstants.placeholder
        textField.font = UIConstants.fontRegular
        textField.textAlignment = .right
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .whileEditing
        textField.keyboardType = .decimalPad
        textField.returnKeyType = .done
        return textField
    }()
    
    private let vatOnScStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        return stack
    }()
    
    private let vatOnScNameLabel: UILabel = {
        let label = UILabel()
        label.text = UIConstants.vatOnScName
        label.font = UIConstants.fontSemibold
        label.textAlignment = .left
        return label
    }()
    
    private let vatOnScSwitch: UISwitch = {
        let swich = UISwitch()
        swich.isOn = true
        return swich
    }()
    
    private let grossStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        return stack
    }()
    
    private let grossNameLabel: UILabel = {
        let label = UILabel()
        label.text = UIConstants.grossName
        label.font = UIConstants.fontSemibold
        label.textAlignment = .left
        return label
    }()
    
    private let grossAmountLabel: UILabel = {
        let label = UILabel()
        label.font = UIConstants.fontRegular
        label.textAlignment = .right
        return label
    }()
    
    private let openCalculatorButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(UIConstants.buttonTitle, for: .normal)
        button.titleLabel?.font = UIConstants.buttonFont
        button.setTitleColor(UIConstants.buttonTitleColor, for: .normal)
        button.layer.cornerRadius = UIConstants.buttonCornerRadius
        button.backgroundColor = UIConstants.accentColor
        return button
    }()
}


// MARK: Private methods
private extension MainPageController {
    func initialize() {
        mainStack.addArrangedSubview(netStack)
        mainStack.addArrangedSubview(vatStack)
        mainStack.addArrangedSubview(feeStack)
        mainStack.addArrangedSubview(serviceChargeStack)
        mainStack.addArrangedSubview(vatOnScStack)
        mainStack.addArrangedSubview(grossStack)
        mainStack.setCustomSpacing(UIConstants.afterGrossCustomSpacing, after: grossStack)
        mainStack.addArrangedSubview(openCalculatorButton)
        view.addSubview(mainStack)
        mainStack.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(UIConstants.contentInset)
        }
        
        netStack.addArrangedSubview(netNameLabel)
        netStack.addArrangedSubview(netAmountLabel)
        mainStack.addSubview(netStack)
        netStack.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        vatStack.addArrangedSubview(vatNameLabel)
        vatStack.addArrangedSubview(vatAmountTF)
        vatAmountTF.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
        mainStack.addSubview(vatStack)
        vatStack.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }

        feeStack.addArrangedSubview(feeNameLabel)
        feeStack.addArrangedSubview(feeAmountTF)
        feeAmountTF.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
        mainStack.addSubview(feeStack)
        feeStack.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        serviceChargeStack.addArrangedSubview(serviceChargeNameLabel)
        serviceChargeStack.addArrangedSubview(serviceChargeAmountTF)
        serviceChargeAmountTF.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
        mainStack.addSubview(serviceChargeStack)
        serviceChargeStack.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        vatOnScStack.addArrangedSubview(vatOnScNameLabel)
        vatOnScStack.addArrangedSubview(vatOnScSwitch)
        mainStack.addSubview(vatOnScStack)
        vatOnScStack.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        grossStack.addArrangedSubview(grossNameLabel)
        grossStack.addArrangedSubview(grossAmountLabel)
        mainStack.addSubview(grossStack)
        grossStack.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        openCalculatorButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(250)
        }
    }
    
    func updateSlider() {
        var isEnabled = false
        if let serviceChargeAmount = Double(serviceChargeAmountTF.text ?? "0") {
            isEnabled = serviceChargeAmount > 0.0
        }
        vatOnScSwitch.isEnabled = isEnabled
        vatOnScNameLabel.isEnabled = isEnabled
    }
    
    func updateGross() {
        vatPercent = Double(vatAmountTF.text ?? "0") ?? 0.0
        feePercent = Double(feeAmountTF.text ?? "0") ?? 0.0
        serviceChargePercent = Double(serviceChargeAmountTF.text ?? "0") ?? 0.0
        calculateVatOnSc = vatOnScSwitch.isOn
        let vatOnSc = calculateVatOnSc ? serviceChargePercent * vatPercent / 100.0 : 0.0
        let gross = 100.0 + vatPercent + feePercent + serviceChargePercent + vatOnSc
        grossAmountLabel.text = "\(gross.formatted(.number))"
    }
    
    func updateElements() {
        updateSlider()
        updateGross()
    }
    
    func loadUserSettings() {
        vatAmountTF.text = userDefaults.string(forKey: TaxKeys.vat.rawValue)
        feeAmountTF.text = userDefaults.string(forKey: TaxKeys.fee.rawValue)
        serviceChargeAmountTF.text = userDefaults.string(forKey: TaxKeys.serviceCharge.rawValue)
        vatOnScSwitch.isOn = userDefaults.bool(forKey: TaxKeys.vatOnSc.rawValue)
    }
    
    func updateUserDefaults(_ textField: UITextField) {
        let userDefaultsValue = textField.text ?? ""
        let userDefaultsKey: String
        
        switch textField {
        case vatAmountTF:
            userDefaultsKey = TaxKeys.vat.rawValue
        case feeAmountTF:
            userDefaultsKey = TaxKeys.fee.rawValue
        case serviceChargeAmountTF:
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
        case vatAmountTF:
            field = UIConstants.vatName
        case feeAmountTF:
            field = UIConstants.feeName
        case serviceChargeAmountTF:
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


