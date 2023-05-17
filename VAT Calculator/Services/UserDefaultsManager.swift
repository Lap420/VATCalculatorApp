import UIKit

struct UserDefaultsManager {
    private static let userDefaults = UserDefaults.standard
        
    static func saveMainPageTFData(_ view: MainPageView, textField: UITextField) {
        let userDefaultsValue = textField.text ?? ""
        let userDefaultsKey: String
        
        switch textField {
        case view.vatAmountTF:
            userDefaultsKey = UserDefaultKeys.vat.rawValue
        case view.feeAmountTF:
            userDefaultsKey = UserDefaultKeys.fee.rawValue
        case view.serviceChargeAmountTF:
            userDefaultsKey = UserDefaultKeys.serviceCharge.rawValue
        default:
            return
        }
        
        userDefaults.set(userDefaultsValue, forKey: userDefaultsKey)
    }
    
    static func saveMainPageSwitchData(_ isOn: Bool) {
        userDefaults.set(isOn, forKey: UserDefaultKeys.vatOnSc.rawValue)
    }
    
    static func loadMainPageData(_ model: inout MainPageModel) {
        let vatPercent = userDefaults.double(forKey: UserDefaultKeys.vat.rawValue)
        let feePercent = userDefaults.double(forKey: UserDefaultKeys.fee.rawValue)
        let serviceChargePercent = userDefaults.double(forKey: UserDefaultKeys.serviceCharge.rawValue)
        let calculateVatOnSc = userDefaults.bool(forKey: UserDefaultKeys.vatOnSc.rawValue)
        model.updateCharges(vatPercent: vatPercent, feePercent: feePercent, serviceChargePercent: serviceChargePercent, calculateVatOnSc: calculateVatOnSc)
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
    
    static func saveIsFirstLaunch() {
        userDefaults.set(true, forKey: UserDefaultKeys.isFirstLaunch.rawValue)
    }
    
    static func loadIsFirstLaunch() -> Bool {
        return !userDefaults.bool(forKey: UserDefaultKeys.isFirstLaunch.rawValue)
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
