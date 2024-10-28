//
//  GraphView.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import SwiftUI
import Charts
import WidgetKit

struct GraphView: View {
    
    let currentDate = Date()
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        return formatter
    }()
    
    @State var sampleAnalytics: [GraphData] = sample_analytics
    @State var currentTab: String = "Day"
    @State var currentActiveItem: GraphData?
    @State var plotWidth: CGFloat = 0
    @State var selectedDuration = "1D"
    
#if os(iOS)
    @EnvironmentObject var data: CryptoAppData
#endif
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    // Replace this with the actual x-coordinate of your RuleMark
    @State private var ruleMarkX: CGFloat = 100
    
    var body: some View {
#if os(watchOS)
        animatedChart()
#else
        ScrollView {
            VStack {
                VStack() {
                    VStack(spacing: 0) {
                        Spacer().frame(height: 24)
                        Image("eth")
                        Spacer().frame(height: 16)
                        HStack (spacing: 0) {
                            CustomText(name: "120,3567", textColor: Colors.brown, alignment: .trailing, font: Fonts.boldFont26, maxWidth: false, setGradient: true)
                            CustomText(name: "ETH", textColor: Colors.brown, alignment: .leading, font: Fonts.semiBoldFont14, maxWidth: false, setGradient: true)
                        }
                        HStack {
                            CustomText(name: "$230,977.75", textColor: Colors.blueWhite, alignment: .center, font: Fonts.regularFont14, maxWidth: false)
                            CustomText(name: "+ 2.25%", textColor: Colors.green, alignment: .center, font: Fonts.boldFont14, maxWidth: false)
                        }
                    }
                    Spacer().frame(height: 16)
                    HStack(spacing: 12) {
                        NavigationLink {
                            SendDetailView()
                        } label: {
                            TextWithImage(todayChangedAmount: data.strings.send, todayChangedPercentage: "", textBackgroundColor: Colors.brown8Brown5, textForegroundColor: Colors.blueWhite, image: Image("send"), verticalPadding: 8, cornerRadius: 30)
                        }
                        NavigationLink {
                            ReceiveView()
                        } label: {
                            TextWithImage(todayChangedAmount: data.strings.receive, todayChangedPercentage: "", textBackgroundColor: Colors.brown8Brown5, textForegroundColor: Colors.blueWhite, image: Image("receive"), verticalPadding: 8, cornerRadius: 30)
                        }
                        NavigationLink {
                            SwapView()
                        } label: {
                            TextWithImage(todayChangedAmount: data.strings.swap, todayChangedPercentage: "", textBackgroundColor: Colors.brown8Brown5, textForegroundColor: Colors.blueWhite, image: Image("swap"), verticalPadding: 8, cornerRadius: 30)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    Spacer().frame(height: 24)
                    animatedChart()
                        .padding(.horizontal, -36)
                        .offset(y: 10) // move the chart up considering the height taken by annotation view
                    
                    HStack(spacing: 0) {
                        ForEach(["1D", "1W", "1M", "3M", "1Y", "3Y"], id: \.self) { item in
                            Button {
                                selectedDuration = item
                                currentTab = item
                            } label: {
                                if selectedDuration == item {
                                    CustomText(name: item, textColor: Colors.blueWhite, alignment: .center, font: Fonts.regularFont14, lineLimit: 1)
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 4)
                                        .background(Colors.brownBrown20)
                                        .cornerRadius(20)
                                        .frame(width: 64)
                                } else {
                                    CustomText(name: item, alignment: .center, font: Fonts.regularFont14, maxWidth: false)
                                }
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .padding(.trailing, -20)
                    .padding(.leading, -10)
                    Spacer().frame(height: 24)
                    VStack(spacing: 16) {
                        HomeSection(sectionName: data.strings.transactionHistory, imageType: .none)
                        VStack(spacing: 10) {
                            ForEach(data.transactionsViewModel.previousTransactionList.map { TransactionItemViewModel(transaction: $0)}) { transaction in
                                TransactionCardView(vm: transaction)
                            }
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding(.horizontal, 24)
            .navigationBarBackButtonHidden()
            .scrollViewTransparentNavigation()
            .navigationTitle("Ethereum")
            .onChange(of: currentTab) { newValue in
                sampleAnalytics = sample_analytics
                if newValue != "Day" {
                    for (index, _) in sampleAnalytics.enumerated() {
                        sampleAnalytics[index].value = .random(in: 1500...10000)
                    }
                }
                animateGraph(fromChange: true)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(
            leading: Button(action: {
                data.setSelectedChainCode(nil)
                presentationMode.wrappedValue.dismiss()
            }) {
                Image("back")
                    .padding(.leading, 12)
            },
            trailing: NavigationLink(destination: HomeView()) {
                Image("plus")
                    .padding(.leading, 12)
            }
        )
        .toolbar {
            ToolbarItem(placement: .principal) {
                ToolbarContentView(title: data.selectedChain?.name ?? "Ethereum")
            }
        }
        .background(
            BackgroundGradientView()
        )
        .scrollViewTransparentNavigation()
#endif
    }
    
    @ViewBuilder
    func animatedChart()-> some View {
        Chart{
            ForEach(sampleAnalytics) { item in
                LineMark(
                    x: .value("Hour", item.hour, unit: .hour),
                    y: .value("Value", item.animate  ? item.value : 0)
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
                    yStart: .value("Min.", item.animate  ? item.value : 0),
                    yEnd: .value("Max.", item.animate  ? (item.value - 10000  < 0 ? 0 :  item.value - 10000) : 0)
                )
                .foregroundStyle(
                    LinearGradient(
                        gradient: Gradient(colors: [    Colors.brown8LightBrown.opacity(0.8),     Colors.brown8LightBrown.opacity(0.7), Colors.brown8LightBrown.opacity(0.02)]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                RuleMark(y: .value("Values", currentActiveItem?.value ?? 0))
                    .lineStyle(.init(lineWidth: 2, miterLimit: 2, dash: [5], dashPhase: 5))
                    .foregroundStyle(Colors.brown8LightBrown)
                    .opacity(showRuleMark ? 1.0 : 0.0)
                RuleMark(x: .value("Hour", currentActiveItem?.hour ?? sampleAnalytics[sampleAnalytics.count/3].hour, unit: .hour))
                    .lineStyle(.init(lineWidth: 2, miterLimit: 2, dash: [5], dashPhase: 5))
                    .foregroundStyle(Colors.brown8LightBrown)
                    .opacity(showRuleMark ? 1.0 : 0.0)
                    .annotation(position: annotationPosition()) {
                        annotationView()
                    }
            }
            
            if let item = currentActiveItem {
                PointMark(
                    x: .value("Hour", item.hour, unit: .hour),
                    y: .value("Values", item.animate  ? item.value : 0)
                )
                .symbol {
                    Image("pin")
                        .resizable()
                        .frame(width: 18.0, height: 18.0)
                        .scaleEffect(2.0)
                }
            }
        }
        .chartXAxis(.hidden)
        .chartYAxis(.hidden)
        .chartOverlay(content: { proxy in
            GeometryReader { innerProxy in
                Rectangle()
                    .fill(.clear).contentShape(Rectangle())
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                let location = value.location // current location
                                ruleMarkX = location.x
                                if let date: Date = proxy.value(atX: location.x) {
                                    //Extracting hour
                                    let calendar = Calendar.current
                                    let hour = calendar.component(.hour, from: date)
                                    if let currentItem = sampleAnalytics.first(where: { item in
                                        calendar.component(.hour, from: item.hour) == hour
                                    }) {
                                        currentActiveItem = currentItem
                                        self.plotWidth = proxy.plotAreaSize.width
                                    }
                                }
                            }.onEnded { value in
                            }
                    )
            }
        })
        .frame(height: 180)
        .onAppear {
            animateGraph()
        }
    }
    
    @ViewBuilder
    private func annotationView() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            CustomText(name: "\("\(dateFormatter.string(from: currentActiveItem?.hour ?? Date()))".components(separatedBy: " ").first ?? "04/08/2023") \("\(dateFormatter.string(from: currentActiveItem?.hour ?? Date()))".components(separatedBy: " ").last ?? "06:00")", textColor: Colors.blue70White70, font: Fonts.regularFont12)
            CustomText(name: "$\(currentActiveItem?.value.stringFormat ?? "")", textColor: Colors.blueWhite, font: Fonts.mediumFont16)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 4)
        .background {
            RoundedRectangle(cornerRadius: 6, style: .continuous)
                .fill(Colors.brown8LightBrown.shadow(.drop(radius: 2)))
        }
        // move the annotation view down which was pushed up due to offset on chart view
        .offset(y: 36.0)
        .opacity(showRuleMark ? 1.0 : 0.0)
    }
    
    func annotationPosition() -> AnnotationPosition {
#if os(watchOS)
        let screenWidth = WKInterfaceDevice.current().screenBounds.size.width
#else
        let screenWidth = UIScreen.main.bounds.width
#endif
        
        // Threshold to determine leading/trailing (middle of the screen)
        let leadingThreshold = screenWidth / 2
        
        let trailingThresholdInPixel = screenWidth - ruleMarkX
        let leadingThresholdInPixel = ruleMarkX
        
        if trailingThresholdInPixel > 100 && leadingThresholdInPixel > 100 {
            // Both thresholds are greater than 50, do nothing
            return AnnotationPosition.top
        }
        
        if ruleMarkX < leadingThreshold {
            // RuleMark is closer to the leading edge (left side)
            return AnnotationPosition.topTrailing
            
        } else {
            // RuleMark is closer to the trailing edge (right side)
            return AnnotationPosition.topLeading
        }
    }
    
    private var showRuleMark: Bool {
        return currentActiveItem != nil
    }
    
    func animateGraph(fromChange: Bool = false) {
        for (index,_) in sampleAnalytics.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + (fromChange ? 0.03 : 0.05)) {
                withAnimation(fromChange ? .easeInOut(duration: 0.8) : .interactiveSpring(response: 0.8, dampingFraction: 0.8, blendDuration: 0.8)) {
                    sampleAnalytics[index].animate = true
                }
            }
        }
    }
}

struct GraphView_Previews: PreviewProvider {
    static var previews: some View {
#if os(iOS)
        NavigationView {
            GraphView().environmentObject(CryptoAppData())
        }
#else
        GraphView().previewContext(WidgetPreviewContext(family: .accessoryRectangular))
#endif
    }
}

// MARK: Extension To convert Double to string
extension Double {
    var stringFormat: String {
        return String(format: "%.1f", self ).replacingOccurrences(of: ".0", with: "")
    }
    
}
