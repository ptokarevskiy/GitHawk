import XCTest

final class InboxPage: Page, TabBar {
    
    private let missingNotificationsButton = Page.app.buttons[AccessibilityIds.missingNotificationsButton.rawValue].firstMatch
    private let zeroInboxContentView = Page.app.otherElements[AccessibilityIds.zeroInboxContentView.rawValue].firstMatch
    private let feedCollectionView = Page.app.collectionViews[AccessibilityIds.feedCollectionView.rawValue].firstMatch
    private let whatsNewContentView = Page.app.otherElements[AccessibilityIds.whatsNewContentView.rawValue].firstMatch
    private let closeWhatsNewButton = Page.app.collectionViews.cells.buttons[AccessibilityIds.closeWhatsNewButton.rawValue].firstMatch
    
    override func waitForPageExistance() {
        feedCollectionView.wait(.exists, withIn: 3)
    }
    
    var feedCellsCount: Int {
        return Page.app.collectionViews.cells.count
    }
    
    var lastestNotification: String {
        getFeedCell(at: 0).label
    }
    
    var isZeroInbox: Bool {
        return zeroInboxContentView.waitForExistence(timeout: 2)
    }
    
    private func getFeedCell(at index: Int) -> XCUIElement {
        return Page.app.collectionViews.cells.element(boundBy: index)
    }
    
    func hideWhatsNewPopUpIfNeeded() {
        if closeWhatsNewButton.waitForExistence(timeout: 2) {
            closeWhatsNewButton.tap()
        }
    }
}
