//
//  Site.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import Foundation

struct GraphData: Identifiable {
    var id = UUID().uuidString
    var hour: Date
    var value: Double
    var animate: Bool = false
}


var sample_analytics: [GraphData] = [
    GraphData(hour: Date().updateHour(value: 1), value: 1800),
    GraphData(hour: Date().updateHour(value: 2), value: 1925),
    GraphData(hour: Date().updateHour(value: 3), value: 2100),
    GraphData(hour: Date().updateHour(value: 4), value: 2488),
    GraphData(hour: Date().updateHour(value: 5), value: 2288),
    GraphData(hour: Date().updateHour(value: 6), value: 1988),
    GraphData(hour: Date().updateHour(value: 7), value: 2488),
    GraphData(hour: Date().updateHour(value: 8), value: 3100),
    GraphData (hour: Date().updateHour(value: 9), value: 4225),
    GraphData (hour: Date().updateHour(value: 10), value: 6200),
    GraphData (hour: Date().updateHour(value: 11), value: 4688),
    GraphData (hour: Date().updateHour(value: 12), value: 2988),
    GraphData (hour: Date().updateHour(value: 13), value: 5372),
    GraphData (hour: Date().updateHour(value: 14), value: 6323),
    GraphData (hour: Date().updateHour(value: 15), value: 9932),
    GraphData (hour: Date().updateHour(value: 16), value: 7988),
    GraphData (hour: Date().updateHour(value: 17), value: 7866),
    GraphData (hour: Date().updateHour(value: 18), value: 5989),
    GraphData(hour: Date().updateHour(value: 19), value: 3756),
    GraphData(hour: Date().updateHour(value: 20), value: 4689),
    GraphData(hour: Date().updateHour(value: 21), value: 4856),
    GraphData(hour: Date().updateHour(value: 22), value: 6289),
]
