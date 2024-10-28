//
//  CopiedMessageView.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import SwiftUI

struct CopiedMessageView: View {
    @EnvironmentObject var data: CryptoAppData
    @Binding var showCopiedMessage: Bool
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            if showCopiedMessage {
                Text(data.strings.copied)
                    .font(Fonts.mediumFont12)
                    .padding(.vertical)
                    .padding(.horizontal, 32.0)
                    .background(Colors.brown)
                    .foregroundColor(Colors.blue)
                    .clipShape(Capsule())
                    .transition(.move(edge: .bottom))
            }
        }
        .frame(maxWidth: .infinity)
        .shadow(color: Colors.blueWhite.opacity(0.2), radius: 4.0, x: 0, y: 1)
        .onChange(of: showCopiedMessage, perform: { newValue in
            if newValue {
                DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
                    showCopiedMessage.toggle()
                }
            }
        })
        .animation(.easeInOut(duration: 0.3), value: showCopiedMessage)
    }
}

struct CopiedMessageView_Previews: PreviewProvider {
    static var previews: some View {
        CopiedMessageView(showCopiedMessage: .constant(true))
            .environmentObject(CryptoAppData())
    }
}
