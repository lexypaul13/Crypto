//
//  NotificationViewModel.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import Foundation
import Combine

class NotificationViewModel: ObservableObject {
    @Published var notificationList: [Notification]
    @Published var isLoading: Bool
    private var cancellables = Set<AnyCancellable>()
    private let notificationService: NotificationDataService
    
    init() {
        notificationList = []
        notificationService = NotificationDataService()
        isLoading = false
        
        fetchNotifications()
    }
    
    // fetch notifications
    func fetchNotifications() {
        isLoading = true
        notificationService.getNotifications()
            .receive(on: RunLoop.main)
            .sink { completion in
                self.isLoading = false
            } receiveValue: { notifications in
                self.notificationList = notifications
            }
            .store(in: &cancellables)
    }
}

extension NotificationViewModel {
    func getNotifications(of type: NotificationType) {
        notificationList.shuffle()
    }
    
    func setRead(notification: Notification) {
        let index = notificationList.firstIndex { $0.id == notification.id }
        guard let index = index else {
            return
        }
        notificationList[index] = notification.updateRead()
    }
}
