protocol MainPagePresenterProtocol: AnyObject {
    func checkIsFirstLaunch()
    func loadMainPageData()
    func initTextFieldsState()
    func updateElements(vatPercentText: String?,
                        feePercentText: String?,
                        serviceChargePercentText: String?,
                        calculateVatOnSc: Bool)
    func saveSwitchStateToPersistence(isEnabled: Bool)
    func saveTextFieldTextToPersistence(textFieldName: String, text: String)
    func showCalculatorPage()
    
    var vatAmountText: Boxing<String?> { get }
    var feeAmountText: Boxing<String?> { get }
    var serviceChargeAmountText: Boxing<String?> { get }
    var vatOnScSwitch: Boxing<Bool> { get }
    var vatOnScSwitchIsEnabled: Boxing<Bool> { get }
    var gross: Boxing<Double> { get }
}

class MainPageViewModel: MainPagePresenterProtocol {
    init(model: MainPageModel, router: RouterProtocol) {
        mainPageModel = model
        self.router = router
    }
    
    private var mainPageModel: MainPageModel
    private var router: RouterProtocol?
    
    var vatAmountText: Boxing<String?> = Boxing("")
    var feeAmountText: Boxing<String?> = Boxing("")
    var serviceChargeAmountText: Boxing<String?> = Boxing("")
    var vatOnScSwitch: Boxing<Bool> = Boxing(false)
    var vatOnScSwitchIsEnabled: Boxing<Bool> = Boxing(false)
    var gross: Boxing<Double> = Boxing(0.0)
}

extension MainPageViewModel {
    func checkIsFirstLaunch() {
        let isFirstLaunch = UserDefaultsManager.loadIsFirstLaunch()
        if isFirstLaunch {
            UserDefaultsManager.saveIsFirstLaunch()
            UserDefaultsManager.saveSettingsPageRounding(2)
        }
    }
    
    func loadMainPageData() {
        UserDefaultsManager.loadMainPageData(&mainPageModel)
    }
    
    func initTextFieldsState() {
        vatAmountText.value = mainPageModel.vatPercent > 0 ? String(mainPageModel.vatPercent.formatted(.number)) : nil
        feeAmountText.value = mainPageModel.feePercent > 0 ? String(mainPageModel.feePercent.formatted(.number)) : nil
        serviceChargeAmountText.value = mainPageModel.serviceChargePercent > 0 ? String(mainPageModel.serviceChargePercent.formatted(.number)) : nil
        vatOnScSwitch.value = mainPageModel.calculateVatOnSc
    }
    
    func updateElements(vatPercentText: String?,
                        feePercentText: String?,
                        serviceChargePercentText: String?,
                        calculateVatOnSc: Bool) {
        let vatPercent = Double(vatPercentText ?? "0") ?? 0
        let feePercent = Double(feePercentText ?? "0") ?? 0
        let serviceChargePercent = Double(serviceChargePercentText ?? "0") ?? 0
        mainPageModel.updateCharges(vatPercent: vatPercent,
                                    feePercent: feePercent,
                                    serviceChargePercent: serviceChargePercent,
                                    calculateVatOnSc: calculateVatOnSc)
        vatOnScSwitchIsEnabled.value = mainPageModel.vatPercent > 0 && mainPageModel.serviceChargePercent > 0
        gross.value = mainPageModel.gross
    }
    
    func saveSwitchStateToPersistence(isEnabled: Bool) {
        UserDefaultsManager.saveMainPageSwitchData(isEnabled)
    }
    
    func saveTextFieldTextToPersistence(textFieldName: String, text: String) {
        UserDefaultsManager.saveMainPageTFData(textFieldName: textFieldName, text: text)
    }
    
    func showCalculatorPage() {
        router?.showCalculatorPage(mainPageModel: mainPageModel)
    }
}
