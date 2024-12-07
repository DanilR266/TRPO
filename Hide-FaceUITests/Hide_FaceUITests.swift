//
//  Hide_FaceUITests.swift
//  Hide-FaceUITests
//
//  Created by Данила on 19.11.2024.
//

import XCTest
@testable import Hide_Face

final class Hide_FaceUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
        app.tabBars.buttons["Профиль"].tap()
        XCTAssertFalse(app.buttons["buttonRegistration"].isEnabled)
        let passwordField = app.textFields["passwordField"]
        let emailField = app.textFields["emailField"]
        passwordField.tap()
        passwordField.typeText("Password")
        emailField.tap()
        emailField.typeText("email@email.com")
        XCTAssertTrue(app.buttons["buttonRegistration"].isEnabled)
    }
    
    @MainActor
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
