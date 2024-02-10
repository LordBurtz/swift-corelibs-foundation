// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2016 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See http://swift.org/LICENSE.txt for license information
// See http://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//


@_implementationOnly import _CoreFoundation
@_exported import FoundationEssentials
@_exported import FoundationInternationalization

open class NSLocale: NSObject, NSCopying, NSSecureCoding {
    var _locale: Locale
    
    internal init(locale: Locale) {
        _locale = locale
    }
    
    open func object(forKey key: NSLocale.Key) -> Any? {
        switch key {
        case .identifier: return self.localeIdentifier
        case .languageCode: return self.languageCode
        case .countryCode: return self.countryCode
        case .scriptCode: return self.scriptCode
        case .variantCode: return self.variantCode
#if FOUNDATION_FRAMEWORK
        case .exemplarCharacterSet: return self.exemplarCharacterSet
#endif
        case .calendarIdentifier: return self.calendarIdentifier
        case .calendar: return _locale.calendar
        case .collationIdentifier: return self.collationIdentifier
        case .usesMetricSystem: return self.usesMetricSystem
        // Foundation framework only
        /*
        case .measurementSystem:
            switch locale.measurementSystem {
            case .us: return NSLocaleMeasurementSystemUS
            case .uk: return NSLocaleMeasurementSystemUK
            case .metric: return NSLocaleMeasurementSystemMetric
            default: return NSLocaleMeasurementSystemMetric
            }
        case .temperatureUnit:
            switch _locale.temperatureUnit {
            case .celsius: return NSLocaleTemperatureUnitCelsius
            case .fahrenheit: return NSLocaleTemperatureUnitFahrenheit
            default: return NSLocaleTemperatureUnitCelsius
            }
        */
        case .decimalSeparator: return self.decimalSeparator
        case .groupingSeparator: return self.groupingSeparator
        case .currencySymbol: return self.currencySymbol
        case .currencyCode: return self.currencyCode
        // Foundation framework only
        /*
        case .collatorIdentifier, .cfLocaleCollatorID: return self.collatorIdentifier
        */
        case .quotationBeginDelimiterKey: return self.quotationBeginDelimiter
        case .quotationEndDelimiterKey: return self.quotationEndDelimiter
        case .alternateQuotationBeginDelimiterKey: return self.alternateQuotationBeginDelimiter
        case .alternateQuotationEndDelimiterKey: return self.alternateQuotationEndDelimiter
        // Foundation framework only
        /*
        case .languageIdentifier: return self.languageIdentifier
        */
        default:
            return nil
        }
    }
    
    open func displayName(forKey key: Key, value: String) -> String? {
        guard let value = value as? String else {
            return nil
        }

        switch key {
        case .identifier: return self._nullableLocalizedString(forLocaleIdentifier: value)
        case .languageCode: return self.localizedString(forLanguageCode: value)
        case .countryCode: return self.localizedString(forCountryCode: value)
        case .scriptCode: return self.localizedString(forScriptCode: value)
        case .variantCode: return self.localizedString(forVariantCode: value)
#if FOUNDATION_FRAMEWORK
        case .exemplarCharacterSet: return nil
#endif
        case .calendarIdentifier, .calendar: return self.localizedString(forCalendarIdentifier: value)
        case .collationIdentifier: return self.localizedString(forCollationIdentifier: value)
        case .usesMetricSystem: return nil
        case .measurementSystem: return nil
        case .decimalSeparator: return nil
        case .groupingSeparator: return nil
        case .currencySymbol: return self.localizedString(forCurrencySymbol: value)
        case .currencyCode: return self.localizedString(forCurrencyCode: value)
        case .collatorIdentifier: return self.localizedString(forCollatorIdentifier: value)
        case .quotationBeginDelimiterKey: return nil
        case .quotationEndDelimiterKey: return nil
        case .alternateQuotationBeginDelimiterKey: return nil
        case .alternateQuotationEndDelimiterKey: return nil
        default:
            return nil
        }
    }
    
    var localeIdentifier: String {
        _locale.identifier
    }

    var languageCode: String {
        _locale.languageCode ?? ""
    }

    var languageIdentifier: String {
        let langIdentifier = _locale.language._components._identifier
        let localeWithOnlyLanguage = Locale(identifier: langIdentifier)
        return localeWithOnlyLanguage.identifier(.bcp47)
    }

    var countryCode: String? {
        _locale.region?.identifier
    }

    var regionCode: String? {
        _locale.region?.identifier
    }

    var scriptCode: String? {
        _locale.scriptCode
    }

    var variantCode: String? {
        _locale.variantCode
    }

    var calendarIdentifier: String {
        _locale.__calendarIdentifier._cfCalendarIdentifier
    }

    var collationIdentifier: String? {
        _locale.collationIdentifier
    }

    var decimalSeparator: String {
        _locale.decimalSeparator ?? ""
    }

    var groupingSeparator: String {
        _locale.groupingSeparator ?? ""
    }

    var currencySymbol: String {
        _locale.currencySymbol ?? ""
    }

    var currencyCode: String? {
        _locale.currencyCode
    }

    var collatorIdentifier: String {
        _locale.collatorIdentifier ?? ""
    }

    var quotationBeginDelimiter: String {
        _locale.quotationBeginDelimiter ?? ""
    }

    var quotationEndDelimiter: String {
        _locale.quotationEndDelimiter ?? ""
    }

    var alternateQuotationBeginDelimiter: String {
        _locale.alternateQuotationBeginDelimiter ?? ""
    }

    var alternateQuotationEndDelimiter: String {
        _locale.alternateQuotationEndDelimiter ?? ""
    }

#if FOUNDATION_FRAMEWORK
    var exemplarCharacterSet: CharacterSet {
        _locale.exemplarCharacterSet ?? CharacterSet()
    }
#endif

    var usesMetricSystem: Bool {
        _locale.usesMetricSystem
    }

    func localizedString(forLocaleIdentifier localeIdentifier: String) -> String {
        _nullableLocalizedString(forLocaleIdentifier: localeIdentifier) ?? ""
    }
    
    /// Some CFLocale APIs require the result to remain `nullable`. They can call this directly, where the `localizedString(forLocaleIdentifier:)` entry point can remain (correctly) non-nullable.
    private func _nullableLocalizedString(forLocaleIdentifier localeIdentifier: String) -> String? {
        _locale.localizedString(forIdentifier: localeIdentifier)
    }

    func localizedString(forLanguageCode languageCode: String) -> String? {
        _locale.localizedString(forLanguageCode: languageCode)
    }

    func localizedString(forCountryCode countryCode: String) -> String? {
        _locale.localizedString(forRegionCode: countryCode)
    }

    func localizedString(forScriptCode scriptCode: String) -> String? {
        _locale.localizedString(forScriptCode: scriptCode)
    }

    func localizedString(forVariantCode variantCode: String) -> String? {
        _locale.localizedString(forVariantCode: variantCode)
    }

    func localizedString(forCalendarIdentifier calendarIdentifier: String) -> String? {
        let id = Calendar._fromNSCalendarIdentifier(.init(calendarIdentifier))
        return _locale.localizedString(for: id)
    }

    func localizedString(forCollationIdentifier collationIdentifier: String) -> String? {
        _locale.localizedString(forCollationIdentifier: collationIdentifier)
    }

    func localizedString(forCurrencyCode currencyCode: String) -> String? {
        _locale.localizedString(forCurrencyCode: currencyCode)
    }

    func localizedString(forCurrencySymbol currencySymbol: String) -> String? {
        // internal access for SCL-F only
        _locale._localizedString(forCurrencySymbol: currencySymbol)
    }

    func localizedString(forCollatorIdentifier collatorIdentifier: String) -> String? {
        _locale.localizedString(forCollatorIdentifier: collatorIdentifier)
    }

    public init(localeIdentifier string: String) {
        _locale = Locale(identifier: string)
        super.init()
    }
    
    public required convenience init?(coder aDecoder: NSCoder) {
        guard aDecoder.allowsKeyedCoding else {
            preconditionFailure("Unkeyed coding is unsupported.")
        }
        guard let identifier = aDecoder.decodeObject(of: NSString.self, forKey: "NS.identifier") else {
            return nil
        }
        self.init(localeIdentifier: String._unconditionallyBridgeFromObjectiveC(identifier))
    }
        
    open override func copy() -> Any {
        return copy(with: nil)
    }
    
    open func copy(with zone: NSZone? = nil) -> Any { 
        return self 
    }
    
    override open func isEqual(_ object: Any?) -> Bool {
        guard let locale = object as? NSLocale else {
            return false
        }
        
        return locale.localeIdentifier == localeIdentifier
    }

    override open var hash: Int {
        return localeIdentifier.hash
    }

    open func encode(with aCoder: NSCoder) {
        guard aCoder.allowsKeyedCoding else {
            preconditionFailure("Unkeyed coding is unsupported.")
        }
        aCoder.encode(_locale.identifier as NSString, forKey: "NS.identifier")
    }
    
    public static var supportsSecureCoding: Bool {
        return true
    }
}

extension NSLocale {
    open class var current: Locale {
        Locale.current
    }
    
    open class var system: Locale {
        Locale(identifier: "")
    }
}

extension NSLocale {
    open class var availableLocaleIdentifiers: [String] {
        Locale.availableIdentifiers
    }
    
    open class var isoLanguageCodes: [String] {
        // Map back from the type to strings
        Locale.LanguageCode.isoLanguageCodes.map { $0.identifier }
    }
    
    open class var isoCountryCodes: [String] {
        Locale.Region.isoRegions.map { $0.identifier }
    }
    
    open class var isoCurrencyCodes: [String] {
        Locale.Currency.isoCurrencies.map { $0.identifier }
    }
    
    open class var commonISOCurrencyCodes: [String] {
        Locale.commonISOCurrencyCodes
    }
    
    open class var preferredLanguages: [String] {
        Locale.preferredLanguages
    }
    
    open class func components(fromLocaleIdentifier string: String) -> [String : String] {
        let comps = CFLocaleCreateComponentsFromLocaleIdentifier(kCFAllocatorSystemDefault, string._cfObject)
        if let result = comps as? [String: String] {
            return result
        } else {
            return [:]
        }
    }
    
    open class func localeIdentifier(fromComponents dict: [String : String]) -> String {
        Locale.identifier(fromComponents: dict)
    }
    
    open class func canonicalLocaleIdentifier(from string: String) -> String {
        Locale.canonicalLanguageIdentifier(from: string)
    }
    
    open class func canonicalLanguageIdentifier(from string: String) -> String {
        Locale.canonicalLanguageIdentifier(from: string)
    }
    
    open class func localeIdentifier(fromWindowsLocaleCode lcid: UInt32) -> String? {
        Locale.identifier(fromWindowsLocaleCode: Int(lcid))
    }
    
    open class func windowsLocaleCode(fromLocaleIdentifier localeIdentifier: String) -> UInt32 {
        if let code = Locale.windowsLocaleCode(fromIdentifier: localeIdentifier) {
            return UInt32(code)
        } else {
            return UInt32.max
        }
    }
    
    open class func characterDirection(forLanguage isoLangCode: String) -> NSLocale.LanguageDirection {
        let language = Locale.Language(components: .init(identifier: isoLangCode))
        return language.characterDirection
    }
    
    open class func lineDirection(forLanguage isoLangCode: String) -> NSLocale.LanguageDirection {
        let language = Locale.Language(components: .init(identifier: isoLangCode))
        return language.lineLayoutDirection
    }
}

extension NSLocale {

    public struct Key : RawRepresentable, Equatable, Hashable {
        public private(set) var rawValue: String
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        public static let identifier = NSLocale.Key(rawValue: "kCFLocaleIdentifierKey")
        public static let languageCode = NSLocale.Key(rawValue: "kCFLocaleLanguageCodeKey")
        public static let countryCode = NSLocale.Key(rawValue: "kCFLocaleCountryCodeKey")
        public static let scriptCode = NSLocale.Key(rawValue: "kCFLocaleScriptCodeKey")
        public static let variantCode = NSLocale.Key(rawValue: "kCFLocaleVariantCodeKey")
        public static let exemplarCharacterSet = NSLocale.Key(rawValue: "kCFLocaleExemplarCharacterSetKey")
        public static let calendar = NSLocale.Key(rawValue: "kCFLocaleCalendarKey")
        public static let collationIdentifier = NSLocale.Key(rawValue: "collation")
        public static let usesMetricSystem = NSLocale.Key(rawValue: "kCFLocaleUsesMetricSystemKey")
        public static let measurementSystem = NSLocale.Key(rawValue: "kCFLocaleMeasurementSystemKey")
        public static let decimalSeparator = NSLocale.Key(rawValue: "kCFLocaleDecimalSeparatorKey")
        public static let groupingSeparator = NSLocale.Key(rawValue: "kCFLocaleGroupingSeparatorKey")
        public static let currencySymbol = NSLocale.Key(rawValue: "kCFLocaleCurrencySymbolKey")
        public static let currencyCode = NSLocale.Key(rawValue: "currency")
        public static let collatorIdentifier = NSLocale.Key(rawValue: "kCFLocaleCollatorIdentifierKey")
        public static let quotationBeginDelimiterKey = NSLocale.Key(rawValue: "kCFLocaleQuotationBeginDelimiterKey")
        public static let quotationEndDelimiterKey = NSLocale.Key(rawValue: "kCFLocaleQuotationEndDelimiterKey")
        public static let calendarIdentifier = NSLocale.Key(rawValue: "kCFLocaleCalendarIdentifierKey")
        public static let alternateQuotationBeginDelimiterKey = NSLocale.Key(rawValue: "kCFLocaleAlternateQuotationBeginDelimiterKey")
        public static let alternateQuotationEndDelimiterKey = NSLocale.Key(rawValue: "kCFLocaleAlternateQuotationEndDelimiterKey")
    }
    
    public typealias LanguageDirection = Locale.LanguageDirection
}


#if !os(WASI)
extension NSLocale {
    public static let currentLocaleDidChangeNotification = NSNotification.Name(rawValue: "kCFLocaleCurrentLocaleDidChangeNotification")
}
#endif

extension NSLocale : _SwiftBridgeable {
    typealias SwiftType = Locale
    internal var _swiftObject: Locale {
        return self._locale
    }
}

extension NSLocale : _StructTypeBridgeable {
    public typealias _StructType = Locale
    
    public func _bridgeToSwift() -> Locale {
        return Locale._unconditionallyBridgeFromObjectiveC(self)
    }
}

// MARK: - CF Conversions

extension Locale {
    internal var _cfObject: CFLocale {
        CFLocaleCreate(nil, identifier._cfObject)
    }
}

extension NSLocale {
    internal var _cfObject: CFLocale {
        CFLocaleCreate(nil, _locale.identifier._cfObject)
    }
}

extension CFLocale {
    internal var _swiftObject: Locale {
        Locale(identifier: CFLocaleGetIdentifier(self)._swiftObject)
    }
    
    internal var _nsObject: NSLocale {
        NSLocale(locale: _swiftObject)
    }
}
