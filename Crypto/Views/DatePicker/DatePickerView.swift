//
//  DatePickerView.swift
//  Crypto
//
//  Created by Sudan Tuladhar on 06/09/2023.
//

import SwiftUI

struct DatePickerView: View {
    @EnvironmentObject var data: CryptoAppData
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var startingDate: Date = Date()
    @State private var endingDate: Date = Date().addingTimeInterval(-24*60*60)
    var action: (Date, Date) -> Void
    var body: some View {
        VStack(spacing: 0) {
            DatePicker(
                    "From",
                    selection: $startingDate,
                    in: ...Date(),
                    displayedComponents: [.date])
                .datePickerStyle(.compact)
                .padding(.vertical)
                .tint(Colors.brown)
                .foregroundColor(Colors.blueWhite)
                .padding(.vertical, -8)
            
            DatePicker(
                    "To",
                    selection: $endingDate,
                    in: ...Date(),
                    displayedComponents: [.date])
                .datePickerStyle(.compact)
                .padding(.vertical)
                .tint(Colors.brown)
                .foregroundColor(Colors.blueWhite)
                .padding(.vertical, -8)
            
            PrimaryButton(text: "Update") {
                action(startingDate, endingDate)
            }
            .frame(height: 44.0)
            .padding(.vertical, 12.0)
        }
        .padding(.horizontal, 16.0)
        .padding(.vertical, 16.0)
        .background(Colors.brown8Brown5)
        .cornerRadius(16.0)
        .overlay(
            RoundedRectangle(cornerRadius: 16.0)
                .stroke(Colors.brown25Blue, lineWidth: 1.0)
        )
        .padding(.vertical, 16.0)
        .transition(.move(edge: .top))
    }
}

struct DatePickerView_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerView() { _, _ in }
    }
}
