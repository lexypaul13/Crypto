//
//  ToolbarContentView.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import SwiftUI

struct ToolbarContentView: View {
    var title: String
    var subTitle: String?
    var titleTrailingImage: Image?
    
    var body: some View {
        VStack(alignment: .center, spacing: 2) {
            Text(title)
                .font(Fonts.boldFont14)
                .foregroundColor(Colors.blueWhite)
                .toolbarContentTrailingImage(image: titleTrailingImage)
            
            if let subTitle = subTitle {
                HStack(spacing: 4.0) {
                    Circle()
                        .fill(Colors.brown)
                        .frame(width: 10, height: 10)
                    
                    Text(subTitle)
                        .font(Fonts.mediumFont10)
                        .foregroundColor(Colors.blueWhite.opacity(0.7))
                }
            }
        }
    }
}

struct ToolbarContentView_Previews: PreviewProvider {
    static var previews: some View {
        ToolbarContentView(title: "Send", subTitle: "Bitcoin")
    }
}

struct ToolbarContentTrailingImage: ViewModifier {
    @State var image: Image?
    func body(content: Content) -> some View {
        if let image = image {
            HStack(spacing: 0) {
                content
                image
                    .foregroundColor(Colors.brown)
                    .frame(width: 18, height: 18)
                    .padding(.all, 5)
                    .clipShape(Circle())
            }
        }else {
            content
        }
    }
}

extension View {
    func toolbarContentTrailingImage(image: Image?) -> some View {
        self.modifier(ToolbarContentTrailingImage(image: image))
    }
}
