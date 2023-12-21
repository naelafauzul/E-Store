//
//  AccessTokenStore.swift
//  E-Store
//
//  Created by Naela Fauzul Muna on 21/12/23.
//

import Foundation
import Valet

class AccessTokenStore {
    static let shared: AccessTokenStore = AccessTokenStore()
    private init() { }
    
    private lazy var valet: Valet = {
        return Valet.valet(with: Identifier(nonEmpty: Bundle.main.bundleIdentifier)!, accessibility: .whenUnlocked)
    }()
    
    private let accessTokenKey = "kAccessTokenKey"
    
    var accessToken: AccessToken? {
        get {
            if let data = try? valet.object(forKey: accessTokenKey) {
                return try? JSONDecoder().decode(AccessToken.self, from: data)
            } else {
                return nil
            }
        }
        set {
            if let accessToken = newValue {
                if let data = try? JSONEncoder().encode(accessToken) {
                    try? valet.setObject(data, forKey: accessTokenKey)
                }
            } else {
                try? valet.removeObject(forKey: accessTokenKey)
            }
        }
    }
}

