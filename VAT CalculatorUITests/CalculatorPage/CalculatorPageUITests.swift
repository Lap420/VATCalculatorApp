import XCTest

class CalculatorPageUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        let screenshot = XCUIScreen.main.screenshot()
        let attachment = XCTAttachment(screenshot: screenshot)
        attachment.lifetime = .deleteOnSuccess
        add(attachment)
        app.terminate()
    }

    func testTaxesCalculationBasedOnNetAmount() {
        let _ = MainPage(app: app)
            .enterVat("5")
            .enterFee("7")
            .enterserviceCharge("10")
            .emptyTap()
            .tapSwitchVatOnSc(true)
            .tapOpenCalculatorButton()
            .enterNet("228")
            .emptyTap()
            .verifyMessage("11.40")
            .verifyMessage("15.96")
            .verifyMessage("22.80")
            .verifyMessage("1.14")
            .verifyMessage("12.54")
            .verifyTextFieldMessage("279.30", textFieldIdentifier: CalculatorPage.Identifiers.grossTF)
    }
    
    func testTaxesCalculationBasedOnGrossAmount() {
        let _ = MainPage(app: app)
            .enterVat("5")
            .enterFee("7")
            .enterserviceCharge("10")
            .emptyTap()
            .tapSwitchVatOnSc(true)
            .tapOpenCalculatorButton()
            .enterGross("228")
            .emptyTap()
            .verifyMessage("10.24")
            .verifyMessage("0.93")
            .verifyMessage("18.61")
            .verifyMessage("13.03")
            .verifyMessage("9.31")
            .verifyTextFieldMessage("186.12", textFieldIdentifier: CalculatorPage.Identifiers.netTF)
    }
    
    func testGrossAmountSavingAfterReopeningPage() {
        let _ = MainPage(app: app)
            .enterVat("5")
            .enterFee("")
            .enterserviceCharge("")
            .emptyTap()
            .tapSwitchVatOnSc(false)
            .tapOpenCalculatorButton()
            .enterGross("100")
            .emptyTap()
            .tapBackButton()
            .tapOpenCalculatorButton()
            .enterNet("100")
            .emptyTap()
            .tapBackButton()
            .tapOpenCalculatorButton()
            .verifyTextFieldMessage("105", textFieldIdentifier: CalculatorPage.Identifiers.grossTF)
    }
    
    func testGoToSettingsPage() {
        let _ = MainPage(app: app)
            .tapOpenCalculatorButton()
            .tapSettingsButton()
            .verifyMessage("Rounding")
    }
}
