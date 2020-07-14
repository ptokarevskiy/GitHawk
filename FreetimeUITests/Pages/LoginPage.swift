import XCTest

final class LoginPage: Page {
    private let signInButton = Page.app.buttons[AccessibilityIds.gitHubSignInButton.rawValue].firstMatch
    private let personalTokenButton = Page.app.buttons[AccessibilityIds.personalTokenLoginButton.rawValue].firstMatch
    private let personalTokenTextField = Page.app.textFields[AccessibilityIds.personalTokenTextField.rawValue].firstMatch
    private let cancelAlertButton = Page.app.alerts.buttons[Constants.Strings.cancel].firstMatch
    private let continueAlertButton = Page.app.alerts.buttons["Continue"].firstMatch
    private let signInAlertButton = Page.app.alerts.buttons[Constants.Strings.signin].firstMatch
    private let okAlertButton = Page.app.alerts.buttons[Constants.Strings.ok].firstMatch
    private let errorAlert = Page.app.alerts[AccessibilityIds.errorAlertView.rawValue].firstMatch
    
    private func enterPesonalAccessToken(_ token: String) {
        let textField = personalTokenTextField
        textField.typeText(token)
    }
    
    @discardableResult
    func loginWithToken(_ token: String) -> InboxPage {
        personalTokenButton.tap()
        enterPesonalAccessToken(token)
        signInAlertButton.tap()
        return InboxPage()
    }
    
    func loginWithGitHub() -> WebViewLoginPage {
        return WebViewLoginPage()
    }
}
