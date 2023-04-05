// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable all

internal enum L10n {

  internal enum Authorization {
    /// Enter
    internal static let authorization = L10n.tr("Localizable", "Authorization.authorization")
    /// Authorization
    internal static let title = L10n.tr("Localizable", "Authorization.title")
  }

  internal enum TodoList {
    /// All
    internal static let allSection = L10n.tr("Localizable", "TodoList.allSection")
    /// Completed
    internal static let completedSection = L10n.tr("Localizable", "TodoList.completedSection")
    /// Deadline:
    internal static let deadline = L10n.tr("Localizable", "TodoList.deadline")
    /// TodoList
    internal static let title = L10n.tr("Localizable", "TodoList.title")
    /// Uncompleted
    internal static let uncompletedSection = L10n.tr("Localizable", "TodoList.uncompletedSection")
  }
}

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
// swiftlint:enable all