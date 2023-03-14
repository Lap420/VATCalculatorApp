//
//  UserDefaultsManager.swift
//  VAT Calculator
//
//  Created by Lap on 14.03.2023.
//

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
    
    static func loadMainPageData(_ view: MainPageView) {
        view.vatAmountTF.text = userDefaults.string(forKey: UserDefaultKeys.vat.rawValue)
        view.feeAmountTF.text = userDefaults.string(forKey: UserDefaultKeys.fee.rawValue)
        view.serviceChargeAmountTF.text = userDefaults.string(forKey: UserDefaultKeys.serviceCharge.rawValue)
        view.vatOnScSwitch.isOn = userDefaults.bool(forKey: UserDefaultKeys.vatOnSc.rawValue)
    }
    
    static func saveCalculatorPageGrossSales(_ grossSales: Double) {
        userDefaults.set(grossSales, forKey: UserDefaultKeys.grossSales.rawValue)
    }
    
    static func loadCalculatorPageGrossSales(_ grossSales: inout Double) {
        grossSales = userDefaults.double(forKey: UserDefaultKeys.grossSales.rawValue)
    }
}

enum UserDefaultKeys: String {
    case vat
    case fee
    case serviceCharge
    case vatOnSc
    case grossSales
}
