// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum Localization {

  internal enum Baloon {
    /// Maybe a drone, maybe a baloon.\nWill drop more enemies into you if not destroyed fast.
    internal static let description = Localization.tr("Strings", "Baloon.description")
    /// Drone-B-loon
    internal static let name = Localization.tr("Strings", "Baloon.name")
  }

  internal enum BaloonBomb {
    /// A small bomb.\nWill detonate on impact.
    internal static let description = Localization.tr("Strings", "BaloonBomb.description")
    /// Small Bomb #2
    internal static let name = Localization.tr("Strings", "BaloonBomb.name")
  }

  internal enum PaperPlane {
    /// Super fragile, super slow, almost harmless.\nDangerous when in large groups.
    internal static let description = Localization.tr("Strings", "PaperPlane.description")
    /// Paper plane
    internal static let name = Localization.tr("Strings", "PaperPlane.name")
  }

  internal enum Pause {
    /// Continue
    internal static let `continue` = Localization.tr("Strings", "Pause.continue")
    /// Exit
    internal static let exit = Localization.tr("Strings", "Pause.exit")
    /// Pause
    internal static let title = Localization.tr("Strings", "Pause.title")
  }

  internal enum Settings {
    /// Settings
    internal static let title = Localization.tr("Strings", "Settings.title")
    /// Enable vibrations
    internal static let vibrations = Localization.tr("Strings", "Settings.vibrations")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Localization {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
