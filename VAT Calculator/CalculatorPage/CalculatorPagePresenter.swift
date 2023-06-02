protocol CalculatorPagePresenterProtocol: AnyObject {
//    func checkIsFirstLaunch()
//    func loadMainPageData()
//    func initTextFieldsState()
//    func updateElements()
//    func updateSlider()
//    func updateGross()
//    func saveSwitchStateToPersistence(isEnabled: Bool)
//    func saveTextFieldTextToPersistence(textFieldName: String, text: String)
//    func showCalculatorPage()
}

class CalculatorPagePresenter: CalculatorPagePresenterProtocol {
    init(model: CalculatorPageModel, router: RouterProtocol) {
        calculatorPageModel = model
        self.router = router
    }
    
    weak var viewController: CalculatorPageControllerProtocol?
    private var calculatorPageModel: CalculatorPageModel
    private var router: RouterProtocol?
}
