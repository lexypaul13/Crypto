//
//  HomeSection.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import SwiftUI

struct HomeSection: View {
    enum ImageType {
        case image(image: Image)
        case text(_ text: String = LocalizableString().all)
        case none
    }
    
    let sectionName: String
    var imageType: ImageType = .text(LocalizableString().all)
    var imageTypeAction: (() -> Void)? = nil
    
    var body: some View {
        HStack {
            CustomText(name: sectionName, textColor: Colors.blueWhite, alignment: .leading, font: Fonts.boldFont16)
            
            switch imageType {
            case .image(let image):
                image
                    .onTapGesture {
                        imageTypeAction?()
                    }
            case .text(let text):
                CustomText(
                    name: text,
                    textColor: Colors.brown,
                    alignment: .trailing,
                    font: Fonts.regularFont12,
                    maxWidth: true)
                
                    .onTapGesture {
                        imageTypeAction?()
                    }
            case .none:
                EmptyView()
            }
            
        }.frame(maxWidth: .infinity)
    }
}

struct HomeSection_Previews: PreviewProvider {
    static var previews: some View {
        HomeSection(sectionName: "Tokens", imageType: .text("Hide"))
        HomeSection(sectionName: "Tokens", imageType: .image(image: Image("search")))
        HomeSection(sectionName: "Tokens")
    }
}
