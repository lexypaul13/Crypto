//
//  SettingView.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import SwiftUI

struct SettingView: View {
    @AppStorage("selectedLanguage") private var selectedLanguage: String?
    @EnvironmentObject var data: CryptoAppData
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var showHistory = false
    @State private var showNotification = false
    @State private var showQRScanner = false
    @State private var showSecurity = false
    @State private var showQROpenDialog = false
    @State private var showAppearance = false
    @State private var openQRCodeLink = false
    @State private var showLanguage = false
    @State private var scannedQRCode: String = ""
    @State var showCopiedMessage = false
    @State private var showConfirmLogout: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    profileCardView()
                    
                    Spacer().frame(height: 50)
                    
                    HomeSection(sectionName: data.strings.myWallets, imageType: .image(image: Image("plus")))
                        .padding(.top, 8)
                        .padding(.horizontal, 24)
                    VStack(spacing: 12) {
                        ForEach(data.tokenList.prefix(5).map{ ChainViewModel(chain: $0)}) { chain in
                            SettingCardView(vm: chain) {
                                ClipboardManager.shared.copyPlainText(dummyWalletAddress)
                                showCopiedMessage.toggle()
                            }
                        }
                    }
                    .padding(.horizontal, 24)
                    VStack(spacing: 0) {
                        Spacer().frame(height: 16)
                        HomeSection(sectionName: data.strings.myContacts)
                        Spacer().frame(height: 4)
                    }
                    .padding(.horizontal, 24)
                    VStack(spacing: 12) {
                        ForEach(data.tokenContactList, id: \.self) { item in
                            TokenContactCardView(vm: item)
                        }
                    }
                    .padding(.horizontal, 24)
                    HomeSection(sectionName: data.strings.others, imageType: .none)
                        .padding(.top, 16)
                        .padding(.horizontal, 24)
                    VStack {
                        VStack(spacing: 0){
                            ForEach(Array(SettingOthers.allCases.enumerated()), id: \.0) { (index, settingOthers) in
                                VStack(spacing: 0) {
                                    Button {
                                        switch settingOthers {
                                        case .history:
                                            showHistory = true
                                        case .notification:
                                            showNotification = true
                                        case .scanQrCode:
                                            scannedQRCode = ""
                                            showQRScanner.toggle()
                                        case .security:
                                            showSecurity.toggle()
                                        case .appearance:
                                            showAppearance.toggle()
                                        case .language:
                                            showLanguage.toggle()
                                        }
                                    } label: {
                                        settingOthersRow(for: settingOthers)
                                    }
                                    if shouldShowSeparator(at: index) {
                                        Spacer().frame(height: 24)
                                        CustomDivider(height: 1)
                                        Spacer().frame(height: 24)
                                    }
                                }
                            }
                        }
                        .padding(24)
                        .background(Colors.brown8DarkBlue)
                        .cornerRadius(36)
                        .overlay(
                            RoundedRectangle(cornerRadius: 36)
                                .stroke(Colors.brown25Blue, lineWidth: 1)
                        )
                    }
                    .padding(.horizontal, 24)
                    PrimaryButton(text: data.strings.logout, clicked: {
                        showConfirmLogout.toggle()
                    })
                        .frame(height: 46)
                        .padding(.top, 16)
                        .padding(.horizontal, 24)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                trailing: Button(action: {
                    showNotification = true
                }) {
                    Image("notification.fill")
                        .padding(.trailing, 12)
                }
            )
            .toolbar {
                ToolbarItem(placement: .principal) {
                    ToolbarContentView(title: data.strings.settings)
                }
            }
            .scrollViewTransparentNavigation()
            .background(
                BackgroundGradientView()
            )
            .navigationDestination(isPresented: $showHistory, destination: {
                HistoryView(viewModel: data.transactionsViewModel)
            })
            .navigationDestination(isPresented: $showNotification, destination: {
                NotificationView(viewModel: data.notificationViewModel)
            })
            .navigationDestination(isPresented: $showSecurity, destination: {
                SecurityView()
            })
            .navigationDestination(isPresented: $showAppearance, destination: {
                SelectDarkModeView()
            })
            .navigationDestination(isPresented: $showLanguage, destination: {
                SelectLanguageView()
            })
            .fullScreenCover(isPresented: $showQRScanner) {
                NavigationView {
                    QRScannerView(scannedCode: $scannedQRCode)
                }
            }
            .onChange(of: scannedQRCode) { newValue in
                if newValue != "" {
                    // Was receiving Attempt to present...while a presentation is in progress error when using PhotosUI.
                    // Adding some delay fixed the issue
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.6) {
                        showQROpenDialog.toggle()
                    }
                }
            }
            .confirmationDialog("", isPresented: $showQROpenDialog) {
                if let _ = URL(string: scannedQRCode) {
                    Button(data.strings.openInBrowser) {
                        openQRCodeLink.toggle()
                    }
                }
                
                Button(data.strings.copyToClipboard) {
                    ClipboardManager.shared.copyPlainText(scannedQRCode)
                }
                
                Button(data.strings.cancel, role: .cancel) {
                    
                }
            }
            .fullScreenCover(isPresented: $openQRCodeLink) {
                SafariWebView(url: URL(string: scannedQRCode)!)
                    .ignoresSafeArea()
            }
            .onChange(of: selectedLanguage) { newValue in
                DispatchQueue.main.asyncAfter(deadline: .now()+0.7) {
                    withAnimation {
                        data.selectedTab = .home
                    }
                }
            }
            .alert(data.strings.confirmLogout, isPresented: $showConfirmLogout) {
                Button(data.strings.logout) {
                    LocalStorage.shared.isUserLoggedIn = false
                    data.sessionState = .loggedOut
                }
                
                Button(data.strings.cancel, role: .cancel, action: {})
            }
            .overlay(
                CopiedMessageView(showCopiedMessage: $showCopiedMessage)
                    .padding(.bottom, 8.0)
            )
        }
    }
    
    @ViewBuilder
    private func profileCardView() -> some View {
        GeometryReader { geometry in
            VStack(alignment: .center, spacing: 4) {
                Image("dummyUserImage")
                Spacer().frame(height: 20)
                CustomText(name: "Angelina Jolie", textColor: Colors.brown, alignment: .center, font: Fonts.boldFont16)
                HStack {
                    CustomText(name: "abc@xyz.com", alignment: .trailing, font: Fonts.semiBoldFont14, maxWidth: false)
                    Image("pencil")
                        .foregroundColor(Colors.blueWhite)
                }
            }
            .padding(EdgeInsets(top: 32, leading: 16, bottom: 32, trailing: 16))
            .background(Colors.brown8DarkBlue70)
            .cornerRadius(36)
            .overlay(
                RoundedRectangle(cornerRadius: 36)
                    .stroke(Colors.brown25Blue, lineWidth: 1)
            )
            .padding(.top, 230)
            .padding(.horizontal, 50)
            .frame(width: geometry.size.width, height: geometry.size.height)
            .scaleEffect(GlobalFunctions.scale(for: geometry))
            .offset(y: GlobalFunctions.offset(for: geometry))
        }
        .frame(height: 198) // Adjust the desired height of the image
    }
    
    @ViewBuilder
    private func settingOthersRow(for setting: SettingOthers) -> some View {
        HStack(spacing: 12) {
            setting.image
                .tint(Colors.blueWhite)
            CustomText(name: setting.title, textColor: Colors.blueWhite, font: Fonts.semiBoldFont14)
            Image("rightArrow")
                .foregroundColor(Colors.blueWhite)
        }
    }
    
    private func shouldShowSeparator(at index: Int) -> Bool {
        index != (SettingOthers.allCases.count - 1)
    }
    
    private var dummyWalletAddress: String {
        "0x00000000000000000000000000000000"
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
            .environmentObject(CryptoAppData())
    }
}
