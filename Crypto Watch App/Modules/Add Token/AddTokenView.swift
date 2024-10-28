//
//  AddTokenView.swift
//  Crypto Watch App
//
//  Created by Virtual Gravity.
//

import SwiftUI

struct AddTokenViews: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var array1 = ["lif3", "Bitcoin", "Ethereum", "Tomb"]
    var array2 = ["lif3", "BTC", "ETH", "tomb"]
    var array3 = ["lif3", "bitcoin","ethereum" , "tomb"]
    var body: some View {
        ScrollView {
            VStack {
                ForEach(Array(zip(array1, array2).enumerated()), id: \.0) { (index,arg1) in
                    let (item1, item2) = arg1
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        AddTokenSelectionView(imageName: array3[index], tokenName: item1, symbol: item2)
                    }
                }
                .navigationTitle("Add Crypto")
            }
        }
    }
}

struct AddTokenViews_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddTokenViews()
        }
        
    }
}

struct AddTokenSelectionView: View {
    let imageName: String
    let tokenName: String
    var symbol: String? = nil
    var systemImage: Bool = false
    var isItemSelected: Bool = false
    var body: some View {
        HStack {
            if systemImage {
                Image(systemName: imageName)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(Colors.brown)
            } else {
                Image(imageName)
                    .resizable()
                    .frame(width: 40, height: 40)
            }
            VStack(spacing: -4) {
                CustomText(name: tokenName, textColor: Colors.whiteDarkBlue, alignment: .leading, font: Fonts.mediumFont16)
                CustomText(name: symbol == nil ? tokenName : (symbol ?? ""), textColor: Colors.whiteDarkBlue, font: Fonts.regularFont16)
            }
            if isItemSelected { Image(systemName: "checkmark").foregroundColor(Colors.brown) }
        }
    }
}
