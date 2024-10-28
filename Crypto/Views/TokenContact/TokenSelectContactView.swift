//
//  TokenSelectContactView.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import SwiftUI

struct TokenSelectContactView: View {
    @EnvironmentObject var data: CryptoAppData
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var token: TokenContact?
    @Binding var address: String
    var body: some View {
        VStack {
            // top row view
            HStack(alignment: .center, spacing: 0) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image("back")
                        .foregroundColor(Colors.blueWhite)
                }
                .frame(width: 24, height: 24)
                CustomText(
                        name: data.strings.contacts,
                        textColor: Colors.blueWhite,
                        alignment: .center,
                        font: Fonts.boldFont14)
                .offset(x: -12)
            }
            .padding(.bottom, 24.0)
            VStack {
                ForEach(data.tokenContactList, id: \.self) { item in
                    TokenContactCardView(vm: item)
                        .onTapGesture {
                            token = item
                            address = item.obfuscatedAddress
                            presentationMode.wrappedValue.dismiss()
                        }
                }
            }
            Spacer()
        }
        .padding(.top, 32.0)
        .padding(.horizontal, 24)
        .background(Colors.pureWhiteDarkBlue70)
        .overlay(
            TopShape(isClosedShape: false)
                .stroke(Colors.brown25Blue, lineWidth: 1.0)
        )
        .clipShape(TopShape(isClosedShape: true))
        .ignoresSafeArea()
    }
}

struct TokenSelectContactView_Previews: PreviewProvider {
    static var previews: some View {
        TokenSelectContactView(token: .constant(
            CryptoAppData.Preview.tokenContact),
            address: .constant("")
        )
            .environmentObject(CryptoAppData())
            .frame(maxHeight: .infinity)
            .background(Colors.pureWhiteDarkBlue70)
            .previewDisplayName("Light")
            .preferredColorScheme(.light)
        
        TokenSelectContactView(token: .constant(
            CryptoAppData.Preview.tokenContact),
            address: .constant("")
        )
            .environmentObject(CryptoAppData())
            .frame(maxHeight: .infinity)
            .background(Colors.pureWhiteDarkBlue70)
            .previewDisplayName("Dark")
            .preferredColorScheme(.dark)
            
    }
}

struct TopShape: Shape {
    
    /// Set this to true if you are going to apply fill
    let isClosedShape: Bool
    // Set corner radius of the path. Default is 36.0
    var cornerRadius = 36.0
    
    private let x = 4.0
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.minX, y: (rect.minY + cornerRadius)))
            
            path.addArc(center: CGPoint(x: rect.minX + cornerRadius, y: rect.minY + cornerRadius),
                        radius: cornerRadius,
                        startAngle: Angle(degrees: 180),
                        endAngle: Angle(degrees: 270),
                        clockwise: false)
            path.addLine(to: CGPoint(x: rect.maxX - cornerRadius, y: rect.minY))
            path.addArc(center: CGPoint(x: rect.maxX - cornerRadius, y: rect.minY + cornerRadius),
                        radius: cornerRadius,
                        startAngle: Angle(degrees: 270),
                        endAngle: Angle(degrees: 0),
                        clockwise: false)
            
            if isClosedShape {
                path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY + cornerRadius))
                path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
                path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
                path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + cornerRadius))
            }
        }
    }
}

