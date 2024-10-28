//
//  LoginView.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var data: CryptoAppData
    @Binding var state: SplashScreenState
    @ObservedObject private var newPasswordViewModel = PasswordStrengthViewModel()
    @State private var confirmationPassword: String = ""
    @State private var isCheckmarkChecked: Bool = false
    var body: some View {
        GeometryReader { proxy in
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    LoginProgressIndicatorView(currentStep: 1)
                    Spacer().frame(height: 30.0)
                    Text(heroText)
                        .frame(alignment: .center)
                        .font(Fonts.boldFont24)
                        .multilineTextAlignment(.center)
                        .lineSpacing(3.0)
                    
                    Spacer().frame(height: 30.0)
                    VStack(alignment: .leading, spacing: 0) {
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
                        .padding(.top, 4.0)
                        
                        Spacer()
                            .frame(height: 32.0)
                        CustomTextFieldWithTitle(
                            text: $confirmationPassword,
                            title: data.strings.confirmPassword,
                            placeholderText: data.strings.reEnterpassword,
                            placeholderTextColor: Colors.blue70White70,
                            isSecureEntry: true)
                        Spacer()
                            .frame(height: 32.0)
                        
                        HStack(alignment: .top, spacing: 14) {
                            CheckmarkView(isChecked: $isCheckmarkChecked)
                                .padding(.top, 4.0)
                            
                            VStack(spacing: -4.0) {
                                CustomText(name: data.strings.cannotRecoverMessage, textColor: Colors.blueWhite, font: Fonts.regularFont12)
                                CustomText(name: data.strings.learnMore, textColor: Colors.brown, font: Fonts.regularFont12)
                                    .onTapGesture {
                                        print("learn more...")
                                    }
                            }
                        }
                    }
                    Spacer()
                    PrimaryButton(text: data.strings.createPassword) {
                        state = .loginSeed
                    }
                    .frame(height: 46.0)
                    .padding(.top, 80.0)
                    .opacity(canSubmit ? 1.0 : 0.7)
                    .disabled(!canSubmit)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 80)
                .frame(minHeight: proxy.size.height)
            }
            .background(
                BackgroundGradientView()
            )
        }
    }
    
    private var heroText: AttributedString {
        var text1: AttributedString {
            "Signup "
                .attributedString(withFont: Fonts.boldFont24, textColor: Colors.brown)
        }
        var text2: AttributedString {
            "to VG Wallet"
                .attributedString(withFont: Fonts.boldFont24, textColor: Colors.blueWhite)
        }
        
        return text1 + text2
    }
    
    private var canSubmit: Bool {
        isCheckmarkChecked && !newPasswordViewModel.password.isEmpty && newPasswordViewModel.password == confirmationPassword
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(state: .constant(.start))
            .environmentObject(CryptoAppData())
    }
}
