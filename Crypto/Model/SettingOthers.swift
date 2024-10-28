//
//  SettingOthers.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import SwiftUI

enum SettingOthers: String, CaseIterable, Hashable {
    case history
    case scanQrCode
    case notification
    case security
    case appearance
    case language
    
    var image: Image {
        return Image(self.rawValue).renderingMode(.template)
    }
}

extension SettingOthers {
    var title: String {
        let strings = LocalizableString("")
        switch self {
        case .history:
            return strings.historySetting
        case .scanQrCode:
            return strings.scanQRCodeSetting
        case .notification:
            return strings.notificationSetting
        case .security:
            return strings.securitySetting
        case .appearance:
            return strings.appearanceSetting
        case .language:
            return strings.languageSetting
        }
    }
}
