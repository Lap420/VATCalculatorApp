import UIKit

protocol MainPagePresenterProtocol: AnyObject {
    func checkIsFirstLaunch()
    func loadMainPageData()
    func initTextFieldsState()
    func updateElements()
    func updateSlider()
    func updateGross()
    func saveSwitchStateToPersistence(isEnabled: Bool)
    func saveTextFieldTextToPersistence(textFieldName: String, text: String)
    func showCalculatorPage()
}

class MainPagePresenter {
    init(model: MainPageModel, router: RouterProtocol) {
        mainPageModel = model
        self.router = router
    }
    
    weak var viewController: MainPageControllerProtocol?
    private var mainPageModel: MainPageModel
    private var router: RouterProtocol?
}

extension MainPagePresenter: MainPagePresenterProtocol {
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
        let vatAmountText = mainPageModel.vatPercent > 0 ? String(mainPageModel.vatPercent.formatted(.number)) : nil
        let feeAmountText = mainPageModel.feePercent > 0 ? String(mainPageModel.feePercent.formatted(.number)) : nil
        let serviceChargeAmountText = mainPageModel.serviceChargePercent > 0 ? String(mainPageModel.serviceChargePercent.formatted(.number)) : nil
        let vatOnScSwitch = mainPageModel.calculateVatOnSc
        viewController?.initTextFieldsState(vatAmountText: vatAmountText,
                                            feeAmountText: feeAmountText,
                                            serviceChargeAmountText: serviceChargeAmountText,
                                            vatOnScSwitch: vatOnScSwitch)
    }
    
    func updateElements() {
        let textFieldsData = viewController?.getTextFieldsData()
        if let textFieldsData = textFieldsData {
            mainPageModel.updateCharges(vatPercent: textFieldsData.0,
                                        feePercent: textFieldsData.1,
                                        serviceChargePercent: textFieldsData.2,
                                        calculateVatOnSc: textFieldsData.3)
        }
        updateSlider()
        updateGross()
    }
    
    func updateSlider() {
        let isEnabled = mainPageModel.vatPercent > 0 && mainPageModel.serviceChargePercent > 0
        viewController?.updateSlider(isEnabled: isEnabled)
    }
    
    func updateGross() {
        let gross = mainPageModel.gross
        viewController?.updateGross(gross: gross)
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
