//
//  MyCryptoAppUITests.swift
//  MyCryptoAppUITests
//
//  Created by Swapnil Katwe on 19/04/24.
//

import XCTest
@testable import MyCryptoApp
final class MyCryptoAppUITests: XCTestCase {
    private var app: XCUIApplication!

    @MainActor override func setUpWithError() throws {

        continueAfterFailure = false
        app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    @MainActor func testTakeScreenShots() {
        sleep(5)
        XCUIDevice.shared.orientation = .portrait
        snapshot("Home View") // Takes screenshot of Home page
    }

    /*
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    */
}
