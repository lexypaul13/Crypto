//
//  ContentView.swift
//  Crypto Watch App
//
//  Created by Virtual Gravity.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var showNetworks = false
    @State private var showChangeCurrencyView = false
    @State private var widgetTapped: Bool = false
    
    @State private var array1 = ["BTC", "ETH", "LTC", "XRP","BAKE"]
    @State private var array2 = ["26362.87", "221.647", "1670.46", "82.3452", "148.738"]
    @State private var array3 = [0.97, -1.09, 21.76, -1.46, 148.715]
    @StateObject private var globalData = GlobalData()
    var body: some View {
        
        NavigationView {
            VStack {
                List {
                    Button {
                        showChangeCurrencyView = true
                    } label: {
                        VStack(spacing: -8) {
                            CustomText(name: "Base currency", textColor: Colors.brown, font: Fonts.mediumFont16)
                            CustomText(name: globalData.watchSelecteCurrency, textColor: Colors.whiteDarkBlue, font: Fonts.mediumFont16)
                        }
                        .padding(.vertical, 4)
                        
                    }
                    .background(NavigationLink("", destination: ChangeCurrencyView(globalData: globalData), isActive: $showChangeCurrencyView).hidden())
                    
                    ForEach(Array(zip(array1, array2).enumerated()), id: \.0) { (index,arg1) in
                        let (item1, item2) = arg1
                        NavigationLink(destination: TokenDetailView(tokenName: item1, percentage: array3[index], currentValue: item2)) {
                            VStack(spacing: -8) {
                                HStack {
                                    CustomText(name: "\(item1)/\(globalData.watchSelecteCurrency)", textColor: Colors.whiteDarkBlue, font: Fonts.boldFont16)
                                    CustomText(name: "\(array3[index])%", textColor: Colors.whiteDarkBlue, alignment: .trailing, font: Fonts.mediumFont16)
                                }
                                CustomText(name: item2, textColor: array3[index] < 0 ? Colors.red : Colors.green, font: Fonts.mediumFont16)
                                    .padding(.top, 4.0)
                            }
                            .padding(.vertical, 4)
                            
                        }
                    }
                    .onDelete(perform: deleteTodo)
                    PrimaryButtonText(text: "Add Crypto")
                        .frame(height: 46)
                        .padding(.top, 8)
                        .onTapGesture {
                            showNetworks = true
                        }
                        .listRowInsets(EdgeInsets()) // Set the rowInsets to remove padding
                        .listRowBackground(Color.clear) // Set the background color for each row
                        .background(NavigationLink("", destination: AddTokenViews(), isActive: $showNetworks).hidden())
                        .background(NavigationLink("", destination: AddTokenViews(), isActive: $widgetTapped).hidden())
                }
            }
            .onAppear {
                checkWidgetInteraction()
            }
            .navigationTitle("Crypto app")
        }
    }
    
    private func deleteTodo(at offsets: IndexSet) {
        array1.remove(atOffsets: offsets)
        array2.remove(atOffsets: offsets)
        array3.remove(atOffsets: offsets)
    }
    
    private func checkWidgetInteraction() {
        let sharedDefaults = UserDefaults(suiteName: "group.com.VirtualGravity.Crypto.watchkitapp")
        widgetTapped = sharedDefaults?.bool(forKey: "widgetTapped") ?? false
        // Optional: Reset the widgetTapped value after reading it, if needed.
        sharedDefaults?.removeObject(forKey: "widgetTapped")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
