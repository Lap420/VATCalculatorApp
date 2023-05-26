import XCTest

struct CalculatorPage: Page {
    let app: XCUIApplication

    enum Identifiers {
        static let netTF = "netTF"
        static let grossTF = "grossTF"
        static let openSettingsButton = "openSettingsButton"
    }
    
    func enterNet(_ netAmount: String) -> Self {
        let net = app.textFields[Identifiers.netTF]
        net.tap()
        if !netAmount.isEmpty {
            net.typeText(netAmount)
        }
        return self
    }
    
    func enterGross(_ grossAmount: String) -> Self {
        let gross = app.textFields[Identifiers.grossTF]
        gross.tap()
        if !grossAmount.isEmpty {
            gross.typeText(grossAmount)
        }
        return self
    }
    
    func emptyTap() -> Self {
        app.tap()
        return self
    }
    
    func tapBackButton() -> MainPage {
        let button = app.navigationBars.buttons.element(boundBy: 0)
        button.tap()
        return MainPage(app: app)
    }
    
    func tapSettingsButton() -> SettingsPage {
        let button = app.buttons[Identifiers.openSettingsButton]
        button.tap()
        return SettingsPage(app: app)
    }
    
    func verifyMessage(_ message: String) -> Self {
        let message = app.staticTexts[message]
        XCTAssertTrue(message.exists)
        return self
    }
    
    func verifyMessageIsMissing(_ message: String) -> Self {
        let message = app.staticTexts[message]
        XCTAssertFalse(message.exists)
        return self
    }
    
    func verifyTextFieldMessage(_ message: String, textFieldIdentifier: String) -> Self {
        let textField = app.textFields[textFieldIdentifier]
        let textFieldMessage = textField.value as? String ?? ""
        XCTAssertTrue(textFieldMessage.contains(message))
        return self
    }
}
