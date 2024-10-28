//
//  ReceiveView.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import SwiftUI

struct ReceiveView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var data: CryptoAppData
    private let tokenAddress = "0x000...000"
    
    @State var showCopiedMessage = false
    
    var body: some View {
            VStack {
                Spacer().frame(height: 24)
                VStack {
                    ScrollView {
                        VStack(alignment: .center) {
                            CustomText(
                                name: data.strings.scanAddressToReceive,
                                textColor: Colors.blueWhite.opacity(0.7),
                                alignment: .center,
                                font: Fonts.regularFont14)
                            .padding(.top, 16.0)
                            .padding(.bottom, 24.0)
                            
                            VStack {
                                Image("qrcode")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 250, height: 250)
                            }
                            .overlay {
                                if colorScheme == .dark {
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(
                                            LinearGradient(
                                                gradient: Gradient(colors: [Colors.brown, Colors.brownWhite]),
                                                startPoint: .leading,
                                                endPoint: .trailing
                                            ), lineWidth: 2.0
                                        )
                                }else {
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Colors.blue70White70)
                                }
                            }
                            .padding(.bottom, 24.0)
                            
                            CustomText(
                                name: data.strings.orCopyAddress,
                                textColor: Colors.blueWhite.opacity(0.7),
                                alignment: .center,
                                font: Fonts.regularFont14)
                            .padding(.bottom, 0.0)
                            
                            CustomText(
                                name: data.strings.ftmReceiveAddress,
                                textColor: Colors.blueWhite.opacity(0.7),
                                alignment: .center,
                                font: Fonts.regularFont12)
                            .padding(.top, -8.0)
                            
                            HStack(alignment: .center, spacing: 12.0) {
                                CustomText(
                                    name: tokenAddress,
                                    textColor: Colors.blueWhite.opacity(0.7),
                                    font: Fonts.regularFont12)
                                Spacer()
                                Button {
                                    ClipboardManager.shared.copyPlainText(tokenAddress)
                                    showCopiedMessage.toggle()
                                } label: {
                                    Image("copy")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 24, height: 24)
                                        .foregroundColor(Colors.blueWhite)
                                }
                                ShareLink(item: tokenAddress) {
                                    Image("share")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 24, height: 24)
                                        .foregroundColor(Colors.blueWhite)
                                }
                            }
                            .padding(.vertical, 12.0)
                            .padding(.horizontal, 20.0)
                            .background(Colors.brown20Brown5)
                            .clipShape(Capsule())
                            .padding(.top, 32.0)
                        }
                    }
                    Spacer()
                    PrimaryButton(text: data.strings.requestPayment, clicked: {
                        print("request payment")
                    })
                    .frame(height: 48)
                }
                .padding(24)
                .background(Colors.brown8DarkBlue)
                .cornerRadius(36)
                .overlay(
                    RoundedRectangle(cornerRadius: 36)
                        .stroke(Colors.brown25Blue, lineWidth: 1)
                )
            }
            .foregroundColor(Colors.blueWhite)
            .padding(.horizontal, 24)
            .padding(.bottom, 32)
            .navigationBarBackButtonHidden()
            .background(BackgroundGradientView())
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button {
                    presentationMode.wrappedValue.dismiss()
                }label: {
                    Image("back")
                        .padding(.leading, 12)
                },
                trailing: NavigationLink(destination: HistoryView(viewModel: data.transactionsViewModel)) {
                    Image("history")
                        .tint(.white)
                        .padding(.leading, 12)
                }
            )
            .toolbar {
                ToolbarItem(placement: .principal) {
                    ToolbarContentView(title: data.strings.receive, subTitle: "FANTOM OPERA")
                }
            }
            .overlay(
                CopiedMessageView(showCopiedMessage: $showCopiedMessage)
                    .padding(.bottom, 8.0)
            )
    }
}

struct ReceiveView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ReceiveView()
                .environmentObject(CryptoAppData())
        }
    }
}
