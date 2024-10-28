//
//  MultiChainLargeWidgetCardView.swift
//  CryptoWidgetExtension
//
//  Created by Virtual Gravity.
//

import SwiftUI
import WidgetKit

struct MultiChainLargeWidgetCardView: View {
    var vm: ChainViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 4.0) {
                vm.image
                    .resizable()
                    .frame(width: 36, height: 36)
                    .padding(.trailing, 8.0)
                VStack(spacing: 0) {
                    CustomText(name: vm.name, textColor: Colors.blueWhite, alignment: .leading, font: Fonts.mediumFont14)
                    CustomText(name: vm.code, textColor: Colors.blueWhite, alignment: .leading, font: Fonts.mediumFont12, maxWidth: true)
                }
                
                GraphView()
                    .frame(width: 60.0, height: 20.0)
                
                VStack(spacing: 0) {
                    CustomText(name: vm.dollarPrice, textColor: Colors.blueWhite, alignment: .trailing, font: Fonts.regularFont14)
                    CustomText(name: vm.changePercent, textColor: vm.changeTint, alignment: .trailing, font: Fonts.mediumFont14)
                }
                .padding(0)
            }
        }
        .padding(.vertical, 8.0)
        .cornerRadius(20)
    }
}

struct MultiChainLargeWidgetCardView_Previews: PreviewProvider {
    static var previews: some View {
        MultiChainLargeWidgetView(
            entry: MultiChainEntry(
                        date: Date(),
                        chains: Chain.snapshotChainList,
                        configuration: CryptoMultiChainWidgetConfigurationIntent())
        )
        .environmentObject(WidgetData())
        .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
