//
//  SessionView.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import SwiftUI

struct SessionView: View {
    @EnvironmentObject var data: CryptoAppData
    
    var body: some View {
        ZStack {
            switch data.sessionState {
            case .loggedIn:
                TabbarView()
                    .transition(.opacity)
            case .loggedOut:
                SplashStackView()
                    .transition(.opacity)
            }
        }
        .animation(.linear(duration: 0.3), value: data.sessionState)
        .onAppear() {
            data.sessionState = LocalStorage.shared.isUserLoggedIn == true ? .loggedIn :  .loggedOut
        }
    }
}

struct SessionView_Previews: PreviewProvider {
    static var previews: some View {
        SessionView()
            .environmentObject(CryptoAppData())
    }
}
