import UIKit

class SettingsPageView: UIView {
    // MARK: - Public properties
    let roundingAmountLabel: UILabel = {
        let label = UILabel()
        label.font = UIConstants.fontRegular
        label.accessibilityIdentifier = "roundingAmount"
        return label
    }()
    
    let roundingStepper: UIStepper = {
        let stepper = UIStepper()
        stepper.maximumValue = UIConstants.stepperMaximumValue
        stepper.accessibilityIdentifier = "roundingStepper"
        return stepper
    }()
    
    let hideZeroLinesSwitch: UISwitch = {
        let swich = UISwitch()
        swich.accessibilityIdentifier = "hideZeroLines"
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
    
    private let roundingStack: UIStackView = {
        let stack = UIStackView()
        return stack
    }()
    
    private let roundingNameLabel: UILabel = {
        let label = UILabel()
        label.text = UIConstants.roundingName
        label.font = UIConstants.fontSemibold
        return label
    }()
    
    private let roundingAmountStack: UIStackView = {
        let stack = UIStackView()
        stack.spacing = UIConstants.menuItemsOffset
        return stack
    }()
    
    private let hideZeroLinesStack: UIStackView = {
        let stack = UIStackView()
        return stack
    }()
    
    private let hideZeroLinesNameLabel: UILabel = {
        let label = UILabel()
        label.text = UIConstants.hideZeroLinesName
        label.font = UIConstants.fontSemibold
        return label
    }()
}

// MARK: - Private methods
private extension SettingsPageView {
    func initialize() {
        backgroundColor = UIConstants.backgroundColor
        self.addSubview(mainView)
        mainView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(layoutMargins.top)
            make.leading.trailing.equalTo(layoutMargins)
        }
        mainView.addSubview(mainStack)
        mainStack.addArrangedSubview(roundingStack)
        mainStack.addArrangedSubview(hideZeroLinesStack)
        mainStack.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(layoutMargins.top * 2)
            make.leading.trailing.equalToSuperview().inset(layoutMargins.left)
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
