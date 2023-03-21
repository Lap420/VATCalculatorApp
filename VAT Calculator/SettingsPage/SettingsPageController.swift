//
//  SettingsController.swift
//  VAT Calculator
//
//  Created by Lap on 16.03.2023.
//

import UIKit

class SettingsPageController: UIViewController {
    // MARK: - Private properties
    var calculatorPageDelegate: CalculatorPageDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    // MARK: - Private properties
    private var settingsPageView = SettingsPageView()
    private var rounding = 0
    private var hideZeroLines = false
}

// MARK: - Private methods
private extension SettingsPageController {
    func initialize() {
        view.backgroundColor = UIConstants.backgroundColor
        configureNavigationBar()
        initElements()
        initButtonTargets()

        view.addSubview(settingsPageView)
        settingsPageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview().inset(UIConstants.contentHorizontalInset)
        }
    }
    
    func configureNavigationBar() {
        navigationItem.title = UIConstants.settingsPageNavigationTitle
    }
    
    func initElements() {
        rounding = UserDefaultsManager.loadSettingsPageRounding()
        settingsPageView.roundingAmountLabel.text = String(rounding)
        settingsPageView.roundingStepper.value = Double(rounding)
        hideZeroLines = UserDefaultsManager.loadSettingsPageHideZeroLines()
        settingsPageView.hideZeroLinesSwitch.isOn = hideZeroLines
    }
    
    func initButtonTargets() {
        settingsPageView.hideZeroLinesSwitch.addTarget(self, action: #selector(hideZeroLinesSwitched), for: .valueChanged)
        settingsPageView.roundingStepper.addTarget(self, action: #selector(roundingStepperClicked), for: .valueChanged)
    }
    
    @objc func roundingStepperClicked(_ sender: UIStepper) {
        let value = Int(sender.value)
        settingsPageView.roundingAmountLabel.text = String(value)
        UserDefaultsManager.saveSettingsPageRounding(value)
        calculatorPageDelegate?.updateRounding(value)
    }
    
    @objc func hideZeroLinesSwitched(_ sender: UISwitch) {
        let isOn = sender.isOn
        UserDefaultsManager.saveSettingsPageHideZeroLines(isOn)
        calculatorPageDelegate?.updateHideZeroLines(isOn)
    }
}
