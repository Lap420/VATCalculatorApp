import UIKit

protocol SettingsPageControllerProtocol: AnyObject {
    func initElements(rounding: Int, hideZeroLines: Bool)
    func setCalculatorPageDelegate(presenter: CalculatorPageDelegate)
}

class SettingsPageController: UIViewController {
    // MARK: - ViewController Lifecycle
    init(presenter: SettingsPagePresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = settingsPageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    // MARK: - Private properties
    private lazy var settingsPageView = SettingsPageView()
    private let presenter: SettingsPagePresenterProtocol
}

// MARK: - Private methods
private extension SettingsPageController {
    func initialize() {
        title = UIConstants.settingsPageNavigationTitle
        let closeButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeSettings))
        navigationItem.leftBarButtonItem = closeButton
        presenter.initElements()
        initButtonTargets()
    }
    
    func initButtonTargets() {
        settingsPageView.hideZeroLinesSwitch.addTarget(self, action: #selector(hideZeroLinesSwitched), for: .valueChanged)
        settingsPageView.roundingStepper.addTarget(self, action: #selector(roundingStepperClicked), for: .valueChanged)
    }
    
    @objc func roundingStepperClicked(_ sender: UIStepper) {
        let value = Int(sender.value)
        presenter.roundingStepperClicked(value)
        settingsPageView.roundingAmountLabel.text = String(value)
    }
    
    @objc func hideZeroLinesSwitched(_ sender: UISwitch) {
        let isOn = sender.isOn
        presenter.hideZeroLinesSwitched(isOn)
    }
    
    @objc
    func closeSettings() {
        dismiss(animated: true)
    }
}

extension SettingsPageController: SettingsPageControllerProtocol {
    func initElements(rounding: Int, hideZeroLines: Bool) {
        settingsPageView.roundingAmountLabel.text = String(rounding)
        settingsPageView.roundingStepper.value = Double(rounding)
        settingsPageView.hideZeroLinesSwitch.isOn = hideZeroLines
    }
    
    func setCalculatorPageDelegate(presenter: CalculatorPageDelegate) {
        self.presenter.delegate = presenter
    }
}
