import SnapKit
import UIKit

class MainPageView: UIView {
    // MARK: - Public methods
    func startButtonAnimation() {
        UIView.animate(withDuration: 3, delay: 0, options: [ .repeat], animations: {
            self.whiteButtonAnimationView.snp.updateConstraints { make in
                make.leading.equalToSuperview().inset(600)
            }
            self.openCalculatorButton.layoutIfNeeded()
        }, completion: nil)
    }
    
    func stopButtonAnimation() {
        UIView.animate(withDuration: 0, delay: 0, options: [.beginFromCurrentState], animations: {
            self.whiteButtonAnimationView.snp.updateConstraints { make in
                make.leading.equalToSuperview().inset(-600)
            }
        }, completion: nil)
    }
    
    func updateSlider(isEnabled: Bool) {
        vatOnScSwitch.isEnabled = isEnabled
        vatOnScNameLabel.isEnabled = isEnabled
    }
    
    func updateGross(gross: Double) {
        grossAmountLabel.text = "\(gross.formatted(.number))"
    }
    
    // MARK: - Public properties
    let vatAmountTF: UITextField = {
        let textField = UITextField()
        textField.setupTF()
        return textField
    }()
    
    let feeAmountTF: UITextField = {
        let textField = UITextField()
        textField.setupTF()
        return textField
    }()
    
    let serviceChargeAmountTF: UITextField = {
        let textField = UITextField()
        textField.setupTF()
        return textField
    }()
    
    let vatOnScSwitch: UISwitch = {
        let swich = UISwitch()
        swich.isOn = true
        return swich
    }()
    
    let openCalculatorButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        config.title = UIConstants.buttonTitle
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { attributes in
            var updatedAttributes = attributes
            updatedAttributes.font = UIConstants.buttonFont
            return updatedAttributes
        }
        config.buttonSize = .large
        button.configuration = config
        button.addTarget(self, action: #selector(buttonTouchedDown), for: .touchDown)
        button.addTarget(self, action: #selector(buttonTouchedUp), for: [.touchUpInside, .touchUpOutside])
        button.clipsToBounds = true
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        openCalculatorButton.sizeToFit()
        whiteButtonAnimationView.layoutIfNeeded()
        addSmallViewGradientLayer()
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
        label.text = UIConstants.netName
        label.font = UIConstants.fontSemibold
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
        return stack
    }()
    
    private let vatNameLabel: UILabel = {
        let label = UILabel()
        label.text = UIConstants.vatName
        label.font = UIConstants.fontSemibold
        return label
    }()
    
    private let feeStack: UIStackView = {
        let stack = UIStackView()
        return stack
    }()
    
    private let feeNameLabel: UILabel = {
        let label = UILabel()
        label.text = UIConstants.feeName
        label.font = UIConstants.fontSemibold
        return label
    }()
    
    private let serviceChargeStack: UIStackView = {
        let stack = UIStackView()
        return stack
    }()
    
    private let serviceChargeNameLabel: UILabel = {
        let label = UILabel()
        label.text = UIConstants.serviceChargeName
        label.font = UIConstants.fontSemibold
        return label
    }()
    
    private let vatOnScStack: UIStackView = {
        let stack = UIStackView()
        return stack
    }()
    
    private let vatOnScNameLabel: UILabel = {
        let label = UILabel()
        label.text = UIConstants.vatOnScName
        label.font = UIConstants.fontSemibold
        return label
    }()
    
    private let grossStack: UIStackView = {
        let stack = UIStackView()
        return stack
    }()
    
    private let grossAmountLabel: UILabel = {
        let label = UILabel()
        label.font = UIConstants.fontRegular
        label.textAlignment = .right
        return label
    }()
    
    private let grossNameLabel: UILabel = {
        let label = UILabel()
        label.text = UIConstants.grossName
        label.font = UIConstants.fontSemibold
        return label
    }()
    
    private let whiteButtonAnimationView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = false
        return view
    }()
}

// MARK: - Private methods
private extension MainPageView {
    func initialize() {
        backgroundColor = UIConstants.backgroundColor
        self.addSubview(mainView)
        mainView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(layoutMargins.top)
            make.leading.trailing.equalTo(layoutMargins)
        }
        mainView.addSubview(mainStack)
        mainStack.addArrangedSubview(netStack)
        mainStack.setCustomSpacing(22, after: netStack)
        mainStack.addArrangedSubview(vatStack)
        mainStack.addArrangedSubview(feeStack)
        mainStack.addArrangedSubview(serviceChargeStack)
        mainStack.setCustomSpacing(17, after: serviceChargeStack)
        mainStack.addArrangedSubview(vatOnScStack)
        mainStack.setCustomSpacing(22, after: vatOnScStack)
        mainStack.addArrangedSubview(grossStack)
        mainStack.setCustomSpacing(50, after: grossStack)
        mainStack.addArrangedSubview(openCalculatorButton)
        mainStack.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(layoutMargins.top * 2)
            make.leading.trailing.equalToSuperview().inset(layoutMargins.left)
        }
        
        netStack.addArrangedSubview(netNameLabel)
        netStack.addArrangedSubview(netAmountLabel)
        netStack.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        vatStack.addArrangedSubview(vatNameLabel)
        vatStack.addArrangedSubview(vatAmountTF)
        vatAmountTF.snp.makeConstraints { make in
            make.width.equalTo(UIConstants.textFieldWidth)
            make.height.equalTo(UIConstants.textFieldHeight)
        }
        vatStack.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }

        feeStack.addArrangedSubview(feeNameLabel)
        feeStack.addArrangedSubview(feeAmountTF)
        feeAmountTF.snp.makeConstraints { make in
            make.width.equalTo(UIConstants.textFieldWidth)
            make.height.equalTo(UIConstants.textFieldHeight)
        }
        feeStack.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        
        serviceChargeStack.addArrangedSubview(serviceChargeNameLabel)
        serviceChargeStack.addArrangedSubview(serviceChargeAmountTF)
        serviceChargeAmountTF.snp.makeConstraints { make in
            make.width.equalTo(UIConstants.textFieldWidth)
            make.height.equalTo(UIConstants.textFieldHeight)
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
            make.width.equalTo(UIConstants.buttonWidth)
        }
        
        openCalculatorButton.addSubview(whiteButtonAnimationView)
        whiteButtonAnimationView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().inset(-600)
            make.width.equalTo(200)
        }
    }
    
    func addSmallViewGradientLayer() {
        guard whiteButtonAnimationView.layer.sublayers == nil else { return }
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = whiteButtonAnimationView.bounds
        gradientLayer.colors = [UIColor.white.withAlphaComponent(0).cgColor,
                                UIColor.white.withAlphaComponent(0.1).cgColor,
                                UIColor.white.withAlphaComponent(0.1).cgColor,
                                UIColor.white.withAlphaComponent(0).cgColor]
        gradientLayer.startPoint = .init(x: 0, y: 1)
        gradientLayer.endPoint = .init(x: 1, y: 1)
        whiteButtonAnimationView.layer.addSublayer(gradientLayer)
    }
    
    @objc
    func buttonTouchedDown(sender: UIButton) {
        UIView.animate(withDuration: UIConstants.buttonAnimationDuration) {
            sender.transform = .init(scaleX: UIConstants.buttonAnimationScale,
                                     y: UIConstants.buttonAnimationScale)
        }
    }
    
    @objc
    func buttonTouchedUp(sender: UIButton) {
        UIView.animate(withDuration: UIConstants.buttonAnimationDuration) {
            sender.transform = .identity
        }
    }
}
