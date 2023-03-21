//
//  MainPageController.swift
//  VAT Calculator
//
//  Created by Lap on 12.03.2023.
//

import SnapKit
import UIKit

class MainPageController: UIViewController {
    // MARK: ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    // MARK: - Private properties
    private let mainPageView = MainPageView()
    private var mainPageModel = MainPageModel()
}


// MARK: Private methods
private extension MainPageController {
    func initialize() {
        view.backgroundColor = UIConstants.backgroundColor
        checkIsFirstLaunch()
        UserDefaultsManager.loadMainPageData(&mainPageModel)
        initFieldsState()
        updateElements()
        configureNavigationBar()
        initDelegates()
        initButtonTargets()
        
        view.addSubview(mainPageView)
        mainPageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview().inset(UIConstants.contentHorizontalInset)
        }
    }
    
    func checkIsFirstLaunch() {
        let isFirstLaunch = UserDefaultsManager.loadIsFirstLaunch()
        if isFirstLaunch {
            UserDefaultsManager.saveIsFirstLaunch()
            UserDefaultsManager.saveSettingsPageRounding(2)
        }
    }
    
    func configureNavigationBar() {
        navigationItem.title = UIConstants.mainPageNavigationTitle
        navigationController?.navigationBar.titleTextAttributes = UIConstants.navigationTitleAttributes
        navigationController?.navigationBar.tintColor = UIConstants.accentColor
    }
    
    func initFieldsState() {
        mainPageView.vatAmountTF.text = mainPageModel.vatPercent > 0 ? String(mainPageModel.vatPercent.formatted(.number)) : nil
        mainPageView.feeAmountTF.text = mainPageModel.feePercent > 0 ? String(mainPageModel.feePercent.formatted(.number)) : nil
        mainPageView.serviceChargeAmountTF.text = mainPageModel.serviceChargePercent > 0 ? String(mainPageModel.serviceChargePercent.formatted(.number)) : nil
        mainPageView.vatOnScSwitch.isOn = mainPageModel.calculateVatOnSc
    }
    
    func initDelegates() {
        mainPageView.vatAmountTF.delegate = self
        mainPageView.feeAmountTF.delegate = self
        mainPageView.serviceChargeAmountTF.delegate = self
    }
    
    func initButtonTargets() {
        mainPageView.vatOnScSwitch.addTarget(self, action: #selector(vatOnScSwitched), for: .valueChanged)
        mainPageView.openCalculatorButton.addTarget(self, action: #selector(openCalculatorButtonTapped), for: .touchUpInside)
    }
    
    func updateCharges() {
        let vatPercent = Double(mainPageView.vatAmountTF.text ?? "0") ?? 0
        let feePercent = Double(mainPageView.feeAmountTF.text ?? "0") ?? 0
        let serviceChargePercent = Double(mainPageView.serviceChargeAmountTF.text ?? "0") ?? 0
        let calculateVatOnSc = mainPageView.vatOnScSwitch.isOn
        mainPageModel.updateCharges(vatPercent: vatPercent, feePercent: feePercent, serviceChargePercent: serviceChargePercent, calculateVatOnSc: calculateVatOnSc)
    }
    
    func updateSlider() {
        let isEnabled = mainPageModel.vatPercent > 0 && mainPageModel.serviceChargePercent > 0
        mainPageView.vatOnScSwitch.isEnabled = isEnabled
        mainPageView.vatOnScNameLabel.isEnabled = isEnabled
    }
    
    func updateGross() {
        let gross = mainPageModel.calculateGross()
        mainPageView.grossAmountLabel.text = "\(gross.formatted(.number))"
    }
    
    func updateElements() {
        updateCharges()
        updateSlider()
        updateGross()
    }
    
    @objc func vatOnScSwitched(_ sender: UISwitch) {
        updateElements()
        UserDefaultsManager.saveMainPageSwitchData(sender.isOn)
    }
    
    @objc func openCalculatorButtonTapped() {
        let nextVC = CalculatorPageController(vatPercent: mainPageModel.vatPercent,
                                              feePercent: mainPageModel.feePercent,
                                              serviceChargePercent: mainPageModel.serviceChargePercent,
                                              calculateVatOnSc: mainPageModel.calculateVatOnSc)
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
        case mainPageView.vatAmountTF:
            field = UIConstants.vatName
        case mainPageView.feeAmountTF:
            field = UIConstants.feeName
        case mainPageView.serviceChargeAmountTF:
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
            let alert = AlertManager.valueTooHighAlert(field: field, textField: textField)
            present(alert, animated: true)
        } else {
            let field = getChoosenTextField(textField)
            let alert = AlertManager.incorrectValueAlert(field: field, textField: textField)
            present(alert, animated: true)
        }
        return false
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        updateElements()
        UserDefaultsManager.saveMainPageTFData(mainPageView, textField: textField)
    }
}
