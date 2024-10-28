//
//  BackgroundGradientView.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import SwiftUI

struct BackgroundGradientView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack(alignment: .top) {
            if colorScheme == .dark {
                Image("backgroundImage")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
            }else {
                Rectangle()
                    .fill(.white)
                    .edgesIgnoringSafeArea(.all)
            }
        }
        .ignoresSafeArea()
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundGradientView()
            .previewDisplayName("Light")
            .preferredColorScheme(.light)
        
        BackgroundGradientView()
            .previewDisplayName("Dark")
            .preferredColorScheme(.dark)
    }
}
