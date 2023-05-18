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
    static let roundingName = "Rounding"
    static let hideZeroLinesName = "Hide zero lines"
    
    // Calculator page
    static let vatAmountName = "VAT"
    static let feeAmountName = "Municipality Fee"
    
    static let fontSizeHeader: CGFloat = 20
    static let fontSizeMain: CGFloat = 20
    static let fontSizeButton: CGFloat = 20
    static let fontSemibold = UIFont.systemFont(ofSize: UIConstants.fontSizeMain, weight: .semibold)
    static let fontRegular = UIFont.systemFont(ofSize: UIConstants.fontSizeMain, weight: .regular)
    static let fontBold = UIFont.systemFont(ofSize: UIConstants.fontSizeHeader, weight: .bold)
    
    static let navigationTitleAttributes = [NSAttributedString.Key.font: UIConstants.fontBold]
    static let mainPageNavigationTitle = "Main menu"
    static let calculatorPageNavigationTitle = "VAT Calculator"
    static let settingsPageNavigationTitle = "Settings"
    static let settingsIconName = "gearshape"
    
    static let buttonTitle = "Open calculator"
    static let buttonCornerRadius: CGFloat = 10
    static let buttonFont = UIFont.systemFont(ofSize: UIConstants.fontSizeButton, weight: .bold)
    static let buttonTitleColor = UIColor.white
    static let buttonWidth: CGFloat = UIScreen.main.bounds.width * 0.69
    static let buttonAnimationDuration: TimeInterval = 0.1
    static let buttonAnimationScale: CGFloat = 0.95
    
    static let stepperMaximumValue: Double = 9
    
    static let accentColor = UIColor(named: "AccentColor")
    static let backgroundColor = UIColor(named: "BackgroundColor")
    static let backgroundContentColor = UIColor(named: "BackgroundContentColor")
    
    static let contentViewCornerRadius: CGFloat = 10
    
    static let menuItemsOffset: CGFloat = 12
    static let contentHorizontalInset: CGFloat = 8
    static let contentVerticalInset: CGFloat = 16
    static let afterGrossCustomSpacing: CGFloat = 50
    static let textFieldHeight: CGFloat = 40
    static let textFieldWidth: CGFloat = 100
    
    
}
