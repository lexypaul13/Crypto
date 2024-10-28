//
//  SendView.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import SwiftUI

struct SendView: View {
    @EnvironmentObject var data: CryptoAppData
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var showSettings = false
    var body: some View {
        ScrollView {
            VStack {
                Spacer()
                    .frame(height: 12)
                HeaderAmountView(title: data.strings.availableBalance, availableBalance: "$ 123,456.789", todayChangedAmount: "")
                Spacer()
                    .frame(height: 40)
                HomeSection(sectionName: data.strings.chooseToken, imageType: .none)
                VStack(spacing: 10) {
                    
                    ForEach(data.tokenList.map{ ChainViewModel(chain: $0)}) { chain in
                        NavigationLink(destination: SendDetailView()) {
                            HomeThinnerCardView(vm: chain)
                        }
                    }
                }
            }
            .padding(.horizontal, 20)
        }
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
            },
            trailing:  Image("plus")
                .padding(.leading, 12)
        )
        .sheet(isPresented: $showSettings) {
            HomeView()
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                ToolbarContentView(title: data.strings.send, subTitle: "FANTOM OPERA")
            }
        }
        .scrollViewTransparentNavigation()
    }
}

struct SendView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            SendView()
                .environmentObject(CryptoAppData())
        }
    }
}
