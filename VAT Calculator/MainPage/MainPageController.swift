//
//  MainPageController.swift
//  VAT Calculator
//
//  Created by Lap on 12.03.2023.
//

// TODO: отдать модели расчет гросса и состояния свича
// TODO: реализовать алерты через протокол, чтобы каждый экран реализовал метод getChoosenTextField у протокола

import SnapKit
import UIKit

class MainPageController: UIViewController {
    // MARK: ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
        UserDefaultsManager.loadMainPageData(mainView)
        updateElements()
    }
    
    // MARK: - Private properties
    private let mainView = MainPageView()
    private var vatPercent = 0.0
    private var feePercent = 0.0
    private var serviceChargePercent = 0.0
    private var calculateVatOnSc = false
}


// MARK: Private methods
private extension MainPageController {
    func configureNavigationBar() {
        navigationItem.title = UIConstants.mainPageNavigationTitle
        self.navigationController?.navigationBar.titleTextAttributes = UIConstants.navigationTitleAttributes
        navigationController?.navigationBar.tintColor = UIConstants.accentColor
    }
    
    func initialize() {
        configureNavigationBar()
        
        view.addSubview(mainView)
        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        mainView.vatAmountTF.delegate = self
        mainView.feeAmountTF.delegate = self
        mainView.serviceChargeAmountTF.delegate = self
        mainView.vatOnScSwitch.addTarget(nil, action: #selector(vatOnScSwitched), for: .valueChanged)
        mainView.openCalculatorButton.addTarget(nil, action: #selector(openCalculatorButtonTapped), for: .touchUpInside)
    }
    
    func updateSlider() {
        var isEnabled = false
        if let serviceChargeAmount = Double(mainView.serviceChargeAmountTF.text ?? "0"),
            let vatAmount = Double(mainView.vatAmountTF.text ?? "0") {
            isEnabled = serviceChargeAmount > 0.0 && vatAmount > 0.0
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
    
    @objc func vatOnScSwitched(_ sender: UISwitch) {
        updateElements()
        UserDefaultsManager.saveMainPageSwitchData(sender.isOn)
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
    
    func getChoosenTextField(_ textField: UITextField) -> String {
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
        return field
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        guard let text = textField.text else { return true }
        guard !text.isEmpty else { return true }
        if let enteredAmount = Double(text) {
            guard enteredAmount > 1000 else { return true }
        
            let field = getChoosenTextField(textField)
            AlertManager.showMainPageAlert(self,
                                           textField: textField,
                                           title: "Value too high",
                                           message: "The number you entered in \"\(field)\" field is too large")
        } else {
            let field = getChoosenTextField(textField)
            AlertManager.showMainPageAlert(self,
                                           textField: textField,
                                           title: "Incorrect value",
                                           message: "The value you entered in \"\(field)\" field is not a number")
        }
        return false
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        updateElements()
        UserDefaultsManager.saveMainPageTFData(mainView, textField: textField)
    }
}
