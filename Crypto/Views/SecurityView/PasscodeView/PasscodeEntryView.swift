//
//  PasscodeEntryView.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import SwiftUI

struct PasscodeEntryView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var data: CryptoAppData
    @State private var passCodeString: String = ""
    @State private var repassCodeString: String = ""
    @State private var isRetyping: Bool = false
    @State private var isPasswordMismatch: Bool = false
    @State private var errorMessage: String = ""
    @State private var showError: Bool = false
    
    private let passcodeLength: Int = 6
    private let viewModel = SecurityViewModel()
    
    var body: some View {
        HStack(alignment: .center) {
            if !isRetyping {
                VStack {
                    CustomText(name: data.strings.enterNewPassword, textColor: Colors.blueWhite, alignment: .center, font: Fonts.mediumFont14)
                        .padding(.bottom, 8.0)
                    PasscodeView(passCodeString: $passCodeString, passcodeLength: passcodeLength, tintColor: Colors.brown)
                }
                .offset(x: isPasswordMismatch ? -10 : 0)
            }else {
                VStack {
                    CustomText(name: data.strings.reenterNewPassword, textColor: Colors.blueWhite, alignment: .center, font: Fonts.mediumFont14)
                        .padding(.bottom, 8.0)
                    PasscodeView(passCodeString: $repassCodeString, passcodeLength: passcodeLength, tintColor: Colors.brown)
                }
                .transition(.move(edge: .trailing))
            }
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
                ToolbarContentView(title: data.strings.setPasscode)
            }
        }
        .onChange(of: passCodeString) { newValue in
            isPasswordMismatch = false
            if newValue.count == passcodeLength {
                withAnimation {
                    isRetyping = true
                }
            }
        }
        .onChange(of: repassCodeString) { newValue in
            if newValue.count == passcodeLength {
                if(passCodeString == repassCodeString) {
                    UIApplication.shared.endEditing(true)
                    
                    if let passcodeData = passCodeString.data(using: .utf8) {
                        do {
                            try viewModel.savePasscode(data: passcodeData)
                            
                            presentationMode.wrappedValue.dismiss()
                        }catch {
                            errorMessage = "Could not save the passcode. Error \(error.localizedDescription)"
                            showError.toggle()
                        }
                        
                    }else {
                        errorMessage = "Error saving your passcode. Pleaase try again later"
                        showError.toggle()
                    }
                }else {
                    passCodeString = ""
                    repassCodeString = ""
                    withAnimation {
                        isRetyping = false
                    }
                    
                    withAnimation(.linear(duration: 0.1).repeatCount(8)) {
                        isPasswordMismatch = true
                    }
                    
                }
            }
        }
        .alert(errorMessage, isPresented: $showError) {
            Button("Dismiss", role: .cancel) {
                
            }
        }
    }
}

struct PasscodeEntryView_Previews: PreviewProvider {
    static var previews: some View {
        PasscodeEntryView()
            .environmentObject(CryptoAppData())
    }
}

extension Binding where Value == String {
    func max(_ limit: Int) -> Self {
        if self.wrappedValue.count > limit {
            DispatchQueue.main.async {
                self.wrappedValue = String(self.wrappedValue.dropLast())
            }
        }
        return self
    }
}
