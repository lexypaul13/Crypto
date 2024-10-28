//
//  SplashStackView.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import SwiftUI

enum SplashScreenState {
    case start
    case wallet
    case walletImport
    case login
    case loginSeed
    case registrationComplete
    case app
}

struct SplashStackView: View {
    @EnvironmentObject var data: CryptoAppData
    @State private var state: SplashScreenState = .start
    @State private var shouldPop: Bool = false
    var body: some View {
        ZStack {
            switch state {
            case .start:
                SplashStartView(state: $state)
                    .transition(.asymmetric(insertion: .opacity, removal: .move(edge: .leading)))
            case .wallet:
                WalletSetupView(state: $state)
                    .transition(.asymmetric(
                        // if popped out from WalletImportView
                        // animate move from leading edge
                        insertion: .move(edge: shouldPop ? .leading : .trailing),
                        removal: .move(edge: .leading)))
            case .walletImport:
                WalletImportView(state: $state, shouldPop: $shouldPop)
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .opacity))
            case .login:
                LoginView(state: $state)
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
            case .loginSeed:
                LoginSeedPhraseView(state: $state)
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
            case .registrationComplete:
                RegistrationCompleteView(state: $state)
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .opacity))
            case .app:
                BackgroundGradientView()
            }
        }
        .ignoresSafeArea(.all, edges: [.bottom])
        .animation(.easeInOut, value: state)
        .onChange(of: state) { newValue in
            if newValue == .app {
                LocalStorage.shared.isUserLoggedIn = true
                data.sessionState = .loggedIn
            }
        }
    }
}

struct SplashStackView_Previews: PreviewProvider {
    static var previews: some View {
        SplashStackView()
            .environmentObject(CryptoAppData())
    }
}
