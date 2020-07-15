import XCTest

protocol TabBar {
    
    func goToInbox() -> InboxPage
    func gotoSearchPage() -> SearchPage
    func gotoBookmarksPage() -> BookmarksPage
    func gotoSettingsPage() -> SettingsPage
}

extension TabBar {
    
    private var inboxButton: XCUIElement {
        return Page.app.buttons[AccessibilityIds.inboxTabBarItem.rawValue].firstMatch
    }
    
    private var searchButton: XCUIElement {
        return Page.app.buttons[AccessibilityIds.searchTabBarItem.rawValue].firstMatch
    }
    
    private var bookmarksButton: XCUIElement {
        return Page.app.buttons[AccessibilityIds.bookmarksTabBarItem.rawValue].firstMatch
    }
    
    private var settingsButton: XCUIElement {
        return Page.app.buttons[AccessibilityIds.settingsTabBarItem.rawValue].firstMatch
    }
    
    @discardableResult
    func goToInbox() -> InboxPage {
        inboxButton.tap()
        return InboxPage()
    }
    
    @discardableResult
    func gotoSearchPage() -> SearchPage {
        searchButton.tap()
        return SearchPage()
    }
    
    @discardableResult
    func gotoBookmarksPage() -> BookmarksPage {
        bookmarksButton.tap()
        return BookmarksPage()
    }
    
    @discardableResult
    func gotoSettingsPage() -> SettingsPage {
        settingsButton.tap()
        return SettingsPage()
    }
}
