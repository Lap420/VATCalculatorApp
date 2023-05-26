import XCTest

struct SettingsPage: Page {
    let app: XCUIApplication

    private enum Identifiers {
        static let hideZeroLines = "hideZeroLines"
        static let roundingAmount = "roundingAmount"
        static let roundingStepper = "roundingStepper"
    }
    
    func makeRoundingEqualTo(_ requestedRounding: Int) -> Self {
        let stepper = XCUIApplication().steppers[Identifiers.roundingStepper]
        let label = XCUIApplication().staticTexts[Identifiers.roundingAmount]
        var rounding = Int(label.label) ?? 228
        XCTAssertNotEqual(rounding, 228)
        while rounding != requestedRounding {
            if rounding > requestedRounding {
                stepper.buttons["Decrement"].tap()
            } else {
                stepper.buttons["Increment"].tap()
            }
            rounding = Int(label.label) ?? 228
            XCTAssertNotEqual(rounding, 228)
        }
        return self
    }
    
    func tapSwitchHideZeroLines(_ enabled: Bool) -> Self {
        let mySwitch = app.switches[Identifiers.hideZeroLines]
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
    
    func emptyTapToGoBack() -> CalculatorPage {
        let coordinate = XCUIApplication().windows.firstMatch.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.2))
        coordinate.tap()
        return CalculatorPage(app: app)
    }
    
    func verifyMessage(_ message: String) -> Self {
        let message = app.staticTexts[message]
        XCTAssertTrue(message.waitForExistence(timeout: 1))
        return self
    }
}
