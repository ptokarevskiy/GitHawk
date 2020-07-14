//
//  FreetimeUITests.swift
//  FreetimeUITests
//
//  Created by Pavel Tokarevskiy on 11.07.2020.
//  Copyright © 2020 Ryan Nystrom. All rights reserved.
//

import XCTest

class SmokeTests: XCTestCase {

    override func setUp() {
        XCUIApplication().launch()
        continueAfterFailure = false
        super.setUp()
    }

    override func tearDown() {
        Springboard.deleteApp()
        super.tearDown()
    }
    


    func testExample() {
        let loginPage = LoginPage()
        let inboxPage = loginPage.loginWithToken(PersonalToken.valid.rawValue)
        inboxPage.hideWhatsNewPopUpIfNeeded()
        XCTAssertEqual(inboxPage.feedCellsCount, 1)
        XCTAssertTrue(inboxPage.isZeroInbox)
    }
}
