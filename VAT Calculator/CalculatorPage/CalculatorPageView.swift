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
        textField.clearsOnBeginEditing = true
        return textField
    }()
    
    let vatStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        return stack
    }()
    
    let vatNameLabel: UILabel = {
        let label = UILabel()
        label.text = String(UIConstants.vatName.dropLast(3))
        label.font = UIConstants.fontSemibold
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let vatAmountLabel: UILabel = {
        let label = UILabel()
        label.font = UIConstants.fontRegular
        label.textAlignment = .right
        return label
    }()
    
    let feeStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        return stack
    }()
    
    let feeNameLabel: UILabel = {
        let label = UILabel()
        label.text = String(UIConstants.feeName.dropLast(3))
        label.font = UIConstants.fontSemibold
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let feeAmountLabel: UILabel = {
        let label = UILabel()
        label.font = UIConstants.fontRegular
        label.textAlignment = .right
        return label
    }()
    
    let serviceChargeStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        return stack
    }()
    
    let serviceChargeNameLabel: UILabel = {
        let label = UILabel()
        label.text = String(UIConstants.serviceChargeName.dropLast(3))
        label.font = UIConstants.fontSemibold
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let serviceChargeAmountLabel: UILabel = {
        let label = UILabel()
        label.font = UIConstants.fontRegular
        label.textAlignment = .right
        return label
    }()
    
    let vatOnScStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        return stack
    }()
    
    let vatOnScNameLabel: UILabel = {
        let label = UILabel()
        label.text = UIConstants.vatOnScName
        label.font = UIConstants.fontSemibold
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let vatOnScAmountLabel: UILabel = {
        let label = UILabel()
        label.font = UIConstants.fontRegular
        label.textAlignment = .right
        return label
    }()
    
    let totalVatStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        return stack
    }()
    
    let totalVatNameLabel: UILabel = {
        let label = UILabel()
        label.text = UIConstants.totalVatName
        label.font = UIConstants.fontSemibold
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let totalVatAmountLabel: UILabel = {
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
        textField.clearsOnBeginEditing = true
        return textField
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
        label.text = String(UIConstants.netName.dropLast(3))
        label.font = UIConstants.fontSemibold
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
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
        label.adjustsFontSizeToFitWidth = true
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
        mainStack.addArrangedSubview(totalVatStack)
        mainStack.addArrangedSubview(grossStack)
        self.addSubview(mainStack)
        mainStack.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(UIConstants.contentInset)
            make.leading.trailing.equalToSuperview().inset(UIConstants.contentInset)
        }
        
        netStack.addArrangedSubview(netNameLabel)
        netNameLabel.setContentCompressionResistancePriority(UILayoutPriority(249), for: .horizontal)
        netStack.addArrangedSubview(netAmountTF)
        netAmountTF.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        netStack.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        vatStack.addArrangedSubview(vatNameLabel)
        vatNameLabel.setContentCompressionResistancePriority(UILayoutPriority(249), for: .horizontal)
        vatStack.addArrangedSubview(vatAmountLabel)
        vatStack.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }

        feeStack.addArrangedSubview(feeNameLabel)
        feeNameLabel.setContentCompressionResistancePriority(UILayoutPriority(249), for: .horizontal)
        feeStack.addArrangedSubview(feeAmountLabel)
        feeStack.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        serviceChargeStack.addArrangedSubview(serviceChargeNameLabel)
        serviceChargeNameLabel.setContentCompressionResistancePriority(UILayoutPriority(249), for: .horizontal)
        serviceChargeStack.addArrangedSubview(serviceChargeAmountLabel)
        serviceChargeStack.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        vatOnScStack.addArrangedSubview(vatOnScNameLabel)
        vatOnScNameLabel.setContentCompressionResistancePriority(UILayoutPriority(249), for: .horizontal)
        vatOnScStack.addArrangedSubview(vatOnScAmountLabel)
        vatOnScStack.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        totalVatStack.addArrangedSubview(totalVatNameLabel)
        totalVatNameLabel.setContentCompressionResistancePriority(UILayoutPriority(249), for: .horizontal)
        totalVatStack.addArrangedSubview(totalVatAmountLabel)
        totalVatStack.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        grossStack.addArrangedSubview(grossNameLabel)
        grossNameLabel.setContentCompressionResistancePriority(UILayoutPriority(249), for: .horizontal)
        grossStack.addArrangedSubview(grossAmountTF)
        grossAmountTF.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        grossStack.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
    }
}
