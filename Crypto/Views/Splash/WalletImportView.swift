//
//  ImportWalletView.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import SwiftUI

struct WalletImportView: View {
    @EnvironmentObject var data: CryptoAppData
    @Binding var state: SplashScreenState
    @Binding var shouldPop: Bool
    @State private var seedPhrase: String = ""
    @ObservedObject private var newPasswordViewModel = PasswordStrengthViewModel()
    @State private var confirmationPassword: String = ""
    @State private var isCheckmarkChecked: Bool = false
    @State private var showQRScanner: Bool = false
    @State private var scannedQRCode: String = ""
    var body: some View {
        GeometryReader { proxy in
            ScrollView(showsIndicators: false) {
                VStack {
                    VStack(spacing: 0) {
                        Spacer().frame(height: 24)
                        
                        HStack(alignment: .center, spacing: 0) {
                            Button {
                                shouldPop = true
                                state = .wallet
                            } label: {
                                Image("back")
                            }
                            Text(heroText)
                                .frame(alignment: .center)
                                .font(Fonts.boldFont24)
                                .multilineTextAlignment(.center)
                            .lineSpacing(3.0)
                            .frame(maxWidth: .infinity)
                            .offset(x: -12.0)
                        }
                        
                        Spacer().frame(height: 30.0)
                        VStack(alignment: .leading, spacing: 0) {
                            CustomTextFieldWithTitle(
                                text: $seedPhrase,
                                trailingImageName: "qr-code",
                                title: data.strings.seedPhrase,
                                placeholderText: data.strings.seedPhrasePlaceholder,
                                placeholderTextColor: Colors.blue70White70,
                                isMultiLineEntry: true) {
                                    scannedQRCode = ""
                                    showQRScanner.toggle()
                                }
                            
                            Spacer()
                                .frame(height: 24.0)
                            
                            CustomTextFieldWithTitle(
                                text: $newPasswordViewModel.password,
                                title: data.strings.newPassword,
                                placeholderText: data.strings.enterPassword,
                                placeholderTextColor: Colors.blue70White70,
                                isSecureEntry: true)
                            
                            HStack(spacing: 0) {
                                CustomText(
                                    name: data.strings.passwordStrength,
                                    textColor: Colors.blue70White,
                                    font: Fonts.regularFont12,
                                    maxWidth: false)
                                CustomText(
                                    name: newPasswordViewModel.passwordStrength.title,
                                    textColor: newPasswordViewModel.passwordStrength.tintColor,
                                    font: Fonts.regularFont12,
                                    maxWidth: false)
                            }
                            .padding(.top, 0.0)
                            
                            Spacer()
                                .frame(height: 24.0)
                            CustomTextFieldWithTitle(
                                text: $confirmationPassword,
                                title: data.strings.confirmPassword,
                                placeholderText: data.strings.reEnterpassword,
                                placeholderTextColor: Colors.blue70White70,
                                isSecureEntry: true)
                            Spacer()
                                .frame(height: 24.0)
                            
                            HStack(alignment: .center, spacing: 0) {
                                CheckmarkView(isChecked: $isCheckmarkChecked)
                                    .padding(.trailing, 14.0)
                                CustomText(name: data.strings.youAgreeTo, textColor: Colors.blueWhite, font: Fonts.regularFont12, maxWidth: false)
                                
                                CustomText(name: data.strings.termsAndConditions, textColor: Colors.brown, font: Fonts.regularFont12, maxWidth: false)
                                    .onTapGesture {
                                        print("learn more...")
                                    }
                                    .padding(.leading, -4.0)
                            }
                        }
                    }
                    
                    Spacer()
                    
                    PrimaryButton(text: data.strings.importAndLogin) {
                        print("Import and login")
                        state = .app
                    }
                    .opacity(canSubmit ? 1.0 : 0.7)
                    .frame(height: 46.0)
                    .padding(.top, 80.0)
                    .disabled(!canSubmit)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 80)
                .frame(minHeight: proxy.size.height)
            }
            .background(
                BackgroundGradientView()
            )
            /// Show QR Scanner view
            .fullScreenCover(isPresented: $showQRScanner) {
                NavigationView {
                    QRScannerView(scannedCode: $scannedQRCode)
                }
            }
            /// Observe scannedQRCode changes
            .onChange(of: scannedQRCode) { newValue in
                if !newValue.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    seedPhrase = newValue
                }
            }
        }
    }
    
    private var heroText: AttributedString {
        var text1: AttributedString {
            "Import "
                .attributedString(withFont: Fonts.boldFont24, textColor: Colors.brown)
        }
        var text2: AttributedString {
            "Wallet"
                .attributedString(withFont: Fonts.boldFont24, textColor: Colors.blueWhite)
        }
        
        return text1 + text2
    }
    
    private var canSubmit: Bool {
        isCheckmarkChecked && !seedPhrase.isEmpty && !newPasswordViewModel.password.isEmpty && newPasswordViewModel.password == confirmationPassword
    }
}

struct ImportWalletView_Previews: PreviewProvider {
    static var previews: some View {
        WalletImportView(state: .constant(.start), shouldPop: .constant(false))
            .environmentObject(CryptoAppData())
    }
}
