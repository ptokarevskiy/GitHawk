import XCTest

protocol NavigationBar {
    func backTo<T: Page>(_ type: T.Type) -> T
}

extension NavigationBar {
    private var backButton: XCUIElement {
        return Page.app.navigationBars.element(boundBy: 0)
    }
    
    func backTo<T: Page>(_ type: T.Type) -> T {
        backButton.tap()
        return type.init()
    }
}
