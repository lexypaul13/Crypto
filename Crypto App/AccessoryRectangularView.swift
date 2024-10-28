//
//  AccessoryRectangularView.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import SwiftUI
import WidgetKit

struct AccessoryRectangularView: View {
    @Environment(\.widgetFamily) private var family
//    var entry: Provider.Entry
    @State private var isTapped = false
//    @AppStorage("widgetTapped") var widgetTapped: Bool = false
    @State private var widgetTapped: Bool = false
    @StateObject var globalData = GlobalData()
    var body: some View {
        switch family {
        case .accessoryRectangular:
            HStack(alignment: .top) {
                    VStack(spacing: 4) {
                        Text("ETH/\(getCurrency())").font(.headline)
                        Text("29 511.65").font(.subheadline)
                    }
                    let randomDataPoints = (0..<30).map { _ in CGFloat.random(in: 7...15) }

                    VStack(spacing: 0) {
                        HStack {
                            Text("0.71%")
                                .font(.footnote)
                            Image("upArrow")
                                .renderingMode(.template) // Set the rendering mode to template
                                .resizable()
                                .frame(width: 10, height: 10)
                                .foregroundColor(Colors.green)
                       
                        }
                        LineGraphView(dataPoints: randomDataPoints, graphForegroundColor: Colors.brown, maxValue: 15)
                    }
                }
            .padding(.vertical, 8)
            .background(Colors.brown8Brown5)
        default:
            Text("Time: 10:09 am")
              
        }
        
    }
    
    private func getCurrency() -> String {
        return UserDefaults(suiteName: "group.com.virtual-gravity.CryptoApp")?.string(forKey: "watchSelecteCurrency") ?? "INR"
    }
    
    private func checkWidgetInteraction() {
        let sharedDefaults = UserDefaults(suiteName: "group.com.VirtualGravity.Crypto.watchkitapp")
        widgetTapped = sharedDefaults?.bool(forKey: "widgetTapped") ?? false
        // Optional: Reset the widgetTapped value after reading it, if needed.
        sharedDefaults?.removeObject(forKey: "widgetTapped")
    }
    
    private func saveWidgetInteraction() {
          let sharedDefaults = UserDefaults(suiteName: "group.com.VirtualGravity.Crypto.watchkitapp")
          sharedDefaults?.set(true, forKey: "widgetTapped")
        print("saveWidgetInteraction")
      }

}

struct AccessoryRectangularView_Previews: PreviewProvider {
  static var previews: some View {
    AccessoryRectangularView()
      .previewContext(WidgetPreviewContext(family: .accessoryRectangular))
  }
}


struct LineGraphView: View {
    let dataPoints: [CGFloat] // An array of data points for each component
    let graphForegroundColor: Color // An array of colors for each component
    let maxValue: CGFloat // The maximum value for scaling the graph

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Line graph
                Path { path in
                    let stepX = geometry.size.width / CGFloat(dataPoints.count - 1)
                    let stepY = geometry.size.height / maxValue

                    for (index, dataPoint) in dataPoints.enumerated() {
                        let x = stepX * CGFloat(index)
                        let y = geometry.size.height - stepY * dataPoint

                        if index == 0 {
                            path.move(to: CGPoint(x: x, y: y))
                        } else {
                            path.addLine(to: CGPoint(x: x, y: y))
                        }
                    }
                }
                .strokedPath(StrokeStyle(lineWidth: 2, lineCap: .round))
                .foregroundColor(graphForegroundColor)
            }
        }
        .padding()
    }
}
