//
//  CryptoAppData.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import Foundation
import Combine

class CryptoAppData: ObservableObject {
    
    @Published var tokenList: [Chain]
    @Published var favoriteTokenList: [Chain]
    @Published var tokenContactList: [TokenContact]
    
    @Published var tokenViewModel = TokenViewModel()
    @Published var favoriteChainViewModel = FavoriteChainViewModel()
    @Published var notificationViewModel = NotificationViewModel()
    @Published var addNetworkViewModel = AddNetworkViewModel()
    @Published var transactionsViewModel = TransactionsViewModel()
    @Published var chainNetworkViewModel = NetworkViewModel()
    
    @Published private (set) var selectedChain: Chain? = nil
    
    @Published var strings: LocalizableString  = LocalizableString()
    
    @Published var selectedTab: TabViewItemType = .home
    
    @Published var sessionState: SessionState
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        tokenList = []
        tokenContactList = []
        favoriteTokenList = []
        sessionState = LocalStorage.shared.isUserLoggedIn == true ? .loggedIn : .loggedOut
        
        observe()
        
        fetch()
    }
    
    private func fetch() {
        // fetch tokens
        let tokenService = TokenDataService()
        
        // fetch token contacts
        let tokenContactService = TokenContactDataService()
        
        tokenContactService.getContacts()
            .receive(on: RunLoop.main)
            .sink { completion in
                //print(completion)
            } receiveValue: { contacts in
                self.tokenContactList = contacts
            }
            .store(in: &cancellables)
        
        tokenViewModel.fetchTokens()
        
        favoriteChainViewModel.fetchFavorites()
    }
    
    func setSelectedChainCode(_ code: String?) {
        setSelectedChain(tokenList.first(where: { $0.code.lowercased() == code?.lowercased() }))
    }
    
    func setSelectedChain(_ token: Chain?) {
        selectedChain = token
    }
    
    private func observe() {
        favoriteChainViewModel.$favoriteTokenList
            .sink { favorites in
                let favoriteTokenNames = favorites.filter{ $0.isFavorite }.map{ $0.name }
                
                self.favoriteTokenList = self.tokenList.filter{ favoriteTokenNames.contains($0.name) }
            }
            .store(in: &cancellables)
        
        tokenViewModel.$tokenList
            .sink { tokens in
                self.tokenList = tokens
            }
            .store(in: &cancellables)
    }
}

extension CryptoAppData {
    struct Preview {
        static var token: Chain {
            Chain(id: "fd25a0e4-427f-11ee-be56-0242ac120002", name: "Bitcoin", code: "BTC", price: 30205.09, amount: 143, change: 0.8, imageName: "bitcoin")
        }
        
        static var transaction: Transaction {
            Transaction(id: "fd25a0e4-427f-11ee-be56-0242ac120002", name: "Bitcoin", code: "BTC", address: "0x000...000", amount: 2.25, date: "", action: "receive", imageName: "bitcoin")
        }
        
        static var notification: Notification {
            Notification(id: "123", title: "Received crypto from others", description: "You have received a payment of 100 USDT at 2023-07-01 14:28:33 (UTC). You can check your transaction details in Binance Pay homepage via Wallets-Funding-Pay", date: "2023-08-21 06:03:05 +0000", isRead: true)
        }
        
        static var favoriteToken: FavoriteChain {
            FavoriteChain(id: "fd25a0e4-427f-11ee-be56-0242ac120002", name: "Bitcoin", imageName: "bitcoin", isFavorite: true)
        }
        
        static var tokenContact: TokenContact {
            TokenContact(id: "3f843464-4258-11ee-be56-0242ac120002", name: "Bitcoin", imageName: "bitcoin", address: "0x6B175474E89094C44Da98b954EedeAC495271d0F")
        }
        
        static var addNetwork: AddNetwork{
            AddNetwork(id: "fd25a0e4-427f-11ee-be56-0242ac120002", name: "Bitcoin", imageName: "bitcoin", amount: 123456, added: true, code: "BTC", change: 0.8, price: 1912.89)
        }
        
        static var network: ChainNetwork {
            ChainNetwork(id: "fd25a0e4-427f-11ee-be56-0242ac120002", name: "Bitcoin", imageName: "bitcoin")
        }
    }
}

enum SessionState {
    case loggedIn
    case loggedOut
}
