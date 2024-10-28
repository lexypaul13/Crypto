//
//  SuccessView.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import SwiftUI

struct KeyValueItem: Identifiable {
    let id = UUID()
    let key: String
    let value: String
}

extension KeyValueItem {
    static var testValues: [KeyValueItem] {
        [
            KeyValueItem(key: "Token", value: "TOMB"),
            KeyValueItem(key: "Amount", value: "120"),
            KeyValueItem(key: "USD", value: "$0.86"),
            KeyValueItem(key: "Date", value: "19 Jul 2023"),
            KeyValueItem(key: "Status", value: "Pending"),
            KeyValueItem(key: "Recipient Address", value: "0x000...000"),
            KeyValueItem(key: "Status", value: "Pending"),
        ]
    }
}

struct SuccessView: View {
    @EnvironmentObject var data: CryptoAppData
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var info: [KeyValueItem] = KeyValueItem.testValues
    var body: some View {
        
        VStack {
            Spacer().frame(height: 20)
            VStack{
                ScrollView {
                    Image("sucess")
                    CustomText(name: data.strings.sendSuccessfully, alignment: .center, font: Fonts.boldFont16)
                    ForEach(info) { item in
                        VStack(spacing: 16) {
                            HStack {
                                CustomText(name: item.key, textColor: Colors.blue70White70, font: Fonts.regularFont14)
                                CustomText(name: item.value, alignment: .trailing, font: Fonts.regularFont14, maxWidth: true)
                            }
                            CustomDivider(height: 1)
                        }
                    }
                }
                Spacer()
                NavigationLink(destination: HistoryView(viewModel: data.transactionsViewModel)) {
                    PrimaryButtonText(text: data.strings.viewHistory)
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
        .padding(.horizontal, 24)
        .padding(.bottom, 32)
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
                ToolbarContentView(title: data.strings.send, subTitle: "FANTOM OPERA")
            }
        }
    }
    
}

struct SuccessView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SuccessView()
                .environmentObject(CryptoAppData())
        }
    }
}
