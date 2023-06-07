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
    
    var isEnabledVat: Boxing<Bool> { get }
    var isEnabledFee: Boxing<Bool> { get }
    var isEnabledServiceCharge: Boxing<Bool> { get }
    var isEnabledVatOnServiceCharge: Boxing<Bool> { get }
    var isHiddenVat: Boxing<Bool> { get }
    var isHiddenFee: Boxing<Bool> { get }
    var isHiddenServiceCharge: Boxing<Bool> { get }
    var isHiddenVatOnServiceCharge: Boxing<Bool> { get }
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
    var isEnabledVat: Boxing<Bool> = Boxing(true)
    var isEnabledFee: Boxing<Bool> = Boxing(true)
    var isEnabledServiceCharge: Boxing<Bool> = Boxing(true)
    var isEnabledVatOnServiceCharge: Boxing<Bool> = Boxing(true)
    var isHiddenVat: Boxing<Bool> = Boxing(false)
    var isHiddenFee: Boxing<Bool> = Boxing(false)
    var isHiddenServiceCharge: Boxing<Bool> = Boxing(false)
    var isHiddenVatOnServiceCharge: Boxing<Bool> = Boxing(false)
}

extension CalculatorPageViewModel {
    func disableZeroLines() {
        if calculatorPageModel.vatPercent == 0 {
            isEnabledVat.value = false
        }
        if calculatorPageModel.feePercent == 0 {
            isEnabledFee.value = false
        }
        if calculatorPageModel.serviceChargePercent == 0 {
            isEnabledServiceCharge.value = false
        }
        if !calculatorPageModel.calculateVatOnSc || calculatorPageModel.serviceChargePercent == 0 || calculatorPageModel.vatPercent == 0 {
            isEnabledVatOnServiceCharge.value = false
        }
    }
    
    func hideOrShowZeroLines(_ hideZeroLines: Bool) {
        if calculatorPageModel.vatPercent == 0 {
            isHiddenVat.value = hideZeroLines
        }
        
        if calculatorPageModel.feePercent == 0 {
            isHiddenFee.value = hideZeroLines
        }
        
        if calculatorPageModel.serviceChargePercent == 0 {
            isHiddenServiceCharge.value = hideZeroLines
        }
        if !calculatorPageModel.calculateVatOnSc || calculatorPageModel.serviceChargePercent == 0 || calculatorPageModel.vatPercent == 0 {
            isHiddenVatOnServiceCharge.value = hideZeroLines
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
