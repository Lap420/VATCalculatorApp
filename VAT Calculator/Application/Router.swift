import UIKit

protocol RouterProtocol {
    func showCalculatorPage(mainPageModel: MainPageModel)
    func showSettingsPage(presenter: CalculatorPageDelegate)
}

class Router {
    private var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func initialViewControllerAssembly() -> MainPageAssembly {
        MainPageAssembly(router: self)
    }
}

extension Router: RouterProtocol {
    func showCalculatorPage(mainPageModel: MainPageModel) {
        let nextVC = CalculatorPageAssembly(router: self, mainPageModel: mainPageModel).getViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func showSettingsPage(presenter: CalculatorPageDelegate) {
        let nextVC = SettingsPageAssembly(router: self).getViewController()
        nextVC.setCalculatorPageDelegate(presenter: presenter)
        let navigationVC = UINavigationController(rootViewController: nextVC)
        navigationVC.navigationBar.titleTextAttributes = UIConstants.navigationTitleAttributes
        guard let sheet = navigationVC.sheetPresentationController else { return }
        sheet.detents = [.medium()]
        sheet.prefersGrabberVisible = true
        presenter.presenterViewController?.presentNextVC(navigationVC, animated: true)
    }
}
