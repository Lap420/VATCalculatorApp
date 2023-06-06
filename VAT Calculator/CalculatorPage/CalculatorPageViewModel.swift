protocol CalculatorPageViewModelProtocol: AnyObject {
    func disableZeroLines()
    func hideOrShowZeroLines(_ hideZeroLines: Bool)
    func initialHidingZeroLines()
    func updateElements(_ calculatorUpdateType: CalculatorUpdateType, updateBothTF: Bool)
    func saveGrossToPersistence()
    func saveGrossToModel(_ grossSales: Double)
    func saveNetToModel(_ netSales: Double)
    func showSettingsPage()
    func setRounding(_ rounding: Int)
    func setRoundingFromPersistence()
    
    var disableVat: Boxing<Bool> { get }
}

class CalculatorPageViewModel: CalculatorPageViewModelProtocol {
    init(model: CalculatorPageModel, router: RouterProtocol) {
        calculatorPageModel = model
        UserDefaultsManager.loadCalculatorPageGrossSales(&calculatorPageModel)
        self.router = router
    }
    weak var viewController: CalculatorPageControllerProtocol?
    private var calculatorPageModel: CalculatorPageModel
    private var router: RouterProtocol?
    var disableVat: Boxing<Bool> = Boxing(false)
}

extension CalculatorPageViewModel {
    func disableZeroLines() {
        if calculatorPageModel.vatPercent == 0 {
            viewController?.disableVat()
        }
        if calculatorPageModel.feePercent == 0 {
            viewController?.disableFee()
        }
        if calculatorPageModel.serviceChargePercent == 0 {
            viewController?.disableServiceCharge()
        }
        if !calculatorPageModel.calculateVatOnSc || calculatorPageModel.serviceChargePercent == 0 || calculatorPageModel.vatPercent == 0 {
            viewController?.disableVatOnServiceCharge()
        }
    }
    
    func hideOrShowZeroLines(_ hideZeroLines: Bool) {
        if calculatorPageModel.vatPercent == 0 {
            viewController?.hideVat(hideZeroLines)
        }
        
        if calculatorPageModel.feePercent == 0 {
            viewController?.hideFee(hideZeroLines)
        }
        
        if calculatorPageModel.serviceChargePercent == 0 {
            viewController?.hideServiceCharge(hideZeroLines)
        }
        if !calculatorPageModel.calculateVatOnSc || calculatorPageModel.serviceChargePercent == 0 || calculatorPageModel.vatPercent == 0 {
            viewController?.hideVatOnServiceCharge(hideZeroLines)
        }
    }
    
    func initialHidingZeroLines() {
        let hideZeroLines = UserDefaultsManager.loadSettingsPageHideZeroLines()
        hideOrShowZeroLines(hideZeroLines)
    }
    
    func updateNet(_ calculatorUpdateType: CalculatorUpdateType) {
        let netAmount = calculatorPageModel.getNet(calculatorUpdateType)
        viewController?.updateNet(netAmount)
    }
    
    func updateVat(_ calculatorUpdateType: CalculatorUpdateType) {
        let vatAmount = calculatorPageModel.getVat(calculatorUpdateType)
        viewController?.updateVat(vatAmount)
    }
    
    func updateFee(_ calculatorUpdateType: CalculatorUpdateType) {
        let feeAmount = calculatorPageModel.getFee(calculatorUpdateType)
        viewController?.updateFee(feeAmount)
    }
    
    func updateServiceCharge(_ calculatorUpdateType: CalculatorUpdateType) {
        let serviceChargeAmount = calculatorPageModel.getServiceCharge(calculatorUpdateType)
        viewController?.updateServiceCharge(serviceChargeAmount)
    }
    
    func updateVatOnServiceCharge(_ calculatorUpdateType: CalculatorUpdateType) {
        let vatOnScAmount = calculatorPageModel.getVatOnSc(calculatorUpdateType)
        viewController?.updateVatOnServiceCharge(vatOnScAmount)
    }
    
    func updateTotalVat(_ calculatorUpdateType: CalculatorUpdateType) {
        let totalVatAmount = calculatorPageModel.getTotalVat(calculatorUpdateType)
        viewController?.updateTotalVat(totalVatAmount)
    }
    
    func updateGross(_ calculatorUpdateType: CalculatorUpdateType) {
        let grossAmount = calculatorPageModel.getGross(calculatorUpdateType)
        viewController?.updateGross(grossAmount)
    }
    
    func updateElements(_ calculatorUpdateType: CalculatorUpdateType, updateBothTF: Bool) {
        if updateBothTF {
            updateNet(calculatorUpdateType)
            updateGross(calculatorUpdateType)
        } else {
            if calculatorUpdateType == .initiatedByGross {
                updateNet(calculatorUpdateType)
            } else {
                updateGross(calculatorUpdateType)
            }
        }
        updateVat(calculatorUpdateType)
        updateFee(calculatorUpdateType)
        updateServiceCharge(calculatorUpdateType)
        updateVatOnServiceCharge(calculatorUpdateType)
        updateTotalVat(calculatorUpdateType)
    }
    
    func saveGrossToPersistence() {
        let gross = calculatorPageModel.getGross(.initiatedByGross)
        UserDefaultsManager.saveCalculatorPageGrossSales(gross)
    }
    
    func saveGrossToModel(_ grossSales: Double) {
        calculatorPageModel.setGross(grossSales)
    }
    
    func saveNetToModel(_ netSales: Double) {
        calculatorPageModel.setNet(netSales)
    }
    
    func showSettingsPage() {
        router?.showSettingsPage(presenter: self)
    }
    
    func setRounding(_ rounding: Int) {
        viewController?.updateRounding(rounding)
    }
    
    func setRoundingFromPersistence() {
        let rounding = UserDefaultsManager.loadSettingsPageRounding()
        setRounding(rounding)
    }
}

protocol CalculatorPageDelegate: AnyObject {
    func updateRounding(_ rounding: Int)
    func updateHideZeroLines(_ hideZeroLines: Bool)
    var presenterViewController: CalculatorPageControllerProtocol? { get }
}

extension CalculatorPageViewModel: CalculatorPageDelegate {
    var presenterViewController: CalculatorPageControllerProtocol? {
        viewController
    }
    
    func updateRounding(_ rounding: Int) {
        viewController?.updateRounding(rounding)
        updateElements(.initiatedByGross, updateBothTF: true)
    }
    
    func updateHideZeroLines(_ hideZeroLines: Bool) {
        hideOrShowZeroLines(hideZeroLines)
    }
}
