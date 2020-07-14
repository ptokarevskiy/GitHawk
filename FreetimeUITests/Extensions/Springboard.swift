import XCTest

class Springboard {
    
    static let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")
    
    /**
     Terminate and delete the app via springboard
     */
    class func deleteApp() {
        XCUIApplication().terminate()
        
        let icon = springboard.icons["GitHawk"]
        if icon.exists {
            let iconFrame = icon.frame
            let springboardFrame = springboard.frame
            icon.press(forDuration: 1.3)
            
            if #available(iOS 13, *) {
                let deleteAction = springboard.buttons["Delete App"]
                if deleteAction.waitForExistence(timeout: 2) {
                    deleteAction.tap()
                }
            } else {
                springboard.coordinate(withNormalizedOffset: CGVector(dx: (iconFrame.minX + 3) / springboardFrame.maxX, dy: (iconFrame.minY + 3) / springboardFrame.maxY)).tap()
            }
            
            let deleteButton = springboard.alerts.buttons["Delete"].firstMatch
            if deleteButton.waitForExistence(timeout: 5) {
                deleteButton.tap()
            }
        }
    }
}
