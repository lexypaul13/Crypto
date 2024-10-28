//
//  AddNetworkViewModel.swift
//  Crypto
//
//  Created by Virtual Gravity.
//

import Foundation
import Combine

class AddNetworkViewModel: ObservableObject {
    @Published var addNetworkList: [AddNetwork]
    @Published var isLoading: Bool
    
    private var allAddNetworkList: [AddNetwork]
    private let addNetworkService: AddNetworkDataService
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        allAddNetworkList = []
        addNetworkList = []
        addNetworkService = AddNetworkDataService()
        isLoading = false
        
        fetchAddNetworks()
    }
    
    /// fetch add network
    private func fetchAddNetworks() {
        isLoading = true
        addNetworkService.getNetworks()
            .receive(on: RunLoop.main)
            .sink { completion in
                self.isLoading = false
            } receiveValue: { networks in
                self.allAddNetworkList = networks
                self.addNetworkList = networks
            }
            .store(in: &cancellables)
    }
}

extension AddNetworkViewModel {
    func filterAddNetworkList(containing text: String) {
        guard !text.isEmpty else{
            addNetworkList = allAddNetworkList
            return
        }
        addNetworkList = allAddNetworkList.filter{ $0.name.lowercased().contains(text.lowercased()) }
    }
    
    func handleNetworkToggle(for item: AddNetwork) {
        let index = addNetworkList.firstIndex { $0.name.lowercased() == item.name.lowercased() }
        
        guard let index = index else {
            return
        }
        
        switch item.actionType {
        case .add:
            addNetworkList[index] = item.updateActionType(to: .hide)
        case .hide:
            addNetworkList[index] = item.updateActionType(to: .add)
        }
    }
}
