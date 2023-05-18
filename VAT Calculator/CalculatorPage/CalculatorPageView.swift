import UIKit

class CalculatorPageView: UIView {
    // MARK: - Public properties
    let netAmountTF: UITextField = {
        let textField = UITextField()
        textField.setupTF()
        return textField
    }()
    
    let vatStack: UIStackView = {
        let stack = UIStackView()
        return stack
    }()
    
    let vatNameLabel: UILabel = {
        let label = UILabel()
        label.text = String(UIConstants.vatAmountName)
        label.font = UIConstants.fontSemibold
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let vatAmountLabel: UILabel = {
        let label = UILabel()
        label.font = UIConstants.fontRegular
        return label
    }()
    
    let feeStack: UIStackView = {
        let stack = UIStackView()
        return stack
    }()
    
    let feeNameLabel: UILabel = {
        let label = UILabel()
        label.text = String(UIConstants.feeAmountName)
        label.font = UIConstants.fontSemibold
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let feeAmountLabel: UILabel = {
        let label = UILabel()
        label.font = UIConstants.fontRegular
        return label
    }()
    
    let serviceChargeStack: UIStackView = {
        let stack = UIStackView()
        return stack
    }()
    
    let serviceChargeNameLabel: UILabel = {
        let label = UILabel()
        label.text = String(UIConstants.serviceChargeAmountName)
        label.font = UIConstants.fontSemibold
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let serviceChargeAmountLabel: UILabel = {
        let label = UILabel()
        label.font = UIConstants.fontRegular
        return label
    }()
    
    let vatOnScStack: UIStackView = {
        let stack = UIStackView()
        return stack
    }()
    
    let vatOnScNameLabel: UILabel = {
        let label = UILabel()
        label.text = UIConstants.vatOnScName
        label.font = UIConstants.fontSemibold
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let vatOnScAmountLabel: UILabel = {
        let label = UILabel()
        label.font = UIConstants.fontRegular
        return label
    }()
    
    let totalVatStack: UIStackView = {
        let stack = UIStackView()
        return stack
    }()
    
    let totalVatNameLabel: UILabel = {
        let label = UILabel()
        label.text = UIConstants.totalVatName
        label.font = UIConstants.fontSemibold
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let totalVatAmountLabel: UILabel = {
        let label = UILabel()
        label.font = UIConstants.fontRegular
        return label
    }()
    
    let grossAmountTF: UITextField = {
        let textField = UITextField()
        textField.setupTF()
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
    private let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = UIConstants.backgroundContentColor
        view.layer.cornerRadius = UIConstants.contentViewCornerRadius
        return view
    }()
    
    private let mainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = UIConstants.menuItemsOffset
        stack.alignment = .center
        return stack
    }()
    
    private let netStack: UIStackView = {
        let stack = UIStackView()
        return stack
    }()
    
    private let netNameLabel: UILabel = {
        let label = UILabel()
        label.text = String(UIConstants.netSalesName)
        label.font = UIConstants.fontSemibold
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let grossStack: UIStackView = {
        let stack = UIStackView()
        return stack
    }()
    
    private let grossNameLabel: UILabel = {
        let label = UILabel()
        label.text = String(UIConstants.grossSalesName)
        label.font = UIConstants.fontSemibold
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
}

// MARK: - Private methods
private extension CalculatorPageView {
    func initialize() {
        backgroundColor = UIConstants.backgroundColor
        self.addSubview(mainView)
        mainView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(layoutMargins.top)
            make.leading.trailing.equalTo(layoutMargins)
        }
        mainView.addSubview(mainStack)
        mainStack.addArrangedSubview(netStack)
        mainStack.addArrangedSubview(vatStack)
        mainStack.addArrangedSubview(feeStack)
        mainStack.addArrangedSubview(serviceChargeStack)
        mainStack.addArrangedSubview(vatOnScStack)
        mainStack.addArrangedSubview(totalVatStack)
        mainStack.addArrangedSubview(grossStack)
        mainStack.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(layoutMargins.top * 2)
            make.leading.trailing.equalToSuperview().inset(layoutMargins.left)
        }
        
        netStack.addArrangedSubview(netNameLabel)
        netNameLabel.setContentCompressionResistancePriority(UILayoutPriority(749), for: .horizontal)
        netNameLabel.setContentHuggingPriority(UILayoutPriority(249), for: .horizontal)
        netStack.addArrangedSubview(netAmountTF)
        netAmountTF.snp.makeConstraints { make in
            make.height.equalTo(UIConstants.textFieldHeight)
        }
        netStack.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        vatStack.addArrangedSubview(vatNameLabel)
        vatNameLabel.setContentCompressionResistancePriority(UILayoutPriority(749), for: .horizontal)
        vatNameLabel.setContentHuggingPriority(UILayoutPriority(249), for: .horizontal)
        vatStack.addArrangedSubview(vatAmountLabel)
        vatStack.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }

        feeStack.addArrangedSubview(feeNameLabel)
        feeNameLabel.setContentCompressionResistancePriority(UILayoutPriority(749), for: .horizontal)
        feeNameLabel.setContentHuggingPriority(UILayoutPriority(249), for: .horizontal)
        feeStack.addArrangedSubview(feeAmountLabel)
        feeStack.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        serviceChargeStack.addArrangedSubview(serviceChargeNameLabel)
        serviceChargeNameLabel.setContentCompressionResistancePriority(UILayoutPriority(749), for: .horizontal)
        serviceChargeNameLabel.setContentHuggingPriority(UILayoutPriority(249), for: .horizontal)
        serviceChargeStack.addArrangedSubview(serviceChargeAmountLabel)
        serviceChargeStack.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        vatOnScStack.addArrangedSubview(vatOnScNameLabel)
        vatOnScNameLabel.setContentCompressionResistancePriority(UILayoutPriority(749), for: .horizontal)
        vatOnScNameLabel.setContentHuggingPriority(UILayoutPriority(249), for: .horizontal)
        vatOnScStack.addArrangedSubview(vatOnScAmountLabel)
        vatOnScStack.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        totalVatStack.addArrangedSubview(totalVatNameLabel)
        totalVatNameLabel.setContentCompressionResistancePriority(UILayoutPriority(749), for: .horizontal)
        totalVatNameLabel.setContentHuggingPriority(UILayoutPriority(249), for: .horizontal)
        totalVatStack.addArrangedSubview(totalVatAmountLabel)
        totalVatStack.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        grossStack.addArrangedSubview(grossNameLabel)
        grossNameLabel.setContentCompressionResistancePriority(UILayoutPriority(749), for: .horizontal)
        grossNameLabel.setContentHuggingPriority(UILayoutPriority(249), for: .horizontal)
        grossStack.addArrangedSubview(grossAmountTF)
        grossAmountTF.snp.makeConstraints { make in
            make.height.equalTo(UIConstants.textFieldHeight)
        }
        grossStack.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
    }
}
