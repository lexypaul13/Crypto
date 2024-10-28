//
//  CheckMarkView.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import SwiftUI

struct CheckmarkView: View {
    @Binding var isChecked: Bool
    var body: some View {
        Button {
            isChecked.toggle()
        } label: {
            if isChecked {
                Image("tickmark")
                    .resizable()
                    .frame(width: 20, height: 20)
            }else {
                Rectangle()
                    .fill(.clear)
                    .padding()
                    .frame(width: 20, height: 20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4.0)
                            .stroke(Colors.brown, lineWidth: 2.0)
                            .padding(.leading, 2.0)
                    )
            }
        }
    }
}

struct CheckMarkView_Previews: PreviewProvider {
    static var previews: some View {
        CheckmarkView(isChecked: .constant(true))
    }
}
