//
//  UIConstants.swift
//  VAT Calculator
//
//  Created by Lap on 14.03.2023.
//

import UIKit

// MARK: - Private constants
enum UIConstants {
    static let netName = "Net sales, %"
    static let netAmount = "100"
    static let vatName = "VAT, %"
    static let feeName = "Municipality Fee, %"
    static let serviceChargeName = "Service Charge, %"
    static let vatOnScName = "VAT on Service charge"
    static let grossName = "Gross sales, %"
    static let placeholder = "0"
    static let totalVatName = "Total VAT"
    
    static let fontSizeHeader: CGFloat = 20
    static let fontSizeMain: CGFloat = 20
    static let fontSizeButton: CGFloat = 20
    static let fontSemibold = UIFont.systemFont(ofSize: UIConstants.fontSizeMain, weight: .semibold)
    static let fontRegular = UIFont.systemFont(ofSize: UIConstants.fontSizeMain, weight: .regular)
    static let fontBold = UIFont.systemFont(ofSize: UIConstants.fontSizeHeader, weight: .bold)
    
    static let navigationTitleAttributes = [NSAttributedString.Key.font: UIConstants.fontBold]
    static let mainPageNavigationTitle = "Main menu"
    static let calculatorPageNavigationTitle = "VAT Calculator"
    
    static let buttonTitle = "Open calculator"
    static let buttonCornerRadius: CGFloat = 10
    static let buttonFont = UIFont.systemFont(ofSize: UIConstants.fontSizeButton, weight: .bold)
    //button.backgroundColor = UIColor(hue: 159/359, saturation: 0.88, brightness: 0.47, alpha: 1)
    //button.backgroundColor = UIColor(red: 153/255, green: 204/255, blue: 255/255, alpha: 1)
    static let buttonTitleColor = UIColor.white
    
    static let accentColor = UIColor(named: "AccentColor")
    static let backgroundColor = UIColor(named: "BackgroundColor")
    
    static let menuItemsOffset: CGFloat = 16
    static let contentInset: CGFloat = 16
    static let afterGrossCustomSpacing: CGFloat = 50
}
