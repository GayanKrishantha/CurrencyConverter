// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum L10n {

  public enum Label {
    /// Amount
    public static let amount = L10n.tr("Localizable", "label.amount")
    /// Convert
    public static let convert = L10n.tr("Localizable", "label.convert")
    /// Date:
    public static let date = L10n.tr("Localizable", "label.date")
    /// Enter here
    public static let enterHere = L10n.tr("Localizable", "label.enter_here")
    /// Fetching...
    public static let fetching = L10n.tr("Localizable", "label.fetching")
    /// From
    public static let from = L10n.tr("Localizable", "label.from")
    /// Loading...
    public static let loading = L10n.tr("Localizable", "label.loading")
    /// No data available
    public static let noDataAvailable = L10n.tr("Localizable", "label.no_data_available")
    /// NA
    public static let notAvailable = L10n.tr("Localizable", "label.not_available")
    /// Quote:
    public static let quote = L10n.tr("Localizable", "label.quote")
    /// Required...
    public static let `required` = L10n.tr("Localizable", "label.required")
    /// Results:
    public static let results = L10n.tr("Localizable", "label.results")
    /// Search currencies...
    public static let searchCurrencies = L10n.tr("Localizable", "label.search_currencies")
    /// To
    public static let to = L10n.tr("Localizable", "label.to")
  }

  public enum Navigation {
    public enum Title {
      /// Currency Converter
      public static let main = L10n.tr("Localizable", "navigation.title.main")
      /// Search
      public static let search = L10n.tr("Localizable", "navigation.title.search")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
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
