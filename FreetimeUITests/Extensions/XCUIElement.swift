import Foundation
import XCTest

public extension XCUIElement {
    
    var isVisible: Bool {
        return exists && isHittable && !frame.isEmpty
    }
    
    func scrollUpToElement(element: XCUIElement) {
        while !isVisible {
            swipeUp()
        }
    }
    
    func scrollDownToElement(element: XCUIElement) {
        while !isVisible {
            swipeDown()
        }
    }
    
    var text: String {
        guard let text = value as? String else {
            preconditionFailure("Value: \(String(describing: value)) is not a String")
        }
        return text
    }
    
    private func clearTextField() {
        let app = XCUIApplication()
        let deleteButton = app.keys[XCUIKeyboardKey.delete.rawValue]
        var previousValueLength = 0
        while self.text.count != previousValueLength {
            previousValueLength = self.text.count
            deleteButton.tap()
        }
    }
    
    func clear(andType text: String) {
        tap()
        clearTextField()
        typeText(text)
    }
}
