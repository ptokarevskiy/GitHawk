import Foundation
import XCTest

public enum StringComparisonOperator: RawRepresentable {
    
    case equals
    case beginsWith
    case contains
    case endsWith
    case like
    case matches
    case other(comparisonOperator: String)


    public var rawValue: String {
        switch self {
        case .equals: return "=="
        case .beginsWith: return "BEGINSWITH"
        case .contains: return "CONTAINS"
        case .endsWith: return "ENDSWITH"
        case .like: return "LIKE"
        case .matches: return "MATCHES"
        case .other(let comparisonOperator): return comparisonOperator
        }
    }

   
    public init(rawValue: String) {
        switch rawValue {
        case "==": self = .equals
        case "BEGINSWITH": self = .beginsWith
        case "CONTAINS": self = .contains
        case "ENDSWITH": self = .endsWith
        case "LIKE": self = .like
        case "MATCHES": self = .matches
        default: self = .other(comparisonOperator: rawValue)
        }
    }
}

public extension XCUIElementQuery {
    
    class func predicate(withIdentifier identifier: String, labels: [String], labelComparisonOperator: StringComparisonOperator = .equals) -> NSPredicate {
          let identifierPredicate = NSPredicate(format: "identifier == %@", identifier)
          let labelsPredicates = labels.map { NSPredicate(format: "label \(labelComparisonOperator.rawValue) %@", $0) }
          let labelPredicate = NSCompoundPredicate(orPredicateWithSubpredicates: labelsPredicates)
          return NSCompoundPredicate(andPredicateWithSubpredicates: [identifierPredicate, labelPredicate])
      }

    func element(withLabelMatching text: String, comparisonOperator: StringComparisonOperator = .equals) -> XCUIElement {
        return element(matching: NSPredicate(format: "label \(comparisonOperator.rawValue) %@", text))
    }

    func elements(withLabelsMatching texts: [String], comparisonOperator: StringComparisonOperator = .equals) -> [XCUIElement] {
        return texts
            .compactMap({ element(withLabelMatching: $0, comparisonOperator: comparisonOperator) })
            .filter { $0.exists }
    }

    func element(withIdentifier identifier: String, label: String, labelComparisonOperator: StringComparisonOperator = .equals) -> XCUIElement {
        let predicate = NSPredicate(format: "identifier == %@ AND label \(labelComparisonOperator.rawValue) %@", identifier, label)
        return element(matching: predicate)
    }

    func element(withIdentifier identifier: String, labels: [String], labelComparisonOperator: StringComparisonOperator = .equals) -> XCUIElement {
        let predicate = type(of: self).predicate(withIdentifier: identifier, labels: labels, labelComparisonOperator: labelComparisonOperator)
        return element(matching: predicate)
    }

    func element(containingLabels dictionary: [String: String], labelsComparisonOperator comparisonOperator: StringComparisonOperator = .equals) -> XCUIElement {
        let predicateString = "identifier == %@ AND label \(comparisonOperator.rawValue) %@"
        var query = self
        for (identifier, label) in dictionary {
            let predicate = NSPredicate(format: predicateString, argumentArray: [identifier, label])
            query = query.containing(predicate)
        }

        return query.element
    }

    func element(containingLabels dictionary: [String: [String]], labelsComparisonOperator comparisonOperator: StringComparisonOperator = .equals) -> XCUIElement {
        var query = self
        for (identifier, labels) in dictionary {
            let predicate = type(of: self).predicate(withIdentifier: identifier, labels: labels, labelComparisonOperator: comparisonOperator)
            query = query.containing(predicate)
        }

        return query.element
    }
}

public extension XCUIElementQuery {
    
    func element(withLabelPrefixed text: String) -> XCUIElement {
        return element(withLabelMatching: text, comparisonOperator: .beginsWith)
    }

    func element(withLabelContaining text: String) -> XCUIElement {
        return element(withLabelMatching: text, comparisonOperator: .contains)
    }

    func elements(withLabelsContaining texts: [String]) -> [XCUIElement] {
        return elements(withLabelsMatching: texts, comparisonOperator: .contains)
    }

    func elements(withLabelsLike texts: [String]) -> [XCUIElement] {
        return elements(withLabelsMatching: texts, comparisonOperator: .like)
    }
}
