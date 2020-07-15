import XCTest

final class SettingsPage: Page, TabBar {
    
    fileprivate let viewController = Page.app.tables[AccessibilityIds.settingsViewController.rawValue].firstMatch
    fileprivate let logoutCell = Page.app.cells[AccessibilityIds.signOutCell.rawValue].firstMatch
    fileprivate let signOutActionButton = Page.app.buttons[Constants.Strings.signout].firstMatch
    
    override func waitForPageExistance() {
        viewController.wait(.exists, withIn: 3)
    }
    
    
    func logOut() {
        Page.app.scrollDownToElement(element: logoutCell)
        logoutCell.tap()
        signOutActionButton.tap()
    }
}
