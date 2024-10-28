//
//  ContactDetail.swift
//  Crypto
//
//  Created by Amrit Duwal on 7/13/23.
//

import SwiftUI
import Charts

struct PetRecord: Codable, Hashable {
    let weight: Double
    let height: Double?
    let date: Date?
    let documentId: String?
    var location: Double = 0
    var locationy: Double = 0
    var animate = false
}

let darkerGreyColor   = #colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1) //666666

var geometry:  GeometryProxy? = nil

struct ContactDetail: View {
    @State var currentTab: String = "7 Days"
    @State var perRecords = [
        PetRecord(weight: 3, height: 23, date:  Date(), documentId: "1"),
        PetRecord(weight: 33, height: 4, date:  Calendar.current.date(byAdding: .second, value: 1, to: Date()), documentId: "1"),
        PetRecord(weight: 11, height: 10, date: Calendar.current.date(byAdding: .second, value: 1, to: Date()), documentId: "2"),
        PetRecord(weight: 12, height: 12, date: Calendar.current.date(byAdding: .second, value: 3, to: Date()), documentId: "4"),
        PetRecord(weight: 15, height: 11, date: Calendar.current.date(byAdding: .second, value: 4, to: Date()), documentId: "5"),
//        PetRecord(weight: 17, height: 13, date: Calendar.current.date(byAdding: .hour, value: 5, to: Date()), documentId: "6"),
//        PetRecord(weight: 20, height: 12, date: Calendar.current.date(byAdding: .hour, value: 6, to: Date()), documentId: "7"),
//        PetRecord(weight: 33, height: 16, date:  Calendar.current.date(byAdding: .hour, value: 7, to: Date()), documentId: "8"),
//        PetRecord(weight: 11, height: 18, date: Calendar.current.date(byAdding: .hour, value: 9, to: Date()), documentId: "9"),
//        PetRecord(weight: 12, height: 20, date: Calendar.current.date(byAdding: .hour, value: 10, to: Date()), documentId: "10"),
//        PetRecord(weight: 15, height: 21, date: Calendar.current.date(byAdding: .hour, value: 11, to: Date()), documentId: "11"),
//        PetRecord(weight: 17, height: 23, date: Calendar.current.date(byAdding: .hour, value: 12, to: Date()), documentId: "12"),
//        PetRecord(weight: 20, height: 24, date: Calendar.current.date(byAdding: .hour, value: 13, to: Date()), documentId: "13")
    ]
    @State var currentActiveItem: PetRecord? = nil
    var body: some View {
        VStack {
            HStack {
                Text("Views")
                    .fontWeight(.semibold)
                
                Picker("", selection: $currentTab) {
                    Text("7 Days")
                        .tag("7 Days")
                    Text("Week")
                        .tag("Week")
                    Text("Month")
                        .tag("Month")
                }
                .pickerStyle(.segmented)
                .padding(.leading, 80)
            }
            ChartsExample(petRecords: $perRecords, currentActiveItem: $currentActiveItem)
            .frame(height: 340)
            
        }
        .onChange(of: currentTab) { newValue in
//            if newValue != "7 Days" {
//                for (index,_) in sampleAnalytics .enumerated(){
//                    sampleAnalytics[index].views
//                }
            }
        .onAppear{
            for (index,record) in perRecords.enumerated() {
//                print("\(record.date)\n")
                withAnimation(.easeInOut(duration: 0.8).delay(Double(index) * 1)) {
                    perRecords[index].animate = true
                }
            }
        }
            
        }
}

struct ContactDetail_Previews: PreviewProvider {
    static var previews: some View {
        ContactDetail()
    }
}

struct ChartsExample: View {
    @Binding var petRecords: [PetRecord]
    @Binding var currentActiveItem: PetRecord?
    var body: some View {
        List {
            Chart {
                ForEach(petRecords, id: \.self) { record in
//                                        BarMark(
       
                    LineMark(
                        x: .value("Mount", record.date  ?? Date(), unit: .second),
                        y: .value("Value",  record.weight )
                    )
                    if let currentActiveItem, currentActiveItem.documentId == record.documentId {
//                        RuleMark(x: .value("Mount", record.location))
//                        let xValue: Int = Int(currentActiveItem?.location ?? 0)
//                        print("currentActiveItem.weight", currentActiveItem.weight)
                        RuleMark(x: .value("CurrentPlace", currentActiveItem.weight))
                                 .foregroundStyle(.gray)
//                                 .lineStyle(StrokeStyle(lineWidth: 1, dash: [5]))
                                 .annotation(position: .trailing, alignment: .leading) {
                                     Text("50")
                                         .foregroundStyle(.gray)
                                         .offset(x: currentActiveItem.location , y: currentActiveItem.locationy )
                                 }
//                        if let geometry = geometry {
//                            RuleMark()
//                                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
//                        }
                       
                    }
//                    PointMark(
//                        x: .value("Mount", record.date  ?? Date(), unit: .hour),
//                        y: .value("Value", record.weight )
//                    )
          
                }
            }
            .foregroundColor(Color(darkerGreyColor))
            .frame(height: 250)
            // MARK: Customizing Y-Axis Length
//            .chartYScale(domain: 0...((petRecords.max(by: { $0.weight < $1.weight })?.weight ?? 0)  +  40))
            .chartOverlay { chartProxy in
                GeometryReader { geometryProxy in
                    Rectangle()
                        .fill(.clear).contentShape(Rectangle())
                        .gesture(
                        DragGesture()
                            .onChanged { value in
                                // MARK: Getting Current Location
                                let location = value.location
                                //                                print(value)
                                if let date: Date = chartProxy.value(atX: location.x) {
                                    //Extracting
                                    let calendar = Calendar.current
                                    let hour = calendar.component(.second, from: date)
                                    print("hours", hour, date)
                                    if let currentItemIndex = petRecords.firstIndex(where: { item in
                                                                                calendar.component(.second, from: item.date ?? Date()) == hour
//                                        checkHour(date1: item.date, date2: date)
                                        
                                    }) {
                        
//                                        print(currentItem)
//                                        self.currentActiveItem = petRecords[Int.random(in: 0..<3)]
                                        self.currentActiveItem = petRecords[currentItemIndex]
                                        self.currentActiveItem?.location = location.x
                                        self.currentActiveItem?.locationy = location.y
                                        print("currentActiveItem.weight", self.currentActiveItem?.weight ?? 0)
                                        geometry = geometryProxy
                                    }
                                }
                                
                                //                                let xCurrent = value.location.x - geometryProxy[chartProxy.plotAreaFrame].origin.x
                                //                                let index1: Double? = chartProxy.value(atX: xCurrent)
                                //                                print (xCurrent, value.location.x, index1)
                                //                                if let index: Double = chartProxy.value(atX: xCurrent),
                                //                                   index >= 0,
                                //                                   Int(index) <= petRecords.count - 1 {
                                ////                                    self.vm.selectedX = Int(index)
                                //                                    currentActiveItem = petRecords[Int(index)]
//                                    print("currentActiveItem", currentActiveItem)
//                                }
                            }.onEnded { value in
                                self.currentActiveItem = nil
                            }
                        )
                }
            }
        }
    }
    
    private func checkHour(date1: Date?, date2: Date?) -> Bool {
        guard let date1 = date1, let date2 = date2 else { return false }
        let f = DateFormatter()
        f.dateFormat = "HH"
        let date1Str = f.string(from: date1)
        let date2Str =  f.string(from: date2)
        return date1Str == date2Str
        
        
    }
    
}
