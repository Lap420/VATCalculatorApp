import XCTest

class SettingsPageUITests: XCTestCase {
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

    func testRounding() {
        let _ = MainPage(app: app)
            .enterVat("5")
            .enterFee("")
            .enterserviceCharge("")
            .tapOpenCalculatorPageButton()
            .enterNet("111.11")
            .tapOpenSettingsPageButton()
            .makeRoundingEqualTo(4)
            .makeRoundingEqualTo(2)
            .emptyTapToGoBack()
            .verifyMessage("5.56")
    }
    
    func testHidingZeroLines() {
        let _ = MainPage(app: app)
            .enterVat("5")
            .enterFee("")
            .enterserviceCharge("")
            .tapOpenCalculatorPageButton()
            .enterNet("100")
            .tapOpenSettingsPageButton()
            .tapSwitchHideZeroLines(true)
            .emptyTapToGoBack()
            .verifyMessageIsMissing("0.00")
    }
}
