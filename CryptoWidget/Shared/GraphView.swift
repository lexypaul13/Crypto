//
//  GraphView.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import SwiftUI
import Charts

struct GraphView: View {
    
    @State var sampleAnalytics: [GraphData] = sample_analytics
    
    var body: some View {
        
        Chart{
            ForEach(sampleAnalytics) { item in
                LineMark(
                    x: .value("Hour", item.hour, unit: .hour),
                    y: .value("Value", item.value)
                )
                .foregroundStyle(
                    LinearGradient(
                        gradient: Gradient(colors: [Colors.brown, Colors.brownWhite]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                AreaMark(
                    x: .value("Hour", item.hour, unit: .hour),
                    y: .value("Value", item.value)
                )
                .foregroundStyle(
                    LinearGradient(
                        gradient: Gradient(colors: [Colors.brown8LightBrown.opacity(0.8),     Colors.brown8LightBrown.opacity(0.7), Colors.brown8LightBrown.opacity(0.02)]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            }
        }
        .chartXAxis(.hidden)
        .chartYAxis(.hidden)
        .padding(.horizontal, -12.0)
    }
}
