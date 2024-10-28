//
//  HistoryView.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var data: CryptoAppData
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject private var viewModel: TransactionsViewModel
    @State private var showSettings = false
    @State private var showDatePicker = false
    init(viewModel: TransactionsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    var body: some View {
        ScrollView {
            VStack {
                Spacer().frame(height: 8)
                if showDatePicker {
                    DatePickerView() { fromDate, toDate in
                        showDatePicker.toggle()
                        print("show transactions between \(fromDate.toString(format: "MMM d yyyy")) and \(toDate.toString(format: "MMM d yyyy"))")
                    }
                }
                HomeSection(sectionName: data.strings.today, imageType: .none)
                VStack(spacing: 10) {
                    ForEach(viewModel.todayTransactionList.map{ TransactionItemViewModel(transaction: $0)}) { transaction in
                        NavigationLink(destination: SendDetailView()) {
                            TransactionCardView(vm: transaction)
                        }
                    }
                }
                Spacer().frame(height: 16)
                HomeSection(sectionName: data.strings.previous, imageType: .none)
                VStack(spacing: 10) {
                    ForEach(viewModel.previousTransactionList.map{ TransactionItemViewModel(transaction: $0)}) { transaction in
                        NavigationLink(destination: SendDetailView()) {
                            TransactionCardView(vm: transaction)
                        }
                    }
                }
            }
            .padding(.horizontal, 20)
        }
        .animation(.easeInOut(duration: 0.3), value: showDatePicker)
        .navigationBarBackButtonHidden()
        .background(
            BackgroundGradientView()
        )
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(
            leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image("back")
                    .padding(.leading, 12)
            },
            trailing: Button(action: {
                showDatePicker.toggle()
            }, label: {
                Image( showDatePicker ? "close" : "calendar")
                    .padding(.trailing, 12)
            })
        )
        .sheet(isPresented: $showSettings) {
            HomeView()
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                ToolbarContentView(title: data.strings.transactionHistory)
            }
        }
        .scrollViewTransparentNavigation()
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HistoryView(viewModel: TransactionsViewModel())
                .environmentObject(CryptoAppData())
        }
    }
}
