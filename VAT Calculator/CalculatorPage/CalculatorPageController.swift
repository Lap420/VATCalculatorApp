import UIKit

class CalculatorPageController: UIViewController {
    // MARK: - Public methods
    func setCharges(vatPercent: Double,
                    feePercent: Double,
                    serviceChargePercent: Double,
                    calculateVatOnSc: Bool) {
        calculatorPageModel.setCharges(vatPercent: vatPercent,
                                       feePercent: feePercent,
                                       serviceChargePercent: serviceChargePercent,
                                       calculateVatOnSc: calculateVatOnSc)
    }
    
    // MARK: - ViewController Lifecycle
    override func loadView() {
        view = calculatorPageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextDidChangeNotification(_:)), name: UITextField.textDidChangeNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UITextField.textDidChangeNotification, object: nil)
    }

    // MARK: - Private properties
    private lazy var calculatorPageView = CalculatorPageView()
    private var calculatorPageModel = CalculatorPageModel()
    private var rounding = 2
}

// MARK: - Private methods
private extension CalculatorPageController {
    func initialize() {
        title = UIConstants.calculatorPageNavigationTitle
        UserDefaultsManager.loadCalculatorPageGrossSales(&calculatorPageModel)
        disableZeroLines()
        hideOrShowZeroLines(UserDefaultsManager.loadSettingsPageHideZeroLines())
        rounding = UserDefaultsManager.loadSettingsPageRounding()
        updateElements(.initiatedByGross, updateBothTF: true)
        configureNavigationBar()
        initDelegates()
    }
    
    func disableZeroLines() {
        if calculatorPageModel.vatPercent == 0 {
            calculatorPageView.vatNameLabel.isEnabled = false
            calculatorPageView.vatAmountLabel.isEnabled = false
        }
        if calculatorPageModel.feePercent == 0 {
            calculatorPageView.feeNameLabel.isEnabled = false
            calculatorPageView.feeAmountLabel.isEnabled = false
        }
        if calculatorPageModel.serviceChargePercent == 0 {
            calculatorPageView.serviceChargeNameLabel.isEnabled = false
            calculatorPageView.serviceChargeAmountLabel.isEnabled = false
        }
        if !calculatorPageModel.calculateVatOnSc || calculatorPageModel.serviceChargePercent == 0 || calculatorPageModel.vatPercent == 0 {
            calculatorPageView.vatOnScNameLabel.isEnabled = false
            calculatorPageView.vatOnScAmountLabel.isEnabled = false
            calculatorPageView.totalVatStack.isHidden = true
        }
    }
    
    func hideOrShowZeroLines(_ hideZeroLines: Bool) {
        if calculatorPageModel.vatPercent == 0 {
            calculatorPageView.vatStack.isHidden = hideZeroLines
        }
        if calculatorPageModel.feePercent == 0 {
            calculatorPageView.feeStack.isHidden = hideZeroLines
        }
        if calculatorPageModel.serviceChargePercent == 0 {
            calculatorPageView.serviceChargeStack.isHidden = hideZeroLines
        }
        if !calculatorPageModel.calculateVatOnSc || calculatorPageModel.serviceChargePercent == 0 || calculatorPageModel.vatPercent == 0 {
            calculatorPageView.vatOnScStack.isHidden = hideZeroLines
        }
    }
    
    func configureNavigationBar() {
        let settingsButton = UIBarButtonItem(image: .init(systemName: UIConstants.settingsIconName), style: .plain, target: self, action: #selector(openCalculatorSettingButtonTapped))
        settingsButton.accessibilityIdentifier = "openSettingsButton"
        navigationItem.setRightBarButton(settingsButton, animated: true)
    }
    
    func initDelegates() {
        calculatorPageView.netAmountTF.delegate = self
        calculatorPageView.grossAmountTF.delegate = self
    }
    
    func updateNet(_ calculatorUpdateType: CalculatorUpdateType) {
        let netAmount = calculatorPageModel.getNet(calculatorUpdateType)
        updateTextField(calculatorPageView.netAmountTF, newAmount: netAmount)
    }
    
    func updateVat(_ calculatorUpdateType: CalculatorUpdateType) {
        let vatAmount = calculatorPageModel.getVat(calculatorUpdateType)
        updateLabel(calculatorPageView.vatAmountLabel, newAmount: vatAmount)
    }
    
    func updateFee(_ calculatorUpdateType: CalculatorUpdateType) {
        let feeAmount = calculatorPageModel.getFee(calculatorUpdateType)
        updateLabel(calculatorPageView.feeAmountLabel, newAmount: feeAmount)
    }
    
    func updateServiceCharge(_ calculatorUpdateType: CalculatorUpdateType) {
        let serviceChargeAmount = calculatorPageModel.getServiceCharge(calculatorUpdateType)
        updateLabel(calculatorPageView.serviceChargeAmountLabel, newAmount: serviceChargeAmount)
    }
    
    func updateVatOnServiceCharge(_ calculatorUpdateType: CalculatorUpdateType) {
        let vatOnScAmount = calculatorPageModel.getVatOnSc(calculatorUpdateType)
        updateLabel(calculatorPageView.vatOnScAmountLabel, newAmount: vatOnScAmount)
    }
    
    func updateTotalVat(_ calculatorUpdateType: CalculatorUpdateType) {
        let totalVatAmount = calculatorPageModel.getTotalVat(calculatorUpdateType)
        updateLabel(calculatorPageView.totalVatAmountLabel, newAmount: totalVatAmount)
    }
    
    func updateGross(_ calculatorUpdateType: CalculatorUpdateType) {
        let grossAmount = calculatorPageModel.getGross(calculatorUpdateType)
        updateTextField(calculatorPageView.grossAmountTF, newAmount: grossAmount)
    }
    
    func updateLabel(_ label: UILabel, newAmount: Double) {
        let textAmount = String(format: "%.\(rounding)f", newAmount)
        label.text = textAmount
    }
    
    func updateTextField(_ textField: UITextField, newAmount: Double) {
        let textAmount = String(format: "%.\(rounding)f", newAmount)
        textField.text = textAmount
    }
    
    func updateElements(_ calculatorUpdateType: CalculatorUpdateType, updateBothTF: Bool) {
        if updateBothTF {
            updateNet(calculatorUpdateType)
            updateGross(calculatorUpdateType)
        } else {
            if calculatorUpdateType == .initiatedByGross {
                updateNet(calculatorUpdateType)
            } else {
                updateGross(calculatorUpdateType)
            }
        }
        updateVat(calculatorUpdateType)
        updateFee(calculatorUpdateType)
        updateServiceCharge(calculatorUpdateType)
        updateVatOnServiceCharge(calculatorUpdateType)
        updateTotalVat(calculatorUpdateType)
    }
    
    @objc func openCalculatorSettingButtonTapped() {
        view.endEditing(true)
        let nextVC = SettingsPageController()
        nextVC.calculatorPageDelegate = self
        let navigationVC = UINavigationController(rootViewController: nextVC)
        navigationVC.navigationBar.titleTextAttributes = UIConstants.navigationTitleAttributes
        let closeButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeSettings))
        nextVC.navigationItem.leftBarButtonItem = closeButton
        guard let sheet = navigationVC.sheetPresentationController else { return }
        sheet.detents = [.medium()]
        sheet.prefersGrabberVisible = true
        present(navigationVC, animated: true)
    }
    
    @objc
    func closeSettings() {
        dismiss(animated: true)
    }
}

extension CalculatorPageController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }

    func getChoosenTextFieldName(_ textField: UITextField) -> String {
        let field: String
        switch textField {
        case calculatorPageView.netAmountTF:
            field = String(UIConstants.netSalesName)
        case calculatorPageView.grossAmountTF:
            field = String(UIConstants.grossSalesName)
        default:
            field = "some"
        }
        return field
    }
    
    func checkEnteredText(_ textField: UITextField) -> Bool {
        guard let text = textField.text else { return true }
        guard !text.isEmpty else { return true }
        guard let _ = Double(text) else {
            let textFieldName = getChoosenTextFieldName(textField)
            let alert = AlertManager.incorrectValueAlert(textFieldName: textFieldName, textField: textField)
            present(alert, animated: true)
            return false
        }
        return true
    }
    
    func updateModelAndView(_ textField: UITextField, updateBothTF: Bool) {
        guard let text = textField.text else { return }
        switch textField {
        case calculatorPageView.netAmountTF:
            let netSales = Double(text) ?? 0.0
            calculatorPageModel.setNet(netSales)
            updateElements(.initiatedByNet, updateBothTF: updateBothTF)
        case calculatorPageView.grossAmountTF:
            let grossSales = Double(text) ?? 0
            calculatorPageModel.setGross(grossSales)
            updateElements(.initiatedByGross, updateBothTF: updateBothTF)
        default: return
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        updateModelAndView(textField, updateBothTF: false)
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        let isTextValid = checkEnteredText(textField)
        guard isTextValid else { return false }
        updateModelAndView(textField, updateBothTF: true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let gross = calculatorPageModel.getGross(.initiatedByGross)
        UserDefaultsManager.saveCalculatorPageGrossSales(gross)
    }
    
    @objc
    func handleTextDidChangeNotification(_ notification: Notification) {
        guard let textField = notification.object as? UITextField else { return }
        guard checkEnteredText(textField) else { return }
        updateModelAndView(textField, updateBothTF: false)
    }
}

extension CalculatorPageController: CalculatorPageDelegate {
    func updateRounding(_ rounding: Int) {
        self.rounding = rounding
        updateElements(.initiatedByGross, updateBothTF: true)
    }
    
    func updateHideZeroLines(_ hideZeroLines: Bool) {
        hideOrShowZeroLines(hideZeroLines)
    }
}

protocol CalculatorPageDelegate: AnyObject {
    func updateRounding(_ rounding: Int)
    func updateHideZeroLines(_ hideZeroLines: Bool)
}
