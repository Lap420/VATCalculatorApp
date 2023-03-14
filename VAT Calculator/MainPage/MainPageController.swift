//
//  MainPageController.swift
//  VAT Calculator
//
//  Created by Lap on 12.03.2023.
//
// TODO: знаки после запятой на втором экране
// TODO: save values to defaults
// TODO: beautify view part with constants and etc.

import SnapKit
import UIKit

class MainPageController: UIViewController {
    // MARK: Public methods

    
    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        updateElements()
        
        vatAmountTF.delegate = self
        feeAmountTF.delegate = self
        serviceChargeAmountTF.delegate = self
        vatOnScSwitch.addTarget(nil, action: #selector(vatOnScSwitched), for: .valueChanged)
        openCalculatorButton.addTarget(nil, action: #selector(openCalculatorButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Private constants
    private enum UIConstants {
        static let fontSizeHeader: CGFloat = 20
        static let fontSizeMain: CGFloat = 20
        static let fontSizeButton: CGFloat = 20
        static let menuItemsOffset: CGFloat = 16
        static let contentInset: CGFloat = 16
        static let afterGrossCustomSpacing: CGFloat = 50
    }
    
    // MARK: - Private properties
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
        label.text = "Net, %"
        label.font = .systemFont(ofSize: UIConstants.fontSizeMain, weight: .semibold)
        label.textAlignment = .left
        return label
    }()
    
    private let netAmountLabel: UILabel = {
        let label = UILabel()
        label.text = "100"
        label.font = .systemFont(ofSize: UIConstants.fontSizeMain, weight: .regular)
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
        label.text = "VAT, %"
        label.font = .systemFont(ofSize: UIConstants.fontSizeMain, weight: .semibold)
        label.textAlignment = .left
        return label
    }()
    
    private let vatAmountTF: UITextField = {
        let textField = UITextField()
        textField.text = "5"
        textField.placeholder = "0"
        textField.font = .systemFont(ofSize: UIConstants.fontSizeMain, weight: .regular)
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
        label.text = "Municipality Fee, %"
        label.font = .systemFont(ofSize: UIConstants.fontSizeMain, weight: .semibold)
        label.textAlignment = .left
        return label
    }()
    
    private let feeAmountTF: UITextField = {
        let textField = UITextField()
        textField.placeholder = "0"
        textField.font = .systemFont(ofSize: UIConstants.fontSizeMain, weight: .regular)
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
        label.text = "Service Charge, %"
        label.font = .systemFont(ofSize: UIConstants.fontSizeMain, weight: .semibold)
        label.textAlignment = .left
        return label
    }()
    
    private let serviceChargeAmountTF: UITextField = {
        let textField = UITextField()
        textField.placeholder = "0"
        textField.font = .systemFont(ofSize: UIConstants.fontSizeMain, weight: .regular)
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
        label.text = "VAT on Service charge"
        label.font = .systemFont(ofSize: UIConstants.fontSizeMain, weight: .semibold)
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
        label.text = "Gross, %"
        label.font = .systemFont(ofSize: UIConstants.fontSizeMain, weight: .semibold)
        label.textAlignment = .left
        return label
    }()
    
    private let grossAmountLabel: UILabel = {
        let label = UILabel()
        label.text = "122"
        label.font = .systemFont(ofSize: UIConstants.fontSizeMain, weight: .regular)
        label.textAlignment = .right
        return label
    }()
    
    private let openCalculatorButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Open calculator", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: UIConstants.fontSizeButton, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        //button.backgroundColor = UIColor(hue: 159/359, saturation: 0.88, brightness: 0.47, alpha: 1)
        //button.backgroundColor = UIColor(red: 153/255, green: 204/255, blue: 255/255, alpha: 1)
        button.backgroundColor = .init(named: "AccentColor")
        return button
    }()
}


// MARK: Private methods
private extension MainPageController {
    func initialize() {
        view.backgroundColor = .init(named: "BackgroundColor")
        navigationItem.title = "Main menu"
        let attributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: UIConstants.fontSizeHeader)]
        self.navigationController?.navigationBar.titleTextAttributes = attributes

        navigationController?.navigationBar.tintColor = .black
        
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
        var switchIsOn = false
        if let serviceChargeAmount = Double(serviceChargeAmountTF.text ?? "0") {
            switchIsOn = serviceChargeAmount > 0.0
        }
        vatOnScSwitch.isEnabled = switchIsOn
        vatOnScNameLabel.isEnabled = switchIsOn
    }
    
    func updateGross() {
        let net = 100.0
        let vat = Double(vatAmountTF.text ?? "0") ?? 0.0
        let fee = Double(feeAmountTF.text ?? "0") ?? 0.0
        let sc = Double(serviceChargeAmountTF.text ?? "0") ?? 0.0
        let vatOnSc = vatOnScSwitch.isOn ? sc * vat / 100 : 0.0
        let gross = net + vat + fee + sc + vatOnSc
        grossAmountLabel.text = "\(gross.formatted(.number))"
    }
    
    func updateElements() {
        updateSlider()
        updateGross()
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Okay", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    @objc func vatOnScSwitched() {
        updateElements()
    }
    
    @objc func openCalculatorButtonTapped() {
        showAlert(title: "Pun'k", message: "Sren'k")
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
            field = "\"VAT, %\""
        case feeAmountTF:
            field = "\"Municipality Fee, %\""
        case serviceChargeAmountTF:
            field = "\"Service Charge, %\""
        default:
            field = "some"
        }
        showAlert(title: "Value too high", message: "You entered too high value to \(field) field")
        return false
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        updateElements()
    }
}
