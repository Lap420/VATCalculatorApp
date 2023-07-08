import UIKit

struct UserDefaultsManager {
    private static let userDefaults = UserDefaults.standard

    static func saveIsFirstLaunch() {
        userDefaults.set(true, forKey: UserDefaultKeys.isFirstLaunch.rawValue)
    }
    
    static func loadIsFirstLaunch() -> Bool {
        return !userDefaults.bool(forKey: UserDefaultKeys.isFirstLaunch.rawValue)
    }
    
    static func saveMainPageTFData(textFieldName: String, text: String) {
        let userDefaultsKey: String
        
        switch textFieldName {
        case UIConstants.vatName:
            userDefaultsKey = UserDefaultKeys.vat.rawValue
        case UIConstants.feeName:
            userDefaultsKey = UserDefaultKeys.fee.rawValue
        case UIConstants.serviceChargeName:
            userDefaultsKey = UserDefaultKeys.serviceCharge.rawValue
        default:
            return
        }
        
        userDefaults.set(text, forKey: userDefaultsKey)
    }
    
    static func saveMainPageSwitchData(_ isOn: Bool) {
        userDefaults.set(isOn, forKey: UserDefaultKeys.vatOnSc.rawValue)
    }
    
    static func loadMainPageData(_ viewModel: MainPageViewModelProtocol) {
        let vatPercent = userDefaults.double(forKey: UserDefaultKeys.vat.rawValue).formatted(.number)
        viewModel.vatPercentText.accept("\(vatPercent)")
        let feePercent = userDefaults.double(forKey: UserDefaultKeys.fee.rawValue).formatted(.number)
        viewModel.feePercentText.accept("\(feePercent)")
        let serviceChargePercent = userDefaults.double(forKey: UserDefaultKeys.serviceCharge.rawValue).formatted(.number)
        viewModel.serviceChargePercentText.accept("\(serviceChargePercent)")
        let calculateVatOnSc = userDefaults.bool(forKey: UserDefaultKeys.vatOnSc.rawValue)
        viewModel.calculateVatOnSc.accept(calculateVatOnSc)
    }
    
    static func saveCalculatorPageGrossSales(_ grossSales: Double) {
        userDefaults.set(grossSales, forKey: UserDefaultKeys.grossSales.rawValue)
    }
    
    static func loadCalculatorPageGrossSales(_ model: inout CalculatorPageModel) {
        let grossSales = userDefaults.double(forKey: UserDefaultKeys.grossSales.rawValue)
        model.setGross(grossSales)
    }
    
    static func saveSettingsPageRounding(_ value: Int) {
        userDefaults.set(value, forKey: UserDefaultKeys.rounding.rawValue)
    }
    
    static func loadSettingsPageRounding() -> Int {
        return userDefaults.integer(forKey: UserDefaultKeys.rounding.rawValue)
    }
    
    static func saveSettingsPageHideZeroLines(_ isOn: Bool) {
        userDefaults.set(isOn, forKey: UserDefaultKeys.hideZeroLines.rawValue)
    }
    
    static func loadSettingsPageHideZeroLines() -> Bool {
        return userDefaults.bool(forKey: UserDefaultKeys.hideZeroLines.rawValue)
    }
}

enum UserDefaultKeys: String {
    case vat
    case fee
    case serviceCharge
    case vatOnSc
    case grossSales
    case rounding
    case hideZeroLines
    case isFirstLaunch
}
