//
//  OptionItemWithCheckmarkView.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import SwiftUI

struct OptionItemWithCheckmarkView: View {
    var title: String
    var subtitle: String
    var showDivider: Bool
    var isChecked: Bool
    var tapAction: () -> Void
    var body: some View {
        VStack(alignment: .leading) {
            Spacer().frame(height: 12)
            HStack(spacing: 12) {
                VStack(spacing: 0) {
                    CustomText(name: title, textColor: Colors.blueWhite, font: Fonts.boldFont14,
                               maxWidth: true)
                    CustomText(name: subtitle, textColor: Colors.blueWhite, font: Fonts.regularFont14,
                               maxWidth: true)
                }
                
                if isChecked {
                    checkmark()
                }
            }
            .padding(.horizontal, 24)
            Spacer().frame(height: 12)
            if showDivider {
                CustomDivider(height: 1)
            }
        }
        .background(Colors.brown8DarkBlue)
        .onTapGesture {
            tapAction()
        }
    }
    
    @ViewBuilder
    private func checkmark() -> some View {
        Image("checkmark")
            .resizable()
            .scaledToFit()
            .frame(width: 20, height: 20)
            .foregroundColor(Colors.brown)
    }
}

struct OptionItemWithCheckmarkView_Previews: PreviewProvider {
    static var previews: some View {
        OptionItemWithCheckmarkView(title: "Title", subtitle: "this is a short subtitle", showDivider: true, isChecked: true) {
            print("tap handler")
        }
    }
}
