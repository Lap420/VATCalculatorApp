import UIKit

protocol RouterProtocol {
    func showCalculatorPage(mainPageModel: MainPageModel)
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
//        let nextVC = CalculatorPageAssembly(router: self).getViewController()
//        nextVC.setCharges(vatPercent: mainPageModel.vatPercent,
//                          feePercent: mainPageModel.feePercent,
//                          serviceChargePercent: mainPageModel.serviceChargePercent,
//                          calculateVatOnSc: mainPageModel.calculateVatOnSc)
        let nextVC = CalculatorPageAssembly(router: self, mainPageModel: mainPageModel).getViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
}
