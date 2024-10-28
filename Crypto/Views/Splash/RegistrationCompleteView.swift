//
//  RegistrationCompleteView.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import SwiftUI

struct RegistrationCompleteView: View {
    @EnvironmentObject var data: CryptoAppData
    @Binding var state: SplashScreenState
    @State private var rotation = 0.0
    @State private var opacity = 0.0
    var body: some View {
        VStack(spacing: 0) {
            LoginProgressIndicatorView(currentStep: 3)
            Spacer().frame(height: 30.0)
            Text(heroText)
                .frame(alignment: .center)
                .font(Fonts.boldFont24)
                .multilineTextAlignment(.center)
                .lineSpacing(3.0)
            
            Image("coin-banner")
                .resizable()
                .scaledToFit()
                .frame(maxHeight: 178)
                .padding(.bottom, 80.0)
                .padding(.top, 80.0)
                .opacity(opacity)
                .rotationEffect(.degrees(rotation))
                .transition(.opacity)
                .scaleEffect(rotation == 360 ? 1 : 1.5)
            
            CustomText(
                name: data.strings.registerWelcomeMessage,
                textColor: Colors.blueWhite,
                alignment: .center,
                font: Fonts.regularFont14,
                multilineTextAlignment: .center)
            .lineSpacing(3.0)
            
            Spacer()
            PrimaryButton(text: data.strings.next) {
                state = .app
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
            withAnimation(.easeIn(duration:0.5).speed(0.5)) {
                rotation = 360
                opacity = 1.0
            }
        }
        
    }
    
    private var heroText: AttributedString {
        var text1: AttributedString {
            "You're In! "
                .attributedString(withFont: Fonts.boldFont24, textColor: Colors.blueWhite)
        }
        var text2: AttributedString {
            "Welcome"
                .attributedString(withFont: Fonts.boldFont24, textColor: Colors.brown)
        }
        
        return text1 + text2
    }
}

struct RegistrationCompleteView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationCompleteView(state: .constant(.start))
            .environmentObject(CryptoAppData())
    }
}


