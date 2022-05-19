//
//  NFTCollectionViewModel.swift
//  Alpha-Wallet
//
//  Created by Oguzhan Gungor on 2/24/18.
//  Copyright © 2018 Alpha-Wallet. All rights reserved.
//

import Foundation
import BigInt

struct NFTCollectionViewModel {

    var initiallySelectedTabIndex: Int {
        return 1
    }

    private let assetDefinitionStore: AssetDefinitionStore
    let token: TokenObject
    var tokenHolders: [TokenHolder]

    func item(for indexPath: IndexPath) -> TokenHolder {
        return tokenHolders[indexPath.section]
    }

    var backgroundColor: UIColor {
        return Colors.appBackground
    }

    var navigationTitle: String {
        if let name = token.titleInPluralForm(withAssetDefinitionStore: assetDefinitionStore, eventsDataStore: eventsDataStore, forWallet: wallet) {
            return name
        } else {
            return token.titleInPluralForm(withAssetDefinitionStore: assetDefinitionStore)
        }
    }

    private let eventsDataStore: NonActivityEventsDataStore
    private let wallet: Wallet

    init(token: TokenObject, forWallet wallet: Wallet, assetDefinitionStore: AssetDefinitionStore, eventsDataStore: NonActivityEventsDataStore) {
        self.token = token
        self.wallet = wallet
        self.eventsDataStore = eventsDataStore
        self.tokenHolders = token.getTokenHolders(assetDefinitionStore: assetDefinitionStore, eventsDataStore: eventsDataStore, forWallet: wallet)
        self.assetDefinitionStore = assetDefinitionStore
    }

    mutating func invalidateTokenHolders() {
        tokenHolders = token.getTokenHolders(assetDefinitionStore: assetDefinitionStore, eventsDataStore: eventsDataStore, forWallet: wallet)
    }

    func tokenHolder(at indexPath: IndexPath) -> TokenHolder {
        return tokenHolders[indexPath.section]
    }

    func numberOfItems() -> Int {
        return tokenHolders.count
    }

}
