protocol CalculatorPageAssemblyProtocol {
    func getViewController() -> CalculatorPageController
}

class CalculatorPageAssembly: CalculatorPageAssemblyProtocol {
    func getViewController() -> CalculatorPageController {
        var model = CalculatorPageModel()
        model.setCharges(vatPercent: mainPageModel.vatPercent,
                         feePercent: mainPageModel.feePercent,
                         serviceChargePercent: mainPageModel.serviceChargePercent,
                         calculateVatOnSc: mainPageModel.calculateVatOnSc)
        let presenter = CalculatorPagePresenter(model: model, router: router)
        let viewController = CalculatorPageController(presenter: presenter)
        presenter.viewController = viewController
        return viewController
    }
    
    init(router: RouterProtocol, mainPageModel: MainPageModel) {
        self.router = router
        self.mainPageModel = mainPageModel
    }
    
    private let router: RouterProtocol
    private let mainPageModel: MainPageModel
}
