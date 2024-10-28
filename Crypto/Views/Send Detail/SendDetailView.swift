//
//  SendDetailView.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import SwiftUI

struct SendDetailView: View {
    @State var receipentName: String = ""
    @State var contactName: String = "Mark Manson"
    @State var address: String = "0x000...000"
    @State var tokenContact: TokenContact?
    @State var amount: String = "120"
    var percentageArray = ["10", "25", "50", "100"]
    @EnvironmentObject var data: CryptoAppData
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.colorScheme) var colorScheme
    @State private var showTokenContactView = false
    @State private var sheetOffset: CGFloat = 590.0
    @State private var isSaveReceipentChecked: Bool = true
    var body: some View {
        ZStack {
            VStack {
                Spacer().frame(height: 32)
                VStack(spacing: 0) {
                Image("btc")
                    Spacer().frame(height: 16)
                    CustomText(name: data.strings.availableBalance, textColor: Colors.blueWhite, alignment: .center, font: Fonts.mediumFont14)
                    
                    HStack (spacing: 0) {
                        CustomText(name: "120,3567", textColor: Colors.blueBrown, alignment: .trailing, font: Fonts.boldFont26, maxWidth: false, setGradient: colorScheme == .dark)
                        CustomText(name: "TOMB", textColor: Colors.blueBrown, alignment: .leading, font: Fonts.semiBoldFont14, maxWidth: false, setGradient: colorScheme == .dark)
                    }
                    .overlay(
                        GeometryReader { geometry in
                            Color.clear
                                .onAppear() {
                                    DispatchQueue.main.asyncAfter(deadline: .now()+0.2) {
                                        let y = geometry.frame(in: CoordinateSpace.global).origin.y
                                        
                                        sheetOffset = UIScreen.main.bounds.height - y - 36.0
                                    }
                                }
                        }
                    )
                    CustomText(name: "$230,977.75", textColor: Colors.blueWhite, alignment: .center, font: Fonts.regularFont14, maxWidth: false)
                    
                }
                Spacer().frame(height: 24)
                VStack{
                    ScrollView {
                        VStack() {
                            VStack(spacing: 24) {
                                CustomTextFieldWithTitle(text: $address, trailingImageName: "personAndScan", title: data.strings.recipientAddress) {
                                    showTokenContactView.toggle()
                                }
                            }
                            VStack(spacing: 0) {
                                CustomTextFieldWithTitle(text: $amount, leadingImageName: "wallet", trailingString: "TOMB", title: data.strings.amount)
                                CustomText(name: "≈$0.83", textColor: Colors.blue70White70, font: Fonts.regularFont12)
                            }
                            Spacer().frame(height: 16)
                            HStack(spacing: 14) {
                                CheckmarkView(isChecked: $isSaveReceipentChecked)
                                CustomText(name: data.strings.saveRecipient, textColor: Colors.blueWhite, font: Fonts.mediumFont14)
                            }
                            CustomTextField(text: $receipentName, placeholderText: data.strings.recipientName)
                        }
                    }
                    .scrollIndicators(.hidden)
                    .frame(minHeight: 160.0)
                    Spacer()
                    NavigationLink(destination: SuccessView()) {
                        PrimaryButtonText(text: data.strings.send)
                    }
                    .frame(height: 48)
                }
                .padding(24)
                .background(Colors.brown8DarkBlue)
                .cornerRadius(36)
                .overlay(
                    RoundedRectangle(cornerRadius: 36)
                        .stroke(Colors.brown25Blue, lineWidth: 1)
                )
            }
            .background(
                BackgroundGradientView()
            )
            .if(showTokenContactView) { content in
                content
                    .offset(y: 58.0)
            }
            
            if showTokenContactView {
                BackgroundGradientView()
                    .blur(radius: 20)
                    .opacity(0.92)
            }
        }
        .padding(.horizontal, 24)
        .padding(.bottom, 32)
        .navigationBarBackButtonHidden()
        .background(
            BackgroundGradientView()
        )
        .navigationBarTitleDisplayMode(.inline)
        .scrollViewTransparentNavigation()
        .navigationBarItems(
            leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image("back")
                    .padding(.leading, 12)
                    .if(showTokenContactView) { content in
                        content
                            .blur(radius: 2.0)
                            .opacity(0.55)
                    }
            }
        )
        .toolbar {
            ToolbarItem(placement: .principal) {
                ToolbarContentView(title: data.strings.send, subTitle: "FANTOM OPERA")
                    .if(showTokenContactView) { content in
                        content
                            .blur(radius: 2.0)
                            .opacity(0.55)
                    }
            }
        }
        .sheet(isPresented: $showTokenContactView) {
            TokenSelectContactView(token: $tokenContact, address: $address)
                .presentationDetents([.height(sheetOffset)])
                .presentationDragIndicator(.visible)
                .presentationCornerRadius(36.0)
                .presentationBackground(.clear)
        }
    }
}

struct SendDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SendDetailView()
                .environmentObject(CryptoAppData())
        }
    }
}
