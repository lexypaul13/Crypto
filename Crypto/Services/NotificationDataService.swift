//
//  NotificationDataService.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import Foundation
import Combine

class NotificationDataService {
    func getNotifications() -> AnyPublisher<[Notification], Error> {
        let dataSource = JSONReaderSource(fileName: "notifications")
        return dataSource
            .get([Notification].self)
            .eraseToAnyPublisher()
    }
}
