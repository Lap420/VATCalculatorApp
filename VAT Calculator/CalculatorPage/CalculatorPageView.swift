//
//  CalculatorPageView.swift
//  VAT Calculator
//
//  Created by Lap on 14.03.2023.
//

import UIKit

class CalculatorPageView: UIView {
    // MARK: - Public properties
    let netAmountTF: UITextField = {
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
    
    let vatAmountLabel: UILabel = {
        let label = UILabel()
        label.font = UIConstants.fontRegular
        label.textAlignment = .right
        return label
    }()
    
    let feeAmountLabel: UILabel = {
        let label = UILabel()
        label.font = UIConstants.fontRegular
        label.textAlignment = .right
        return label
    }()
    
    let serviceChargeAmountLabel: UILabel = {
        let label = UILabel()
        label.font = UIConstants.fontRegular
        label.textAlignment = .right
        return label
    }()
    
    let vatOnScAmountLabel: UILabel = {
        let label = UILabel()
        label.font = UIConstants.fontRegular
        label.textAlignment = .right
        return label
    }()
    
    let grossAmountTF: UITextField = {
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
    
    // MARK: View Lifecycle
    init() {
        super.init(frame: .zero)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public properties
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
        label.text = String(UIConstants.netName.dropLast(3))
        label.font = UIConstants.fontSemibold
        label.textAlignment = .left
        return label
    }()
    
    private let vatStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        return stack
    }()
    
    private let vatNameLabel: UILabel = {
        let label = UILabel()
        label.text = String(UIConstants.vatName.dropLast(3))
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
        label.text = String(UIConstants.feeName.dropLast(3))
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
        label.text = String(UIConstants.serviceChargeName.dropLast(3))
        label.font = UIConstants.fontSemibold
        label.textAlignment = .left
        return label
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
    
    private let grossStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        return stack
    }()
    
    private let grossNameLabel: UILabel = {
        let label = UILabel()
        label.text = String(UIConstants.grossName.dropLast(3))
        label.font = UIConstants.fontSemibold
        label.textAlignment = .left
        return label
    }()
}

// MARK: - Private methods
private extension CalculatorPageView {
    func initialize() {
        self.backgroundColor = UIConstants.backgroundColor
        
        mainStack.addArrangedSubview(netStack)
        mainStack.addArrangedSubview(vatStack)
        mainStack.addArrangedSubview(feeStack)
        mainStack.addArrangedSubview(serviceChargeStack)
        mainStack.addArrangedSubview(vatOnScStack)
        mainStack.addArrangedSubview(grossStack)
//        mainStack.setCustomSpacing(UIConstants.afterGrossCustomSpacing, after: grossStack)
//        mainStack.addArrangedSubview(openCalculatorButton)
        self.addSubview(mainStack)
        mainStack.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(UIConstants.contentInset)
        }
        
        netStack.addArrangedSubview(netNameLabel)
        netStack.addArrangedSubview(netAmountTF)
        netAmountTF.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
        mainStack.addSubview(netStack)
        netStack.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        vatStack.addArrangedSubview(vatNameLabel)
        vatStack.addArrangedSubview(vatAmountLabel)
        mainStack.addSubview(vatStack)
        vatStack.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }

        feeStack.addArrangedSubview(feeNameLabel)
        feeStack.addArrangedSubview(feeAmountLabel)
        mainStack.addSubview(feeStack)
        feeStack.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        serviceChargeStack.addArrangedSubview(serviceChargeNameLabel)
        serviceChargeStack.addArrangedSubview(serviceChargeAmountLabel)
        mainStack.addSubview(serviceChargeStack)
        serviceChargeStack.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        vatOnScStack.addArrangedSubview(vatOnScNameLabel)
        vatOnScStack.addArrangedSubview(vatOnScAmountLabel)
        mainStack.addSubview(vatOnScStack)
        vatOnScStack.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        grossStack.addArrangedSubview(grossNameLabel)
        grossStack.addArrangedSubview(grossAmountTF)
        grossAmountTF.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
        mainStack.addSubview(grossStack)
        grossStack.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
    }
}
