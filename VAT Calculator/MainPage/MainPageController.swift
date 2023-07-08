import UIKit
import RxSwift
import RxCocoa

class MainPageController: UIViewController {
    // MARK: - ViewController Lifecycle
    init(viewModel: MainPageViewModelProtocol, router: RouterProtocol) {
        self.viewModel = viewModel
        self.router = router
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mainPageView.startButtonAnimation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        mainPageView.stopButtonAnimation()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: - Private properties
    private let viewModel: MainPageViewModelProtocol
    private let router: RouterProtocol
    private lazy var mainPageView = MainPageView()
    private let disposeBag = DisposeBag()
}

// MARK: - Private methods
private extension MainPageController {
    func initialize() {
        title = UIConstants.mainPageNavigationTitle
        navigationController?.navigationBar.titleTextAttributes = UIConstants.navigationTitleAttributes
        mainPageView.openCalculatorButton.addTarget(self, action: #selector(openCalculatorButtonTapped), for: .touchUpInside)
        bindViewModel()
        bindView()
    }
    
    func bindViewModel() {
        viewModel.vatPercentText
            .map { $0 != "0" ? $0 : nil }
            .bind(to: mainPageView.vatPercentTF.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.feePercentText
            .map { $0 != "0" ? $0 : nil }
            .bind(to: mainPageView.feePercentTF.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.serviceChargePercentText
            .map { $0 != "0" ? $0 : nil }
            .bind(to: mainPageView.serviceChargePercentTF.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.calculateVatOnSc
            .bind(to: mainPageView.vatOnScSwitch.rx.isOn)
            .disposed(by: disposeBag)
        
        viewModel.vatOnScSwitchIsEnabled
            .bind(onNext: { [weak self] isEnabled in
                self?.mainPageView.updateSlider(isEnabled: isEnabled)
            })
            .disposed(by: disposeBag)
        
        viewModel.grossPercent?
            .bind(to: mainPageView.grossPercentLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    func bindView() {
        mainPageView.vatPercentTF.rx.text.orEmpty
            .filter{ [weak self] _ in
                guard let self = self else { return true }
                return self.checkEnteredText(self.mainPageView.vatPercentTF)
            }
            .bind(to: viewModel.vatPercentText)
            .disposed(by: disposeBag)
        
        mainPageView.feePercentTF.rx.text.orEmpty
            .filter{ [weak self] _ in
                guard let self = self else { return true }
                return self.checkEnteredText(self.mainPageView.feePercentTF)
            }
            .bind(to: viewModel.feePercentText)
            .disposed(by: disposeBag)
        
        mainPageView.serviceChargePercentTF.rx.text.orEmpty
            .filter{ [weak self] _ in
                guard let self = self else { return true }
                return self.checkEnteredText(self.mainPageView.serviceChargePercentTF)
            }
            .bind(to: viewModel.serviceChargePercentText)
            .disposed(by: disposeBag)
        
        mainPageView.vatOnScSwitch.rx.isOn
            .do(onNext: { [weak self] _ in self?.view.endEditing(true) })
            .bind(to: viewModel.calculateVatOnSc)
            .disposed(by: disposeBag)
    }
    
    func getChoosenTextFieldName(_ textField: UITextField) -> String {
        let field: String
        switch textField {
        case mainPageView.vatPercentTF:
            field = UIConstants.vatName
        case mainPageView.feePercentTF:
            field = UIConstants.feeName
        case mainPageView.serviceChargePercentTF:
            field = UIConstants.serviceChargeName
        default:
            field = "some"
        }
        return field
    }

    func checkEnteredText(_ textField: UITextField) -> Bool {
        guard let text = textField.text else { return true }
        guard !text.isEmpty else {
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
        return true
    }
    
    @objc
    func openCalculatorButtonTapped() {
        view.endEditing(true)
        router.showCalculatorPage(mainPageModel: viewModel.model)
    }
}
