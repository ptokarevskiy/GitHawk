import XCTest

final class BookmarksPage: Page, TabBar {
    
    private let viewController = Page.app.collectionViews[AccessibilityIds.feedCollectionView.rawValue].firstMatch
    
    override func waitForPageExistance() {
        viewController.wait(.exists, withIn: 3)
    }
}
