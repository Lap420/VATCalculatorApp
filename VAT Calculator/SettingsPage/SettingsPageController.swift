import UIKit

class SettingsPageController: UIViewController {
    // MARK: - ViewController Lifecycle
    override func loadView() {
        view = settingsPageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    // MARK: - Private properties
    private lazy var settingsPageView = SettingsPageView()
    weak var calculatorPageDelegate: CalculatorPageDelegate?
}

// MARK: - Private methods
private extension SettingsPageController {
    func initialize() {
        title = UIConstants.settingsPageNavigationTitle
        initElements()
        initButtonTargets()
    }
    
    func initElements() {
        let rounding = UserDefaultsManager.loadSettingsPageRounding()
        settingsPageView.roundingAmountLabel.text = String(rounding)
        settingsPageView.roundingStepper.value = Double(rounding)
        let hideZeroLines = UserDefaultsManager.loadSettingsPageHideZeroLines()
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
