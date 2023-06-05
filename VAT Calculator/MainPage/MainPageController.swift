import UIKit

class MainPageController: UIViewController {
    // MARK: - ViewController Lifecycle
    init(viewModel: MainPagePresenterProtocol) {
        self.viewModel = viewModel
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
    private let viewModel: MainPagePresenterProtocol
    private lazy var mainPageView = MainPageView()
}

// MARK: - Private methods
private extension MainPageController {
    func initialize() {
        title = UIConstants.mainPageNavigationTitle
        navigationController?.navigationBar.titleTextAttributes = UIConstants.navigationTitleAttributes
        bindViewModel()
        viewModel.checkIsFirstLaunch()
        viewModel.loadMainPageData()
        viewModel.initTextFieldsState()
        viewModel.updateElements(vatPercentText: mainPageView.vatAmountTF.text,
                                 feePercentText: mainPageView.feeAmountTF.text,
                                 serviceChargePercentText: mainPageView.serviceChargeAmountTF.text,
                                 calculateVatOnSc: mainPageView.vatOnScSwitch.isOn)
        initDelegates()
        initButtonTargets()
    }
    
    func bindViewModel() {
        viewModel.vatAmountText.bind { [weak self] vatAmountText in
            guard let self = self else { return }
            self.mainPageView.vatAmountTF.text = vatAmountText
        }
        
        viewModel.feeAmountText.bind { [weak self] feeAmountText in
            guard let self = self else { return }
            self.mainPageView.feeAmountTF.text = feeAmountText
        }
        
        viewModel.serviceChargeAmountText.bind { [weak self] serviceChargeAmountText in
            guard let self = self else { return }
            self.mainPageView.serviceChargeAmountTF.text = serviceChargeAmountText
        }
        
        viewModel.vatOnScSwitch.bind { [weak self] vatOnScSwitch in
            guard let self = self else { return }
            self.mainPageView.vatOnScSwitch.isOn = vatOnScSwitch
        }
        
        viewModel.vatOnScSwitchIsEnabled.bind { [weak self] isEnabled in
            guard let self = self else { return }
            self.mainPageView.updateSlider(isEnabled: isEnabled)
        }
        
        viewModel.gross.bind { [weak self] gross in
            guard let self = self else { return }
            self.mainPageView.updateGross(gross: gross)
        }
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
        viewModel.updateElements(vatPercentText: mainPageView.vatAmountTF.text,
                                 feePercentText: mainPageView.feeAmountTF.text,
                                 serviceChargePercentText: mainPageView.serviceChargeAmountTF.text,
                                 calculateVatOnSc: mainPageView.vatOnScSwitch.isOn)
        viewModel.saveSwitchStateToPersistence(isEnabled: sender.isOn)
    }
    
    @objc func openCalculatorButtonTapped() {
        view.endEditing(true)
        viewModel.showCalculatorPage()
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
            viewModel.updateElements(vatPercentText: mainPageView.vatAmountTF.text,
                                     feePercentText: mainPageView.feeAmountTF.text,
                                     serviceChargePercentText: mainPageView.serviceChargeAmountTF.text,
                                     calculateVatOnSc: mainPageView.vatOnScSwitch.isOn)
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
        viewModel.updateElements(vatPercentText: mainPageView.vatAmountTF.text,
                                 feePercentText: mainPageView.feeAmountTF.text,
                                 serviceChargePercentText: mainPageView.serviceChargeAmountTF.text,
                                 calculateVatOnSc: mainPageView.vatOnScSwitch.isOn)
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
        viewModel.saveTextFieldTextToPersistence(textFieldName: textFieldName, text: text)
    }
    
    @objc
    func handleTextDidChangeNotification(_ notification: Notification) {
        guard let textField = notification.object as? UITextField else { return }
        let _ = checkEnteredText(textField)
    }
}
