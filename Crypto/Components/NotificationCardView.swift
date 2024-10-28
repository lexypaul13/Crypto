//
//  NotificationCardView.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import SwiftUI

struct NotificationCardView: View {
    
    var vm: Notification
    
    var body: some View {
        
        HStack(alignment: .top) {
            Image(systemName: "envelope")
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .foregroundColor(Colors.brown)
            
            VStack(alignment: .leading, spacing: 0) {
                
                HStack(spacing: 0) {
                    
                    if !(vm.isRead == true) {
                        Circle()
                            .fill(Colors.brown)
                            .frame(width: 10, height: 10)
                            .padding(.trailing, 4.0)
                    }
                    
                    CustomText(
                        name: vm.title,
                        textColor: vm.isRead == true ? Colors.blueWhite.opacity(0.7) : Colors.blueWhite,
                        alignment: .leading,
                        font: Fonts.semiBoldFont14,
                        lineLimit: 1)
                    
                }
                .padding(.top, -4.0)
                
                CustomText(
                    name: vm.description,
                        textColor: Colors.blueWhite.opacity(0.7),
                        alignment: .leading,
                        font: Fonts.regularFont14,
                        lineLimit: 3,
                        multilineTextAlignment: .leading)
                
                CustomText(
                    name: vm.notificationDateString,
                        textColor: Colors.blueWhite.opacity(0.7),
                        alignment: .leading,
                        font: Fonts.regularFont14)
                .padding(.top, 8.0)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 20)
        .background(Colors.brown8Brown5)
        .cornerRadius(20)
    }
}

struct NotificationCardView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationCardView(vm: CryptoAppData.Preview.notification)
    }
}
