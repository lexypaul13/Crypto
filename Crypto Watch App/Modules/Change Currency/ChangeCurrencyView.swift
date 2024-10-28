//
//  ChangeCurrencyView.swift
//  Crypto Watch App
//
//  Created by Virtual Gravity.
//

import SwiftUI

struct ChangeCurrencyView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var array1 = ["U.S Dollar", "EURO", "Indian Rupee", "Philippine peso"]
    var array2 = ["USD", "EUR", "INR", "PESO"]
    var array3 = ["dollarsign.circle.fill","eurosign.circle.fill" , "indianrupeesign.circle.fill" , "pesetasign.circle.fill"]
    @State private var counter = 0
    @StateObject var globalData: GlobalData
    var body: some View {
        ScrollView {
            VStack {
                ForEach(Array(zip(array1, array2).enumerated()), id: \.0) { (index,arg1) in
                    let (item1, item2) = arg1
                    Button {
                        globalData.watchSelecteCurrency = item2
                    } label: {
                        AddTokenSelectionView(imageName: array3[index], tokenName: item1, symbol: item2, systemImage: true, isItemSelected: globalData.watchSelecteCurrency == item2)
                    }
                }
                .navigationTitle("Base Currency")
            }
        }
    }
}

struct ChangeCurrencyView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeCurrencyView(globalData: GlobalData())
    }
}
