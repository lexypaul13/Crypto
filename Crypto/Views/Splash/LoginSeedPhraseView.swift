//
//  LoginSeedPhraseView.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import SwiftUI

struct LoginSeedPhraseView: View {
    @EnvironmentObject var data: CryptoAppData
    @Binding var state: SplashScreenState
    @State private var showCopiedMessage: Bool = false
    @State private var seedPhrase: String = SeedPhraseGenerator.shared.generate()
    var body: some View {
        VStack(spacing: 0) {
            LoginProgressIndicatorView(currentStep: 2)
            Spacer().frame(height: 30.0)
            Text(heroText)
                .frame(alignment: .center)
                .font(Fonts.boldFont24)
                .multilineTextAlignment(.center)
                .lineSpacing(3.0)
            
            CustomText(
                name: data.strings.privatePhraseMessage,
                textColor: Colors.blueWhite,
                alignment: .center,
                font: Fonts.regularFont14,
                multilineTextAlignment: .center)
            .lineSpacing(3.0)
            .padding(.bottom, 20.0)
            .padding(.top, 32.0)
            
            VStack(alignment: .center, spacing: 32.0) {
                CustomText(
                    name: seedPhrase,
                    textColor: Colors.blueWhite,
                    alignment: .center,
                    font: Fonts.regularFont14,
                    multilineTextAlignment: .center)
                .lineSpacing(3.0)
                .padding(.horizontal)
                
                Button {
                    ClipboardManager.shared.copyPlainText(seedPhrase)
                    showCopiedMessage.toggle()
                } label: {
                    TextWithImage(
                        todayChangedAmount: data.strings.copyToClipboard,
                        todayChangedPercentage: "",
                        textBackgroundColor: .clear,
                        textForegroundColor: Colors.brown,
                        font: Fonts.boldFont16,
                        image: Image("copy-line"),
                        imageForegroundColor: Colors.brown,
                        verticalPadding: 8,
                        cornerRadius: 30)
                }
                .disabled(showCopiedMessage)
            }
            .padding(.horizontal, 20.0)
            .padding(.vertical, 36.0)
            .background(Colors.brown8DarkBlue85)
            .cornerRadius(24.0)
            .overlay(
                RoundedRectangle(cornerRadius: 24.0)
                    .stroke(Colors.brown25Blue70)
            )
            .layoutPriority(2)
            Spacer()
            PrimaryButton(text: data.strings.next) {
                state = .registrationComplete
            }
            .frame(height: 46.0)
            .padding(.top, 80.0)
        }
        .padding(.horizontal, 24)
        .padding(.bottom, 80)
        .background(
            BackgroundGradientView()
        )
        .overlay(
            CopiedMessageView(showCopiedMessage: $showCopiedMessage)
        )
    }
    
    private var heroText: AttributedString {
        var text1: AttributedString {
            "Keep "
                .attributedString(withFont: Fonts.boldFont24, textColor: Colors.blueWhite)
        }
        var text2: AttributedString {
            "Safe"
                .attributedString(withFont: Fonts.boldFont24, textColor: Colors.brown)
        }
        var text3: AttributedString {
            " your\nSeed Phrase"
                .attributedString(withFont: Fonts.boldFont24, textColor: Colors.blueWhite)
        }
        
        return text1 + text2 + text3
    }
}

struct LoginSeedPhraseView_Previews: PreviewProvider {
    static var previews: some View {
        LoginSeedPhraseView(state: .constant(.start))
            .environmentObject(CryptoAppData())
    }
}
