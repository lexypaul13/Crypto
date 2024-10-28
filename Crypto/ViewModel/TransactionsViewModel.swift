//
//  TransactionsViewModel.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import Foundation
import Combine

class TransactionsViewModel: ObservableObject {
    @Published var todayTransactionList: [Transaction]
    @Published var previousTransactionList: [Transaction]
    @Published var isLoading: Bool
    
    private var cancellables = Set<AnyCancellable>()
    private let transactionService: TransactionDataService
    
    init() {
        todayTransactionList = []
        previousTransactionList = []
        transactionService = TransactionDataService()
        isLoading = false
        
        fetchTransactions()
    }
    
    /// fetch transactions
    func fetchTransactions() {
        isLoading = true
        transactionService.getTransactions()
            .receive(on: RunLoop.main)
            .sink { completion in
                self.isLoading = false
            } receiveValue: { transactions in
                self.todayTransactionList =  transactions.filter{ $0.isDateToday }
                self.previousTransactionList = transactions.filter{ !$0.isDateToday }
            }
            .store(in: &cancellables)
    }
}
