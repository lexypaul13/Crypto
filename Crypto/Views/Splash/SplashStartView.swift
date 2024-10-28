//
//  SplashStartView.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import SwiftUI

struct SplashStartView: View {
    @EnvironmentObject var data: CryptoAppData
    @Binding var state: SplashScreenState
    @State private var imageOpacity = 0.0
    @State private var imageScale = 0.01
    var body: some View {
        VStack(spacing: 0) {
            Spacer().frame(height: 24)
            
            Text(heroText)
                .frame(alignment: .center)
                .font(Fonts.boldFont24)
                .multilineTextAlignment(.center)
                .lineSpacing(3.0)
            
            Image("bitcoin-banner")
                .resizable()
                .scaledToFit()
                .frame(maxHeight: 266)
                .padding(.bottom, 80.0)
                .padding(.top, 80.0)
                .scaleEffect(imageScale)
                .transition(.opacity)
            
            CustomText(
                name: data.strings.splashStartMessage,
                textColor: Colors.blueWhite,
                alignment: .center,
                font: Fonts.regularFont14,
                multilineTextAlignment: .center)
            .lineSpacing(3.0)
            
            PrimaryButton(text: data.strings.getStarted) {
                state = .wallet
            }
            .frame(height: 46.0)
            .padding(.top, 80.0)
        }
        .padding(.horizontal, 24)
        .padding(.bottom, 80)
        .background(
            BackgroundGradientView()
        )
        .onAppear() {
            withAnimation(.easeOut(duration: 0.4)) {
                imageScale = 1.5
                imageOpacity = 1.0
            }
            
            withAnimation(.easeIn(duration: 0.3).delay(0.4)) {
                imageScale = 1.0
            }
        }
    }
    
    private var heroText: AttributedString {
        var text1: AttributedString {
            "Your "
                .attributedString(withFont: Fonts.boldFont24, textColor: Colors.blueWhite)
        }
        var text2: AttributedString {
            "Crypto"
                .attributedString(withFont: Fonts.boldFont24, textColor: Colors.brown)
        }
        var text3: AttributedString {
            " always\nin your "
                .attributedString(withFont: Fonts.boldFont24, textColor: Colors.blueWhite)
        }
        var text4: AttributedString {
            "Pocket"
                .attributedString(withFont: Fonts.boldFont24, textColor: Colors.brown)
        }
        
        return text1 + text2 + text3 + text4
    }
}

struct SplashStartView_Previews: PreviewProvider {
    static var previews: some View {
        SplashStartView(state: .constant(.start))
            .environmentObject(CryptoAppData())
    }
}
