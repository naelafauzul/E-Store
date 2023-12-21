//
//  MainInteractor.swift
//  E-Store
//
//  Created by Naela Fauzul Muna on 21/12/23.
//

import Foundation

protocol MainInteractor {
    func canShowProfile() -> Bool
}

class DefaultMainInteractor: MainInteractor {
    private let accessTokenStore: AccessTokenStore
    
    init(accessTokenStore: AccessTokenStore = AccessTokenStore.shared) {
        self.accessTokenStore = accessTokenStore
    }
    
    func canShowProfile() -> Bool {
        return accessTokenStore.accessToken != nil
    }
}
