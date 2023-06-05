protocol MainPageAssemblyProtocol {
    func getViewController() -> MainPageController
}

class MainPageAssembly: MainPageAssemblyProtocol {
    func getViewController() -> MainPageController {
        let model = MainPageModel()
        let viewModel = MainPageViewModel(model: model, router: router)
        let viewController = MainPageController(viewModel: viewModel)
        return viewController
    }
    
    init(router: RouterProtocol) {
        self.router = router
    }
    
    private let router: RouterProtocol
}
