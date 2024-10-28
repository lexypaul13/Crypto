//
//  CustomTextField.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import SwiftUI

struct CustomTextField: View {
    @Binding var text: String
    var leadingImageName: String?
    var leadingImageColor: Color = .accentColor
    var trailingImageName: String?
    var trailingString: String?
    var trailingImageColor: Color = .accentColor
    var placeholderText: String = ""
    var placeholderTextColor: Color = Colors.blue70White
    var trailingImageAction: (() -> Void)?
    var isSecureEntry: Bool = false
    var isMultiLineEntry: Bool = false
    @State private var showSecureText: Bool = false
    @FocusState private var textEditorFocus: Bool
    var body: some View {
        HStack(alignment: isMultiLineEntry ? .top : .center, spacing: 12) {
            if let leadingImageName = leadingImageName {
                Image(leadingImageName)
                    .foregroundColor(leadingImageColor)
            }
            if isMultiLineEntry {
                textEditor()
            }else {
                ZStack {
                    if isSecureEntry {
                        secureField()
                    }
                    textField()
                }
            }
            if let trailingImageName = trailingImageName {
                Image(trailingImageName)
                    .foregroundColor(trailingImageColor)
                    .onTapGesture {
                        trailingImageAction?()
                    }
            }
            if let trailingString = trailingString {
                CustomText(name: trailingString, textColor: Colors.blueWhite, font: Fonts.regularFont14, maxWidth: false)
            }
            if isSecureEntry {
                Button {
                    showSecureText.toggle()
                }label: {
                    Image(systemName: showSecureText ? "eye" : "eye.slash")
                        .foregroundColor(Colors.blue70White70.opacity(0.8))
                }
            }
        }
        .padding(12)
        .background(Colors.brown20Brown5)
        .cornerRadius(12)
        .frame(maxWidth: .infinity)
    }
    
    @ViewBuilder
    private func textEditor() -> some View {
        TextEditor(text: $text)
            .font(Fonts.regularFont14)
            .foregroundColor(Colors.blueWhite)
            .frame(height: 77.0)
            .focused($textEditorFocus)
            .scrollContentBackground(.hidden)
            .background(.clear)
            .padding(.leading, -2.0)
            .padding(.top, -4.0)
            .overlay(
                VStack {
                    Text(placeholderText)
                        .foregroundColor(placeholderTextColor)
                        .font(Fonts.regularFont14)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .multilineTextAlignment(.leading)
                        .padding(.top, 4.0)
                        .onTapGesture {
                            textEditorFocus = true
                        }
                    Spacer()
                }
                    .opacity(text.isEmpty ? 1.0 : 0.0)
            )
    }
    
    @ViewBuilder
    private func secureField() -> some View {
        SecureField(
            "",
            text: $text,
            prompt: Text(placeholderText).foregroundColor(placeholderTextColor))
        .font(Fonts.regularFont14)
        .foregroundColor(Colors.blueWhite)
        .focused($textEditorFocus)
        .frame(height: 24)
        .opacity(isSecureEntry && !showSecureText ? 1.0 : 0.0)
    }
    
    @ViewBuilder
    private func textField() -> some View {
        TextField(
            "",
            text: $text,
            prompt: Text(placeholderText).foregroundColor(placeholderTextColor))
        .font(Fonts.regularFont14)
        .foregroundColor(Colors.blueWhite)
        .keyboardType(.emailAddress)
        .frame(height: 24)
        .opacity(isSecureEntry && !showSecureText ? 0.0 : 1.0)
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(text: .constant("TextField"))
    }
}
