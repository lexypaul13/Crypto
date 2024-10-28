//
//  LocalizableString.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import SwiftUI

class LocalizableString: ObservableObject {
    private let value: String.LocalizationValue
    private let comment: StaticString?
    
    convenience init() {
        self.init("", comment: nil)
    }
    
    init(_ key: String.LocalizationValue, comment: StaticString? = nil) {
        self.value = key
        self.comment = comment
    }
    
    var text: String {
        let lang = (LocalStorage.shared.selectedLanguage ?? systemLanguage) ?? "en"
        return  String(localized: value, bundle: Bundle.localeBundle(lang), comment: comment)
    }
    
    private var systemLanguage: String? {
        if let prefix = Locale.preferredLanguages.first?.prefix(2) {
            return String(prefix)
        }
        
        return nil
    }
}

extension LocalizableString {
    var tabHome: String                         { LocalizableString("home").text }
    var tabWallet: String                       { LocalizableString("wallet").text }
    var tabMarket: String                       { LocalizableString("market").text }
    var tabSetting: String                      { LocalizableString("setting").text }
    var availableBalance: String                { LocalizableString("Available Balance").text }
    var coinList: String                        { LocalizableString("Coin Lists").text }
    var trendingCoins: String                   { LocalizableString("Trending Coins").text }
    var dashboard: String                       { LocalizableString("Dashboard").text }
    var viewAll: String                         { LocalizableString("View all").text }
    var coins: String                           { LocalizableString("Coins").text }
    var send: String                            { LocalizableString("Send").text }
    var receive: String                         { LocalizableString("Receive").text }
    var swap: String                            {  LocalizableString("Swap").text }
    var totalMarketCap: String                  { LocalizableString("Total Market Cap").text }
    var wathcList: String                       { LocalizableString("WatchList").text }
    var all: String                             { LocalizableString("All").text }
    var marketCap: String                       { LocalizableString("Market Cap").text }
    var price: String                           { LocalizableString("Price").text }
    var change24Hour: String                    { LocalizableString("24Hr Change").text }
    var market: String                          { LocalizableString("Market").text }
    var myWallets: String                       { LocalizableString("My Wallets").text }
    var myContacts: String                      { LocalizableString("My Contacts").text }
    var others: String                          { LocalizableString("Others").text }
    var historySetting: String                  { LocalizableString("History").text }
    var scanQRCodeSetting: String               { LocalizableString("Scan Qr Code").text }
    var notificationSetting: String             { LocalizableString("Notification").text }
    var securitySetting: String                 { LocalizableString("Security").text }
    var appearanceSetting: String               { LocalizableString("Appearance").text }
    var languageSetting: String                 { LocalizableString("Language").text }
    var logout: String                          { LocalizableString("Logout").text }
    var settings: String                        { LocalizableString("Settings").text }
    var copied: String                          { LocalizableString("Copied").text }
    var cancel: String                          { LocalizableString("Cancel").text }
    var copyToClipboard: String                 { LocalizableString("Copy to Clipboard").text }
    var openInBrowser: String                   { LocalizableString("Open in Browser").text }
    var transactionHistory: String              { LocalizableString("Transaction History").text }
    var chooseToken: String                     { LocalizableString("Choose Token").text }
    var recipientAddress: String                { LocalizableString("Recipient Address").text }
    var amount: String                          { LocalizableString("Amount").text }
    var saveRecipient: String                   { LocalizableString("Save recipient").text }
    var recipientName: String                   { LocalizableString("Recipient Name").text }
    var contacts: String                        { LocalizableString("Contacts").text }
    var system: String                          { LocalizableString("System").text }
    var announcements: String                   { LocalizableString("Announcements").text }
    var campaigns: String                       { LocalizableString("Campaigns").text }
    var notifications: String                   { LocalizableString("Notifications").text }
    var enterNewPassword: String                { LocalizableString("Enter a new password").text }
    var reenterNewPassword: String              { LocalizableString("Please re-entry your passcode").text }
    var setPasscode: String                     { LocalizableString("Set Passcode").text }
    var qrCameraInstruction: String             { LocalizableString("Point your camerathe QR Code").text }
    var enableCameraInstruction: String         { LocalizableString("Please enable access to camera before scanning.").text }
    var viewMore: String                        { LocalizableString("View More").text }
    var searchCurrency: String                  { LocalizableString("Search currency").text }
    var tokens: String                          { LocalizableString("Tokens").text }
    var addFavorite: String                     { LocalizableString("Add Favorite").text }
    var pay: String                             { LocalizableString("Pay").text }
    var from: String                            { LocalizableString("From").text }
    var exchangeRate: String                    { LocalizableString("Exchange Rate").text }
    var swapNow: String                         { LocalizableString("Swap now").text }
    var swapToken: String                       { LocalizableString("Swap Token").text }
    var assets: String                          { LocalizableString("Assets").text }
    var enterAmount: String                     { LocalizableString("Enter Amount").text }
    var searchAssets: String                    { LocalizableString("Search Asset").text }
    var searchTrendingCoins: String             { LocalizableString("search trending coins").text }
    var searchCoins: String                     { LocalizableString("search coins").text }
    var selectAssets: String                    { LocalizableString("Select Asset").text }
    var addHideTokens: String                   { LocalizableString("Add/Hide Tokens").text }
    var today: String                           { LocalizableString("Today").text }
    var previous: String                        { LocalizableString("Previous").text }
    var sendSuccessfully: String                { LocalizableString("Send Successfully").text }
    var viewHistory: String                     { LocalizableString("View history").text }
    var scanAddressToReceive: String            { LocalizableString("Scan address to receive payment").text }
    var orCopyAddress: String                   { LocalizableString("Or copy your address.").text }
    var ftmReceiveAddress: String               { LocalizableString("(Only FTM can be received to this address)").text }
    var requestPayment: String                  { LocalizableString("Request Payment").text }
    var networks: String                        { LocalizableString("Networks").text }
    var otherNetworks: String                   { LocalizableString("Other Networks").text }
    var langDeviceSettings: String              { LocalizableString("Device Settings").text }
    var langEnglish: String                     { LocalizableString("English").text }
    var langChineseSimplified: String           { LocalizableString("Chinese Simplified").text }
    var langFinnish: String                     { LocalizableString("Finnish").text }
    var langHindi: String                       { LocalizableString("Hindi").text }
    var langSpanish: String                     { LocalizableString("Spanish").text }
    var confirmLogout: String                   { LocalizableString("Do you want to logout?").text }
    var getStarted: String                      { LocalizableString("Get Started").text }
    var splashStartMessage: String              { LocalizableString("splashStartMessage").text }
    var walletSetupMessage: String              { LocalizableString("walletSetupMessage").text }
    var phraseImport: String                    { LocalizableString("Import Using Phrase").text }
    var createWallet: String                    { LocalizableString("Create a new Wallet").text }
    var seedPhrase: String                      { LocalizableString("Seed Phrase").text }
    var seedPhrasePlaceholder: String           { LocalizableString("seedPhrasePlaceholder").text }
    var newPassword: String                     { LocalizableString("New Password").text }
    var enterPassword: String                   { LocalizableString("Enter Password").text }
    var passwordStrength: String                { LocalizableString("Password strength").text }
    var confirmPassword: String                 { LocalizableString("Confirm Password").text }
    var reEnterpassword: String                 { LocalizableString("Re-enter Password").text }
    var youAgreeTo: String                      { LocalizableString("You agree to these ").text }
    var termsAndConditions: String              { LocalizableString("Terms and conditions").text }
    var importAndLogin: String                  { LocalizableString("Import and Login").text }
    var cannotRecoverMessage: String            { LocalizableString("cannotRecoverMessage").text }
    var learnMore: String                       { LocalizableString("Learn More").text }
    var createPassword: String                  { LocalizableString("Create Password").text }
    var next: String                            { LocalizableString("Next").text }
    var privatePhraseMessage: String            { LocalizableString("privatePhraseMessage").text }
    var registerWelcomeMessage: String          { LocalizableString("registerWelcomeMessage").text }
    var weak: String                            { LocalizableString("Weak").text }
    var fair: String                            { LocalizableString("Fair").text }
    var good: String                            { LocalizableString("Good").text }
    var strong: String                          { LocalizableString("Strong").text }
}
