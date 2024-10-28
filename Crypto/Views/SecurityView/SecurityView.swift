//
//  SecurityView.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import SwiftUI

struct SecurityView: View {
    @EnvironmentObject var data: CryptoAppData
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var isPasscodeActive: Bool = true
    @State private var showPasscodeEntry: Bool = false
    
    private let viewModel = SecurityViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                HStack(alignment: .center) {
                    
                    Image(systemName: "touchid")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(Colors.brown)
                    
                    Toggle(isOn: $isPasscodeActive) {
                        CustomText(name: "Passcode / Touch ID", textColor: Colors.blueWhite, alignment: .leading, font: Fonts.mediumFont14, maxWidth: false)
                    }
                    .tint(Colors.brown)
                }
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 10)
            .background(Colors.brown8Brown5)
            .cornerRadius(20)
        }
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
                ToolbarContentView(title: data.strings.securitySetting)
                
            }
        }
        .onChange(of: isPasscodeActive) { newValue in
            if newValue {
                showPasscodeEntry.toggle()
            }else {
                do {
                    try viewModel.deletePasscode()
                }catch{
                    print(error)
                }
            }
        }
        .navigationDestination(isPresented: $showPasscodeEntry, destination: {
            PasscodeEntryView()
        })
        .onAppear() {
            
            guard let _ = viewModel.getPasscode() else {
                isPasscodeActive = false
                return
            }
        }
    }
}

struct SecurityView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SecurityView()
                .environmentObject(CryptoAppData())
        }
    }
}
