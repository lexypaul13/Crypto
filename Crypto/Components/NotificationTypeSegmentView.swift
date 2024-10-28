//
//  NotificationTypeSegmentView.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import SwiftUI

struct NotificationTypeSegmentView: View {
    var notificationTypes: [NotificationType]
    @Binding var currentTab: NotificationType
    var body: some View {
        HStack(spacing: 0) {
            ForEach(notificationTypes) { item in
                Button {
                    currentTab = item
                } label: {
                    if currentTab == item {
                        HStack(spacing: 0) {
                            CustomText(name: item.title, textColor: Colors.blueWhite, alignment: .center, font: Fonts.regularFont14,
                                       maxWidth: false,
                                       lineLimit: 1)
                       
                            Circle()
                                .fill(Colors.brown)
                                .frame(width: 10, height: 10)
                                .padding(.leading, 2.0)
                        }
                    } else {
                        CustomText(name: item.title, textColor: Colors.blueWhite.opacity(0.7), alignment: .center, font: Fonts.regularFont14, maxWidth: false)
                    }
                }
            }
            .frame(maxWidth: .infinity)
        }
        .padding(.vertical, 12.0)
    }
}

struct NotificationTypeSegmentView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationTypeSegmentView(notificationTypes: NotificationType.allCases, currentTab: .constant(.system))
    }
}
