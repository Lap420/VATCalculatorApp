protocol SettingsPagePresenterProtocol: AnyObject {
    func initElements()
    func roundingStepperClicked(_ value: Int)
    func hideZeroLinesSwitched(_ isOn: Bool)
    var delegate: CalculatorPageDelegate? { get set }
}

class SettingsPagePresenter {
    init(router: RouterProtocol) {
        self.router = router
    }
    
    weak var viewController: SettingsPageControllerProtocol?
    private var router: RouterProtocol?
    weak var calculatorPageDelegate: CalculatorPageDelegate?
}

extension SettingsPagePresenter: SettingsPagePresenterProtocol {
    func initElements() {
        let rounding = UserDefaultsManager.loadSettingsPageRounding()
        let hideZeroLines = UserDefaultsManager.loadSettingsPageHideZeroLines()
        viewController?.initElements(rounding: rounding, hideZeroLines: hideZeroLines)
    }
    
    func roundingStepperClicked(_ value: Int) {
        UserDefaultsManager.saveSettingsPageRounding(value)
        calculatorPageDelegate?.updateRounding(value)
    }
    
    func hideZeroLinesSwitched(_ isOn: Bool) {
        UserDefaultsManager.saveSettingsPageHideZeroLines(isOn)
        calculatorPageDelegate?.updateHideZeroLines(isOn)
    }
    
    var delegate: CalculatorPageDelegate? {
        get { calculatorPageDelegate }
        set { calculatorPageDelegate = newValue}
    }
}
