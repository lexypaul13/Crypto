//
//  SelectDarkModeView.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import SwiftUI

struct SelectDarkModeView: View {
    @EnvironmentObject var data: CryptoAppData
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject private var themeManager = SystemThemeManager()
    
    var body: some View {
        VStack {
            ScrollView() {
                VStack(spacing: 0.0) {
                    ForEach(Array(SystemTheme.allCases.enumerated()), id:\.0) { (index, item) in
                        OptionItemWithCheckmarkView(
                            title: item.title,
                            subtitle: item.description,
                            showDivider: shouldShowDivider(at: index),
                            isChecked: themeManager.currentSystemTheme() == item) {
                                themeManager.updateSystemTheme(to: item)
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
                ToolbarContentView(title: data.strings.appearanceSetting)
            }
        }
    }
    
    private func shouldShowDivider(at index: Int) -> Bool {
        index != (SystemTheme.allCases.count - 1)
    }
}

struct SelectDarkModeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SelectDarkModeView()
                .environmentObject(CryptoAppData())
        }
    }
}
