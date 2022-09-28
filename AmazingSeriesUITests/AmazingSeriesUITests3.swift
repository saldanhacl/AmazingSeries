//
//  AmazingSeriesUITests.swift
//  AmazingSeriesUITests
//
//  Created by Lucas Saldanha (Personal) on 27/09/22.
//

import XCTest

class AmazingSeriesUITests3: XCTestCase {

    func testTapText() throws {
        let app = XCUIApplication()
        app.launch()
        
        let text = app.staticTexts["Under the Dome (2013)"]
        text.tap()
        
        sleep(30)
        let showTitle = app.staticTexts["Under the Dome"]
        XCTAssertNotNil(showTitle)
    }
}
