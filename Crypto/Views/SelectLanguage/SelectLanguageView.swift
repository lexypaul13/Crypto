//
//  SelectLanguageView.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import SwiftUI

struct SelectLanguageView: View {
    @EnvironmentObject var data: CryptoAppData
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @AppStorage("selectedLanguage") private var selectedLanguage: String?
    
    var body: some View {
        VStack {
            ScrollView() {
                VStack(spacing: 0.0) {
                    ForEach(Array(SystemLanguage.allCases.enumerated()), id:\.0) { (index, item) in
                        OptionItemWithCheckmarkView(
                                title: item.title,
                                subtitle: item.localizedTitle,
                                showDivider: shouldShowDivider(at: index),
                                isChecked: selectedLanguage == item.lang) {
                            if selectedLanguage != item.lang {
                                selectedLanguage = item.lang
                                presentationMode.wrappedValue.dismiss()
                            }
                        }
                        .tag(item.rawValue)
                    }
                }
                .cornerRadius(36)
                .overlay(
                    RoundedRectangle(cornerRadius: 36)
                        .stroke(Colors.brown25Blue, lineWidth: 1)
                    )
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .scrollViewTransparentNavigation()
        .navigationBarBackButtonHidden()
        .background(
            BackgroundGradientView()
        )
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(
            leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image("back")
                    .padding(.leading, 12)
            }
        )
        .toolbar {
            ToolbarItem(placement: .principal) {
                ToolbarContentView(title: data.strings.languageSetting)
            }
        }
    }
    
    private func shouldShowDivider(at index: Int) -> Bool {
        index != (SystemLanguage.allCases.count - 1)
    }
}

struct SelectLanguageView_Previews: PreviewProvider {
    static var previews: some View {
        SelectLanguageView()
            .environmentObject(CryptoAppData())
    }
}
