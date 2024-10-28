//
//  TokenViewModel.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import Foundation
import Combine

class TokenViewModel: ObservableObject {
    @Published var tokenList: [Chain]
    @Published var isLoading: Bool
    private var cancellables = Set<AnyCancellable>()
    private var allTokenList: [Chain]
    private let tokenService: TokenDataService
    
    init() {
        allTokenList = []
        tokenList = []
        tokenService = TokenDataService()
        isLoading = false
    }
    
    // fetch tokens
    func fetchTokens() {
        isLoading = true
        tokenService
            .getTokens()
            .receive(on: RunLoop.main)
            .sink { completion in
                self.isLoading = false
            } receiveValue: { tokens in
                self.allTokenList = tokens
                self.tokenList = tokens
            }
            .store(in: &cancellables)
    }
}

extension TokenViewModel {
    func filterTokens(containing text: String) {
        guard !text.isEmpty else{
            tokenList = allTokenList
            return
        }
        tokenList = allTokenList.filter{ $0.name.lowercased().contains(text.lowercased()) }
    }
}
