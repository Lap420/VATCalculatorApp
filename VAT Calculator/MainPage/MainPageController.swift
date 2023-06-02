import UIKit

protocol MainPageControllerProtocol: AnyObject {
    func initTextFieldsState(vatAmountText: String?, feeAmountText: String?, serviceChargeAmountText: String?, vatOnScSwitch: Bool)
    func getTextFieldsData() -> (Double, Double, Double, Bool)
    func updateSlider(isEnabled: Bool)
    func updateGross(gross: Double)
}

class MainPageController: UIViewController {
    // MARK: - ViewController Lifecycle
    init(presenter: MainPagePresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = mainPageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    } 
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextDidChangeNotification(_:)), name: UITextField.textDidChangeNotification, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mainPageView.startButtonAnimation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        mainPageView.stopButtonAnimation()
        NotificationCenter.default.removeObserver(self, name: UITextField.textDidChangeNotification, object: nil)
    }
    
    // MARK: - Private properties
    private let presenter: MainPagePresenterProtocol
    private lazy var mainPageView = MainPageView()
//    private var mainPageModel = MainPageModel()
}

// MARK: - Private methods
private extension MainPageController {
    func initialize() {
        title = UIConstants.mainPageNavigationTitle
        navigationController?.navigationBar.titleTextAttributes = UIConstants.navigationTitleAttributes
        presenter.checkIsFirstLaunch()
        presenter.loadMainPageData()
        presenter.initTextFieldsState()
        presenter.updateElements()
        initDelegates()
        initButtonTargets()
    }
    
    func initDelegates() {
        mainPageView.vatAmountTF.delegate = self
        mainPageView.feeAmountTF.delegate = self
        mainPageView.serviceChargeAmountTF.delegate = self
    }
    
    func initButtonTargets() {
        mainPageView.vatOnScSwitch.addTarget(self, action: #selector(vatOnScSwitched), for: .valueChanged)
        mainPageView.openCalculatorButton.addTarget(self, action: #selector(openCalculatorButtonTapped), for: .touchUpInside)
    }
    
    @objc func vatOnScSwitched(_ sender: UISwitch) {
        view.endEditing(true)
        presenter.updateElements()
        presenter.saveSwitchStateToPersistence(isEnabled: sender.isOn)
    }
    
    @objc func openCalculatorButtonTapped() {
        view.endEditing(true)
        presenter.showCalculatorPage()
    }
}

extension MainPageController: MainPageControllerProtocol {
    func initTextFieldsState(vatAmountText: String?, feeAmountText: String?, serviceChargeAmountText: String?, vatOnScSwitch: Bool) {
        mainPageView.vatAmountTF.text = vatAmountText
        mainPageView.feeAmountTF.text = feeAmountText
        mainPageView.serviceChargeAmountTF.text = serviceChargeAmountText
        mainPageView.vatOnScSwitch.isOn = vatOnScSwitch
    }
    
    func getTextFieldsData() -> (Double, Double, Double, Bool) {
        let vatPercent = Double(mainPageView.vatAmountTF.text ?? "0") ?? 0
        let feePercent = Double(mainPageView.feeAmountTF.text ?? "0") ?? 0
        let serviceChargePercent = Double(mainPageView.serviceChargeAmountTF.text ?? "0") ?? 0
        let calculateVatOnSc = mainPageView.vatOnScSwitch.isOn
        return (vatPercent, feePercent, serviceChargePercent, calculateVatOnSc)
    }
    
    func updateSlider(isEnabled: Bool) {
        mainPageView.updateSlider(isEnabled: isEnabled)
    }
    
    func updateGross(gross: Double) {
        mainPageView.updateGross(gross: gross)
    }
}

extension MainPageController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func getChoosenTextFieldName(_ textField: UITextField) -> String {
        let field: String
        switch textField {
        case mainPageView.vatAmountTF:
            field = UIConstants.vatName
        case mainPageView.feeAmountTF:
            field = UIConstants.feeName
        case mainPageView.serviceChargeAmountTF:
            field = UIConstants.serviceChargeName
        default:
            field = "some"
        }
        return field
    }
    
    func checkEnteredText(_ textField: UITextField) -> Bool {
        guard let text = textField.text else { return true }
        guard !text.isEmpty else {
            presenter.updateElements()
            return true
        }
        guard let enteredAmount = Double(text) else {
            let textFieldName = getChoosenTextFieldName(textField)
            let alert = AlertManager.incorrectValueAlert(textFieldName: textFieldName, textField: textField)
            present(alert, animated: true)
            return false
        }
        guard enteredAmount < 1000 else {
            let textFieldName = getChoosenTextFieldName(textField)
            let alert = AlertManager.valueTooHighAlert(textFieldName: textFieldName, textField: textField)
            present(alert, animated: true)
            return false
        }
        presenter.updateElements()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let _ = checkEnteredText(textField)
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        checkEnteredText(textField)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        let textFieldName = getChoosenTextFieldName(textField)
        let text = textField.text ?? ""
        presenter.saveTextFieldTextToPersistence(textFieldName: textFieldName, text: text)
    }
    
    @objc
    func handleTextDidChangeNotification(_ notification: Notification) {
        guard let textField = notification.object as? UITextField else { return }
        let _ = checkEnteredText(textField)
    }
}
