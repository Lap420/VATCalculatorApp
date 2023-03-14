//
//  UserDefaultsManager.swift
//  VAT Calculator
//
//  Created by Lap on 14.03.2023.
//

import UIKit

struct UserDefaultsManager {
    private static let userDefaults = UserDefaults.standard
    
    static func loadMainPageData(_ view: MainPageView) {
        view.vatAmountTF.text = userDefaults.string(forKey: TaxKeys.vat.rawValue)
        view.feeAmountTF.text = userDefaults.string(forKey: TaxKeys.fee.rawValue)
        view.serviceChargeAmountTF.text = userDefaults.string(forKey: TaxKeys.serviceCharge.rawValue)
        view.vatOnScSwitch.isOn = userDefaults.bool(forKey: TaxKeys.vatOnSc.rawValue)
    }
    
    static func saveMainPageTFData(_ view: MainPageView, textField: UITextField) {
        let userDefaultsValue = textField.text ?? ""
        let userDefaultsKey: String
        
        switch textField {
        case view.vatAmountTF:
            userDefaultsKey = TaxKeys.vat.rawValue
        case view.feeAmountTF:
            userDefaultsKey = TaxKeys.fee.rawValue
        case view.serviceChargeAmountTF:
            userDefaultsKey = TaxKeys.serviceCharge.rawValue
        default:
            return
        }
        
        userDefaults.set(userDefaultsValue, forKey: userDefaultsKey)
    }
    
    static func saveMainPageSwitchData(_ vc: UIViewController, isOn: Bool) {
        userDefaults.set(isOn, forKey: TaxKeys.vatOnSc.rawValue)
    }
}
