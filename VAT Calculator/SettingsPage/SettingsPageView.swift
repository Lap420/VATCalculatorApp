//
//  SettingsView.swift
//  VAT Calculator
//
//  Created by Lap on 16.03.2023.
//

import UIKit

class SettingsPageView: UIView {

    // MARK: - Public properties
    let roundingAmountLabel: UILabel = {
        let label = UILabel()
        label.text = String(UIConstants.vatName.dropLast(3))
        label.font = UIConstants.fontRegular
        label.textAlignment = .right
        return label
    }()
    
    let roundingStepper: UIStepper = {
        let stepper = UIStepper()
        stepper.maximumValue = UIConstants.stepperMaximumValue
        return stepper
    }()
    
    let hideZeroLinesSwitch: UISwitch = {
        let swich = UISwitch()
        swich.isOn = true
        return swich
    }()
    
    // MARK: - View Lifecycle
    init() {
        super.init(frame: .zero)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private properties
    private let mainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = UIConstants.menuItemsOffset
        stack.alignment = .center
        return stack
    }()
    
    private let roundingStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        return stack
    }()
    
    private let roundingNameLabel: UILabel = {
        let label = UILabel()
        label.text = UIConstants.roundingName
        label.font = UIConstants.fontSemibold
        label.textAlignment = .left
        return label
    }()
    
    private let roundingAmountStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = UIConstants.menuItemsOffset
        return stack
    }()
    
    private let hideZeroLinesStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        return stack
    }()
    
    private let hideZeroLinesNameLabel: UILabel = {
        let label = UILabel()
        label.text = UIConstants.hideZeroLinesName
        label.font = UIConstants.fontSemibold
        label.textAlignment = .left
        return label
    }()
}

// MARK: - Private methods
private extension SettingsPageView {
    func initialize() {
        self.backgroundColor = UIConstants.backgroundColor
        
        mainStack.addArrangedSubview(roundingStack)
        mainStack.addArrangedSubview(hideZeroLinesStack)
        self.addSubview(mainStack)
        mainStack.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(UIConstants.contentInset)
            make.leading.trailing.equalToSuperview().inset(UIConstants.contentInset)
        }
        
        roundingStack.addArrangedSubview(roundingNameLabel)
        roundingStack.addArrangedSubview(roundingAmountStack)
        roundingStack.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        roundingAmountStack.addArrangedSubview(roundingStepper)
        roundingAmountStack.addArrangedSubview(roundingAmountLabel)
        roundingAmountStack.snp.makeConstraints { make in
        }
        
        hideZeroLinesStack.addArrangedSubview(hideZeroLinesNameLabel)
        hideZeroLinesStack.addArrangedSubview(hideZeroLinesSwitch)
        hideZeroLinesStack.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
    }
    
}
