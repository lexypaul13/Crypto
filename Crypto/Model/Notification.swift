//
//  Notification.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import Foundation

struct Notification: Identifiable, Codable {
    let id: String
    let title: String
    let description: String
    let date: String
    var isRead: Bool?
}

extension Notification {
    var notificationDateString: String {
        guard let date = date.toDate(dateFormat: "yyyy-MM-dd HH:mm:ss Z")?.toString(format: "yyyy-MM-dd HH:mm:ss") else { return "" }
        
        return "\(date) (UTC)"
    }
    
    func updateRead() -> Notification {
        return Notification(id: id, title: title, description: description, date: date, isRead: true)
    }
}

enum NotificationType: String, CaseIterable, Identifiable {
    case system = "System"
    case announcements = "Announcements"
    case campaigns = "Campaigns"
    
    var id: Self {
        return self
    }
    
    var title: String {
        let strings = LocalizableString()
        switch self {
        case .system:        return strings.system
        case .announcements: return strings.announcements
        case .campaigns:     return strings.campaigns
        }
    }
}
