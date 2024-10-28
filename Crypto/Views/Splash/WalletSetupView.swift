//
//  WalletSetupView.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import SwiftUI

struct WalletSetupView: View {
    @EnvironmentObject var data: CryptoAppData
    @Binding var state: SplashScreenState
    @State private var imageOpacity = 0.0
    @State private var imageScale = 0.01
    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 0) {
                Spacer().frame(height: 24)
                
                Text(heroText)
                    .frame(alignment: .center)
                    .font(Fonts.boldFont24)
                    .multilineTextAlignment(.center)
                    .lineSpacing(3.0)
                    .padding(.horizontal, 24.0)
                Spacer().frame(height: 55.0)
                Image("wallet-banner")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: proxy.size.width * 0.9)
                    .clipped()
                    .scaleEffect(imageScale)
                    .transition(.opacity)
                Spacer().frame(height: 48.0)
                VStack {
                    CustomText(
                        name: data.strings.walletSetupMessage,
                        textColor: Colors.blueWhite,
                        alignment: .center,
                        font: Fonts.regularFont14,
                        multilineTextAlignment: .center)
                    .lineSpacing(3.0)
                    Spacer()
                        .frame(height: 32.0)
                    PrimaryButton(
                        text: data.strings.phraseImport,
                        foregroundColor: Colors.blueWhite,
                        backgroundColor: Colors.brown20Brown5,
                        clicked:  {
                            state = .walletImport
                        },
                        setGradient: false)
                    .frame(height: 46.0)
                    
                    PrimaryButton(text: data.strings.createWallet) {
                        state = .login
                    }
                    .frame(height: 46.0)
                    .padding(.top, 16.0)
                }
                .padding(.horizontal, 24)
            }
            .padding(.bottom, 80)
            .background(
                BackgroundGradientView()
            )
            .onAppear() {
                withAnimation(.easeOut(duration: 0.4)) {
                    imageScale = 1.5
                    imageOpacity = 0.6
                }
                
                withAnimation(.easeIn(duration: 0.3).delay(0.4)) {
                    imageScale = 1.0
                    imageOpacity = 1.0
                }
            }
        }
    }
    
    private var heroText: AttributedString {
        var text1: AttributedString {
            "Wallet "
                .attributedString(withFont: Fonts.boldFont24, textColor: Colors.brown)
        }
        var text2: AttributedString {
            "Setup"
                .attributedString(withFont: Fonts.boldFont24, textColor: Colors.blueWhite)
        }
        
        return text1 + text2
    }
}

struct WalletSetupView_Previews: PreviewProvider {
    static var previews: some View {
        WalletSetupView(state: .constant(.start))
            .environmentObject(CryptoAppData())
    }
}
