//
//  TabViewItem.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import SwiftUI

struct TabViewItem: View {
    var type: TabViewItemType
    var selectedTab: TabViewItemType
    var title: String
    var pressedTab: (() -> ())?
    @State private var isRotating = 0.0
    var body: some View {
        Button {
            pressedTab?()
        } label: {
            VStack(spacing: 4) {
                if type == selectedTab {
                    type.selectedImage.foregroundColor(Colors.brown)
                        .scaleEffect(isRotating == 360 ? 3 : 1.0)
                        .rotationEffect(.degrees(isRotating))
                } else {
                    type.image.foregroundColor(Colors.blueWhite)
                }
                Text(title).foregroundColor(type == selectedTab ? Colors.brown : Colors.blueWhite)
                    .if(type == selectedTab, content: { content in
                        content
                            .scaleEffect(isRotating == 360 ? 2 : 1.0)
                    })
            }
        }
        .onChange(of: selectedTab) { newValue in
            self.isRotating = 360.0
            withAnimation(.linear(duration: 0.5)) {
                self.isRotating = 0.0
            }
        }
    }
}

struct TabViewItem_Previews: PreviewProvider {
    static var previews: some View {
        TabViewItem(type: .home, selectedTab: .home, title: "Home")
    }
}
