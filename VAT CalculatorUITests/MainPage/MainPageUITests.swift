import XCTest
@testable import VAT_Calculator

class MainPageUITests: XCTestCase {
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
    
    func testFillAllTaxesFlow() {
        let _ = MainPage(app: app)
            .enterVat("5")
            .enterFee("7")
            .enterserviceCharge("10")
            .tapSwitchVatOnSc(true)
            .verifyMessage("122.5")
    }
    
    func testFillDefaultUAETaxesFlow() {
        let _ = MainPage(app: app)
            .enterVat("5")
            .enterFee("")
            .enterserviceCharge("")
            .verifyMessage("105")
    }
    
    func testGoToCalculatorPage() {
        let _ = MainPage(app: app)
            .tapOpenCalculatorPageButton()
            .verifyMessage("VAT Calculator")
    }
}
