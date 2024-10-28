//
//  PasscodeView.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import SwiftUI

struct PasscodeView: View {
    @FocusState private var isFocused: Bool
    @Binding var passCodeString: String
    @State var passcodeLength: Int = 6
    
    let tintColor: Color?
    
    var body: some View {
        ZStack {
            TextField("", text: $passCodeString.max(passcodeLength))
                .background(.white)
                .foregroundColor(.white)
                .opacity(0.0)
                .focused($isFocused)
                .keyboardType(.numberPad)
            
            HStack {
                ForEach(0..<passcodeLength, id: \.self) { index in
                    if(passCodeString.count <= index) {
                        Circle()
                            .stroke(tintColor ?? .accentColor, lineWidth: 2.0)
                            .frame(width: 20.0, height: 20.0)
                    }else {
                        Circle()
                            .fill(tintColor ?? .accentColor)
                            .frame(width: 20.0, height: 20.0)
                    }
                }
            }
        }
        .padding(4.0)
        .onAppear() {
            isFocused = true
        }
    }
}

struct PasscodeView_Previews: PreviewProvider {
    static var previews: some View {
        PasscodeView(passCodeString: .constant(""), tintColor: .red)
    }
}
