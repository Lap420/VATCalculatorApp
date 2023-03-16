//
//  MainPageView.swift
//  VAT Calculator
//
//  Created by Lap on 14.03.2023.
//

import SnapKit
import UIKit

class MainPageView: UIView {
    // MARK: - Public properties
    let vatAmountTF: UITextField = {
        let textField = UITextField()
        textField.placeholder = UIConstants.placeholder
        textField.font = UIConstants.fontRegular
        textField.textAlignment = .right
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .whileEditing
        textField.keyboardType = .decimalPad
        textField.returnKeyType = .next
        textField.clearsOnBeginEditing = true
        return textField
    }()
    
    let feeAmountTF: UITextField = {
        let textField = UITextField()
        textField.placeholder = UIConstants.placeholder
        textField.font = UIConstants.fontRegular
        textField.textAlignment = .right
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .whileEditing
        textField.keyboardType = .decimalPad
        textField.returnKeyType = .next
        textField.clearsOnBeginEditing = true
        return textField
    }()
    
    let serviceChargeAmountTF: UITextField = {
        let textField = UITextField()
        textField.placeholder = UIConstants.placeholder
        textField.font = UIConstants.fontRegular
        textField.textAlignment = .right
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .whileEditing
        textField.keyboardType = .decimalPad
        textField.returnKeyType = .done
        textField.clearsOnBeginEditing = true
        return textField
    }()
    
    let vatOnScNameLabel: UILabel = {
        let label = UILabel()
        label.text = UIConstants.vatOnScName
        label.font = UIConstants.fontSemibold
        label.textAlignment = .left
        return label
    }()
    
    let vatOnScSwitch: UISwitch = {
        let swich = UISwitch()
        swich.isOn = true
        return swich
    }()
    
    let grossAmountLabel: UILabel = {
        let label = UILabel()
        label.font = UIConstants.fontRegular
        label.textAlignment = .right
        return label
    }()
    
    let openCalculatorButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(UIConstants.buttonTitle, for: .normal)
        button.titleLabel?.font = UIConstants.buttonFont
        button.setTitleColor(UIConstants.buttonTitleColor, for: .normal)
        button.layer.cornerRadius = UIConstants.buttonCornerRadius
        button.backgroundColor = UIConstants.accentColor
        return button
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
    
    private let vatOnScStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        return stack
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
}

// MARK: - Private methods
private extension MainPageView {
    func initialize() {
        self.backgroundColor = UIConstants.backgroundColor
        
        mainStack.addArrangedSubview(netStack)
        mainStack.addArrangedSubview(vatStack)
        mainStack.addArrangedSubview(feeStack)
        mainStack.addArrangedSubview(serviceChargeStack)
        mainStack.addArrangedSubview(vatOnScStack)
        mainStack.addArrangedSubview(grossStack)
        mainStack.setCustomSpacing(UIConstants.afterGrossCustomSpacing, after: grossStack)
        mainStack.addArrangedSubview(openCalculatorButton)
        self.addSubview(mainStack)
        mainStack.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(UIConstants.contentInset)
            make.leading.trailing.equalToSuperview().inset(UIConstants.contentInset)
        }
        
        netStack.addArrangedSubview(netNameLabel)
        netStack.addArrangedSubview(netAmountLabel)
        netStack.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        vatStack.addArrangedSubview(vatNameLabel)
        vatStack.addArrangedSubview(vatAmountTF)
        vatAmountTF.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
        vatStack.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }

        feeStack.addArrangedSubview(feeNameLabel)
        feeStack.addArrangedSubview(feeAmountTF)
        feeAmountTF.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
        feeStack.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        serviceChargeStack.addArrangedSubview(serviceChargeNameLabel)
        serviceChargeStack.addArrangedSubview(serviceChargeAmountTF)
        serviceChargeAmountTF.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
        serviceChargeStack.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        vatOnScStack.addArrangedSubview(vatOnScNameLabel)
        vatOnScStack.addArrangedSubview(vatOnScSwitch)
        vatOnScStack.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        grossStack.addArrangedSubview(grossNameLabel)
        grossStack.addArrangedSubview(grossAmountLabel)
        grossStack.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        openCalculatorButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(250)
        }
    }
}
