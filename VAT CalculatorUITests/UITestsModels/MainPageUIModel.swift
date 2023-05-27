import XCTest

struct MainPage: Page {
    let app: XCUIApplication

    private enum Identifiers {
        static let vatAmountTF = "vatAmountTF"
        static let feeAmountTF = "feeAmountTF"
        static let serviceChargeAmountTF = "serviceChargeAmountTF"
        static let vatOnScSwitch = "vatOnScSwitch"
        static let openCalculatorButton = "openCalculatorButton"
    }

    func enterVat(_ vatPercent: String) -> Self {
        let vat = app.textFields[Identifiers.vatAmountTF]
        vat.tap()
        if !vatPercent.isEmpty {
            vat.typeText(vatPercent)
        }
        return self
    }
    
    func enterFee(_ feePercent: String) -> Self {
        let fee = app.textFields[Identifiers.feeAmountTF]
        fee.tap()
        if !feePercent.isEmpty {
            fee.typeText(feePercent)
        }
        return self
    }
    
    func enterserviceCharge(_ serviceChargePercent: String) -> Self {
        let sc = app.textFields[Identifiers.serviceChargeAmountTF]
        sc.tap()
        if !serviceChargePercent.isEmpty {
            sc.typeText(serviceChargePercent)
        }
        return self
    }

    func tapSwitchVatOnSc(_ enabled: Bool) -> Self {
        let mySwitch = app.switches[Identifiers.vatOnScSwitch]
        let mySwitchState = mySwitch.value as? String
        switch mySwitchState {
        case "0":
            if enabled {
                mySwitch.tap()
            } else {
                mySwitch.tap()
                mySwitch.tap()
            }
        case "1":
            if enabled {
                mySwitch.tap()
                mySwitch.tap()
            } else {
                mySwitch.tap()
            }
        default:
            break
        }
        return self
    }

    func emptyTap() -> Self {
        app.tap()
        return self
    }
    
    func tapOpenCalculatorPageButton() -> CalculatorPage {
        let button = app.buttons[Identifiers.openCalculatorButton]
        button.tap()
        return CalculatorPage(app: app)
    }
    
    func verifyMessage(_ message: String) -> Self {
        let message = app.staticTexts[message]
        XCTAssertTrue(message.exists)
        return self
    }
}
