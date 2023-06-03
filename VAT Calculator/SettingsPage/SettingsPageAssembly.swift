protocol SettingsPageAssemblyProtocol {
    func getViewController() -> SettingsPageController
}

class SettingsPageAssembly: SettingsPageAssemblyProtocol {
    func getViewController() -> SettingsPageController {
        let presenter = SettingsPagePresenter(router: router)
        let viewController = SettingsPageController(presenter: presenter)
        presenter.viewController = viewController
        return viewController
    }
    
    init(router: RouterProtocol) {
        self.router = router
    }
    
    private let router: RouterProtocol
}

