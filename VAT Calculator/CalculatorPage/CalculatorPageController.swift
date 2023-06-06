import UIKit

protocol CalculatorPageControllerProtocol: AnyObject {
    func disableVat()
    func disableFee()
    func disableServiceCharge()
    func disableVatOnServiceCharge()
    func hideVat(_ hideZeroLines: Bool)
    func hideFee(_ hideZeroLines: Bool)
    func hideServiceCharge(_ hideZeroLines: Bool)
    func hideVatOnServiceCharge(_ hideZeroLines: Bool)
    func updateNet(_ netAmount: Double)
    func updateVat(_ vatAmount: Double)
    func updateFee(_ feeAmount: Double)
    func updateServiceCharge(_ serviceChargeAmount: Double)
    func updateVatOnServiceCharge(_ vatOnScAmount: Double)
    func updateTotalVat(_ totalVatAmount: Double)
    func updateGross(_ grossAmount: Double)
    func updateRounding(_ rounding: Int)
    func presentNextVC(_ vc: UIViewController, animated: Bool)
}

class CalculatorPageController: UIViewController {
    // MARK: - ViewController Lifecycle
    init(viewModel: CalculatorPageViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    private let viewModel: CalculatorPageViewModelProtocol
    private var rounding = 2
}

// MARK: - Private methods
private extension CalculatorPageController {
    func initialize() {
        title = UIConstants.calculatorPageNavigationTitle
        viewModel.disableZeroLines()
        viewModel.initialHidingZeroLines()
        viewModel.setRoundingFromPersistence()
        viewModel.updateElements(.initiatedByGross, updateBothTF: true)
        configureNavigationBar()
        initDelegates()
    }
    
    func bindViewModel() {
        
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
    
    func updateLabel(_ label: UILabel, newAmount: Double) {
        let textAmount = String(format: "%.\(rounding)f", newAmount)
        label.text = textAmount
    }
    
    func updateTextField(_ textField: UITextField, newAmount: Double) {
        let textAmount = String(format: "%.\(rounding)f", newAmount)
        textField.text = textAmount
    }
    
    @objc func openCalculatorSettingButtonTapped() {
        view.endEditing(true)
        viewModel.showSettingsPage()
    }
}

extension CalculatorPageController: CalculatorPageControllerProtocol {
    func disableVat() {
        calculatorPageView.vatNameLabel.isEnabled = false
        calculatorPageView.vatAmountLabel.isEnabled = false
    }
    
    func disableFee() {
        calculatorPageView.feeNameLabel.isEnabled = false
        calculatorPageView.feeAmountLabel.isEnabled = false
    }
    
    func disableServiceCharge() {
        calculatorPageView.serviceChargeNameLabel.isEnabled = false
        calculatorPageView.serviceChargeAmountLabel.isEnabled = false
    }
    
    func disableVatOnServiceCharge() {
        calculatorPageView.vatOnScNameLabel.isEnabled = false
        calculatorPageView.vatOnScAmountLabel.isEnabled = false
        calculatorPageView.totalVatStack.isHidden = true
    }
    
    func hideVat(_ hideZeroLines: Bool) {
        calculatorPageView.vatStack.isHidden = hideZeroLines
    }
    
    func hideFee(_ hideZeroLines: Bool) {
        calculatorPageView.feeStack.isHidden = hideZeroLines
    }
    
    func hideServiceCharge(_ hideZeroLines: Bool) {
        calculatorPageView.serviceChargeStack.isHidden = hideZeroLines
    }
    
    func hideVatOnServiceCharge(_ hideZeroLines: Bool) {
        calculatorPageView.vatOnScStack.isHidden = hideZeroLines
    }
    
    func updateNet(_ netAmount: Double) {
        updateTextField(calculatorPageView.netAmountTF, newAmount: netAmount)
    }
    
    func updateVat(_ vatAmount: Double) {
        updateLabel(calculatorPageView.vatAmountLabel, newAmount: vatAmount)
    }
    
    func updateFee(_ feeAmount: Double) {
        updateLabel(calculatorPageView.feeAmountLabel, newAmount: feeAmount)
    }
    
    func updateServiceCharge(_ serviceChargeAmount: Double) {
        updateLabel(calculatorPageView.serviceChargeAmountLabel, newAmount: serviceChargeAmount)
    }
    
    func updateVatOnServiceCharge(_ vatOnScAmount: Double) {
        updateLabel(calculatorPageView.vatOnScAmountLabel, newAmount: vatOnScAmount)
    }
    
    func updateTotalVat(_ totalVatAmount: Double) {
        updateLabel(calculatorPageView.totalVatAmountLabel, newAmount: totalVatAmount)
    }
    
    func updateGross(_ grossAmount: Double) {
        updateTextField(calculatorPageView.grossAmountTF, newAmount: grossAmount)
    }
    
    func updateRounding(_ rounding: Int) {
        self.rounding = rounding
    }
    
    func presentNextVC(_ vc: UIViewController, animated: Bool) {
        present(vc, animated: animated)
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
            viewModel.saveNetToModel(netSales)
            viewModel.updateElements(.initiatedByNet, updateBothTF: updateBothTF)
        case calculatorPageView.grossAmountTF:
            let grossSales = Double(text) ?? 0
            viewModel.saveGrossToModel(grossSales)
            viewModel.updateElements(.initiatedByGross, updateBothTF: updateBothTF)
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
        viewModel.saveGrossToPersistence()
    }
    
    @objc
    func handleTextDidChangeNotification(_ notification: Notification) {
        guard let textField = notification.object as? UITextField else { return }
        guard checkEnteredText(textField) else { return }
        updateModelAndView(textField, updateBothTF: false)
    }
}
