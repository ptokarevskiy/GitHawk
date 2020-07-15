import XCTest

class SmokeTests: XCTestCase {
    
    override func setUp() {
        Page.app.launchArguments.append("--uitests")
        Page.app.launch()
        continueAfterFailure = false
        super.setUp()
    }
    
    override func tearDown() {
        Page.app.terminate()
        super.tearDown()
    }
    
    func testZeroInboxFeed() {
        let loginPage = LoginPage()
        let inboxPage = loginPage.loginWithToken(PersonalToken.validZeroInbox.rawValue)
        inboxPage.hideWhatsNewPopUpIfNeeded()
        XCTAssertEqual(inboxPage.feedCellsCount, 1)
        XCTAssertTrue(inboxPage.isZeroInbox)
    }
    
    func testTabsNavigation() {
        let loginPage = LoginPage()
        let inboxPage = loginPage.loginWithToken(PersonalToken.validZeroInbox.rawValue)
        inboxPage.hideWhatsNewPopUpIfNeeded()
        inboxPage.gotoSearchPage().gotoBookmarksPage().gotoSettingsPage()
    }
    
    func testSearchResults() {
        let loginPage = LoginPage()
        let inboxPage = loginPage.loginWithToken(PersonalToken.validZeroInbox.rawValue)
        inboxPage.hideWhatsNewPopUpIfNeeded()
        let searchPage  = inboxPage.gotoSearchPage()
        searchPage.searchRepositories(searchTerm: "GitHawk")
        XCTAssertTrue(SearchPage.app.collectionViews.cells.element(withLabelContaining: "GitHawkApp/GitHawk").firstMatch.waitForExistence(timeout: 10))
    }
    
    func testLogOut() {
        let loginPage = LoginPage()
        let inboxPage = loginPage.loginWithToken(PersonalToken.validZeroInbox.rawValue)
        inboxPage.hideWhatsNewPopUpIfNeeded()
        let settingsPage  = inboxPage.gotoSettingsPage()
        settingsPage.logOut()
    }
}


extension SmokeTests {
    
    fileprivate enum PersonalToken: String {
        case validZeroInbox = "f5a2f3b839260d52053e7f99230def2f113db739"
        case invalid = "12345"
        case withoutRightScope = "d774314b085e5f8cc4bc217ab275c5a044398679"
    }
}
