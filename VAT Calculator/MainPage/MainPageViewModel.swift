import RxSwift
import RxRelay

protocol MainPageViewModelProtocol {
    var model: MainPageModel { get set }
    var vatPercentText: BehaviorRelay<String> { get }
    var feePercentText: BehaviorRelay<String> { get }
    var serviceChargePercentText: BehaviorRelay<String> { get }
    var calculateVatOnSc: BehaviorRelay<Bool> { get }
    var vatOnScSwitchIsEnabled: Observable<Bool> { get }
    var grossPercent: Observable<String>? { get }
}

class MainPageViewModel: MainPageViewModelProtocol {
    // MARK: - Public properties
    var model: MainPageModel
    let vatPercentText = BehaviorRelay<String>(value: "")
    let feePercentText = BehaviorRelay<String>(value: "")
    let serviceChargePercentText = BehaviorRelay<String>(value: "")
    let calculateVatOnSc = BehaviorRelay<Bool>(value: false)
    let vatOnScSwitchIsEnabled: Observable<Bool>
    var grossPercent: Observable<String>?
    
    init(model: MainPageModel) {
        self.model = model
        vatOnScSwitchIsEnabled = Observable.combineLatest(vatPercentText, serviceChargePercentText) { vatPercentText, serviceChargePercentText in
            let vatPercent = Double(vatPercentText) ?? 0
            let serviceChargePercent = Double(serviceChargePercentText) ?? 0
            return vatPercent > 0 && serviceChargePercent > 0
        }
        initialize()
    }
    
    // MARK: - Private properties
    private let disposeBag = DisposeBag()
}

private extension MainPageViewModel {
    func initialize() {
        checkIsFirstLaunch()
        UserDefaultsManager.loadMainPageData(self)
        
        grossPercent = Observable.combineLatest(vatPercentText, feePercentText, serviceChargePercentText, calculateVatOnSc) { [weak self] _,_,_,_ in
            guard let self = self else { return "0" }
            return "\(self.model.gross.formatted(.number))"
        }
        
        vatPercentText
            .subscribe(onNext: { [weak self] in
                self?.model.vatPercent = Double($0) ?? 0
                UserDefaultsManager.saveMainPageTFData(textFieldName: UIConstants.vatName, text: $0)
            })
            .disposed(by: disposeBag)
        
        feePercentText
            .subscribe(onNext: { [weak self] in
                self?.model.feePercent = Double($0) ?? 0
                UserDefaultsManager.saveMainPageTFData(textFieldName: UIConstants.feeName, text: $0)
            })
            .disposed(by: disposeBag)
        
        serviceChargePercentText
            .subscribe(onNext: { [weak self] in
                self?.model.serviceChargePercent = Double($0) ?? 0
                UserDefaultsManager.saveMainPageTFData(textFieldName: UIConstants.serviceChargeName, text: $0)
            })
            .disposed(by: disposeBag)
        
        calculateVatOnSc
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] in
                UserDefaultsManager.saveMainPageSwitchData($0)
                self?.model.calculateVatOnSc = $0
            })
            .disposed(by: disposeBag)
    }
    
    func checkIsFirstLaunch() {
        let isFirstLaunch = UserDefaultsManager.loadIsFirstLaunch()
        if isFirstLaunch {
            UserDefaultsManager.saveIsFirstLaunch()
            UserDefaultsManager.saveSettingsPageRounding(2)
        }
    }
}
