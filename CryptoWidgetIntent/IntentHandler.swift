//
//  IntentHandler.swift
//  CryptoWidgetIntent
//
//  Created by Virtual Gravity.
//

import Intents

class IntentHandler: INExtension{
    fileprivate var coinList: [Coin] {
        CoinData.coinData.map{ Coin(identifier: $0.code, display: $0.name, subtitle: $0.code, image: nil) }
    }
}

//MARK: CryptoMultiChainWidgetConfigurationIntentHandler
extension IntentHandler: CryptoWidgetConfigurationIntentHandling{
    
    func provideFavoriteCoinOptionsCollection(for intent: CryptoWidgetConfigurationIntent, with completion: @escaping (INObjectCollection<Coin>?, Error?) -> Void) {
        
        let collection = INObjectCollection(items: coinList)
        
        completion(collection, nil)
    }
}

//MARK: CryptoMultiChainWidgetConfigurationIntentHandler
extension IntentHandler: CryptoBalanceChainWidgetConfigurationIntentHandling {
                         
    
    func provideFavoriteCoinOptionsCollection(for intent: CryptoBalanceChainWidgetConfigurationIntent, with completion: @escaping (INObjectCollection<Coin>?, Error?) -> Void) {
        
        let collection = INObjectCollection(items: coinList)
        
        completion(collection, nil)
    }
    
}

//MARK: CryptoMultiChainWidgetConfigurationIntentHandler
extension IntentHandler:  CryptoMultiChainWidgetConfigurationIntentHandling {
    
    func provideFirstCoinOptionsCollection(for intent: CryptoMultiChainWidgetConfigurationIntent, with completion: @escaping (INObjectCollection<Coin>?, Error?) -> Void) {
        
        let collection = INObjectCollection(items: coinList)
        
        completion(collection, nil)
    }
    
    func provideSecondCoinOptionsCollection(for intent: CryptoMultiChainWidgetConfigurationIntent, with completion: @escaping (INObjectCollection<Coin>?, Error?) -> Void) {
        
        let collection = INObjectCollection(items: coinList)
        
        completion(collection, nil)
    }
    
    func provideThirdCoinOptionsCollection(for intent: CryptoMultiChainWidgetConfigurationIntent, with completion: @escaping (INObjectCollection<Coin>?, Error?) -> Void) {
        
        let collection = INObjectCollection(items: coinList)
        
        completion(collection, nil)
    }
    
    func provideFourthCoinOptionsCollection(for intent: CryptoMultiChainWidgetConfigurationIntent, with completion: @escaping (INObjectCollection<Coin>?, Error?) -> Void) {
        
        let collection = INObjectCollection(items: coinList)
        
        completion(collection, nil)
    }
}
