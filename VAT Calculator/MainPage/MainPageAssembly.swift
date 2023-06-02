protocol MainPageAssemblyProtocol {
    func getViewController() -> MainPageController
}

class MainPageAssembly: MainPageAssemblyProtocol {
    func getViewController() -> MainPageController {
        let model = MainPageModel()
        let presenter = MainPagePresenter(model: model, router: router)
        let viewController = MainPageController(presenter: presenter)
        presenter.viewController = viewController
        return viewController
    }
    
    init(router: RouterProtocol) {
        self.router = router
    }
    
    private let router: RouterProtocol
}
