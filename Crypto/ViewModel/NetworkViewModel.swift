//
//  NetworkViewModel.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import Foundation
import Combine

class NetworkViewModel: ObservableObject {
    
    @Published var networkList: [ChainNetwork]
    @Published var isLoading: Bool
    
    private var allNetworks: [ChainNetwork]
    private var cancellables = Set<AnyCancellable>()
    private let networkService: NetworkDataService
    private (set) var selectedNetwork: ChainNetwork?
    
    init() {
        allNetworks = []
        networkList = []
        selectedNetwork = nil
        isLoading = false
        networkService = NetworkDataService()

        fetchChainNetworks()
    }
    
    /// fetch networks
    func fetchChainNetworks() {
        isLoading = true
        networkService.getNetworks()
            .receive(on: RunLoop.main)
            .sink { completion in
                self.isLoading = false
            } receiveValue: { networks in
                self.allNetworks = networks
                self.selectedNetwork = networks[networks.count - 1]
                self.networkList = networks.filter { $0.name != self.selectedNetwork?.name }
            }
            .store(in: &cancellables)
    }
}

extension NetworkViewModel {
    func updateSelectedNetwork(to network: ChainNetwork) {
        selectedNetwork = network
        networkList = allNetworks.filter{ $0.name != selectedNetwork?.name }
    }
}
