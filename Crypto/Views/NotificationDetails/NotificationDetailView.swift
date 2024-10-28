//
//  NotificationDetailsView.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import SwiftUI

struct NotificationDetailView: View {
    @EnvironmentObject var data: CryptoAppData
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let notification: Notification
    
    var body: some View {
        VStack {
            Spacer().frame(height: 32)
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    
                    HStack(spacing: 0) {
                        
                        CustomText(
                            name: notification.title,
                            textColor: Colors.blueWhite,
                            alignment: .leading,
                            font: Fonts.semiBoldFont16,
                            multilineTextAlignment: .leading)
                        
                    }
                    
                    CustomText(
                        name: notification.description,
                        textColor: Colors.blueWhite,
                        alignment: .leading,
                        font: Fonts.regularFont14,
                        multilineTextAlignment: .leading)
                    
                    CustomText(
                        name: notification.notificationDateString,
                        textColor: Colors.blueWhite.opacity(0.7),
                        alignment: .leading,
                        font: Fonts.regularFont14)
                    .padding(.top, 8.0)
                    
                    Button {
                        
                    } label: {
                        CustomText(
                            name: data.strings.viewMore,
                            textColor: Colors.brown,
                            alignment: .leading,
                            font: Fonts.regularFont12)
                    }
                    .padding(.top, 16.0)
                }
                
            }
            .padding(.vertical, 8.0)
            .scrollViewTransparentNavigation()
        }
        .padding(.horizontal, 20)
        .navigationBarBackButtonHidden()
        .background(
            BackgroundGradientView()
        )
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(
            leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image("back")
                    .padding(.leading, 12)
            }
        )
        .toolbar {
            ToolbarItem(placement: .principal) {
                ToolbarContentView(title: data.strings.notifications)
            }
        }
        .onAppear() {
            data.notificationViewModel.setRead(notification: notification)
        }
    }
}

struct NotificationDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NotificationDetailView(notification: CryptoAppData.Preview.notification)
                .environmentObject(CryptoAppData())
        }
    }
}
