//
//  CarbonCertsUITests.swift
//  CarbonCertsUITests
//
//  Created by Naomi on 06/06/2024.
//

import XCTest

final class CarbonCertsUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments =  ["enable-testing"]
        app.launch()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testAppStartsEmpty() {
        XCTAssertEqual(app.cells.count, 0, "There should be 0 certificates when the app is first launched.")
    }
    
    func testBookmarkButtonTaps() {
        let homeButton = app.buttons["Home"]
              XCTAssertTrue(homeButton.exists, "The Home tab bar button should exist")
              homeButton.tap()
        
        let addSamplesButton = app.buttons[Constants.AccessibilityIdentifiers.AddSamplesButton]
        XCTAssertTrue(addSamplesButton.exists, "The add samples button should exist")
        
        addSamplesButton.tap()
        
        let cell = app.cells.element(boundBy: 0)
        XCTAssertTrue(cell.exists, "The first certificate cell should exist after adding samples")
        
        let bookmarkButton = app.cells.buttons["\(Constants.AccessibilityIdentifiers.BookmarkButton)_555wnfndjjf"]
        XCTAssertTrue(bookmarkButton.exists, "The bookmark button should exist")
        
        bookmarkButton.tap()

        XCTAssertTrue(bookmarkButton.exists, "Bookmark image taps and changes to fill")

    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
