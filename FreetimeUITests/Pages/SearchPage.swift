import XCTest

final class SearchPage: Page, TabBar {
    
    fileprivate let viewController = Page.app.otherElements[AccessibilityIds.searchViewController.rawValue].firstMatch
    fileprivate let searchBar = Page.app.searchFields.firstMatch
    
    override func waitForPageExistance() {
        viewController.wait(.exists, withIn: 3)
    }
    
    func searchRepositories(searchTerm: String) {
        searchBar.clear(andType: searchTerm)
    }
}
