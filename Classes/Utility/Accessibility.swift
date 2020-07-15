//
//  Accessibility.swift
//  Freetime
//
//  Created by Bas Thomas Broek on 22/11/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

private protocol ContentViewContaining {
    var contentView: UIView { get }
}

extension UICollectionViewCell: ContentViewContaining {}
extension UITableViewCell: ContentViewContaining {}

enum AccessibilityHelper {

    static func generatedLabel(forCell cell: UICollectionViewCell) -> String {
        return generatedLabel(forContentViewContainer: cell)
    }

    static func generatedLabel(forCell cell: UITableViewCell) -> String {
        return generatedLabel(forContentViewContainer: cell)
    }
}

private extension AccessibilityHelper {
    static func generatedLabel(forContentViewContainer cell: ContentViewContaining) -> String {
        let labels = cell.contentView.subviews.compactMap { $0.accessibilityLabel }
        if labels.count == 1, let label = labels.first {
            return label
        } else {
            return labels.reduce("") { "\($0).\n\($1)" }
        }
    }
}

// MARK: Reduce motion

var trueUnlessReduceMotionEnabled: Bool {
    return !UIAccessibility.isReduceMotionEnabled
}

enum AccessibilityIds: String {
    case gitHubSignInButton = "GitHub SignIn"
    case personalTokenLoginButton = "Login with PAT"
    case loginViewController = "Login ViewController"
    case searchViewController = "Search ViewController"
    case searchBar = "Search Bar"
    case settingsViewController = "Settings ViewController"
    case signOutCell = "SignOut Cell"
    case personalTokenTextField = "Token TextField"
    case errorAlertView = "Error Alert"
    case whatsNewContentView = "Whats New View"
    case closeWhatsNewButton = "Close Whats New Button"
    case zeroInboxContentView = "Zero Inbox ContentView"
    case missingNotificationsButton = "Missing Notifications Button"
    case settingsTabBarItem = "Settings TabBar Button"
    case bookmarksTabBarItem = "Bookmarks TabBar Button"
    case searchTabBarItem = "Search TabBar Button"
    case inboxTabBarItem = "Inbox TabBar Button"
    case feedCollectionView = "Feed CollectionView"
}
