//
//  CustomDivider.swift
//  Crypto
//
//  Created by Virtual Gravity
//

import SwiftUI

struct CustomDivider: View {
    var height: CGFloat = 1
    var color: Color = Colors.brown25Blue70
    var body: some View {
        Rectangle()
             .fill(color)
             .frame(height: height)
             .background( color)
    }
}

struct Divider_Previews: PreviewProvider {
    static var previews: some View {
        CustomDivider()
    }
}
 
