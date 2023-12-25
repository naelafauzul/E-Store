//
//  ProfileInteractor.swift
//  E-Store
//
//  Created by Naela Fauzul Muna on 11/11/23.
//

import Foundation

protocol ProfileInteractor {
    func logout()
    func loadProfile(completion: @escaping (Result<Profile, Error>) -> Void)
    var isAlreadyLoggedIn: Bool {get}
}

class DefaultProfileInteractor: ProfileInteractor {
    
    
    private let accessTokenStore: AccessTokenStore
    private let apiService: ApiService
    
    init(accessTokenStore: AccessTokenStore = AccessTokenStore.shared, apiService: ApiService = ApiService.shared) {
        self.accessTokenStore = accessTokenStore
        self.apiService = apiService
    }
    
    
    func logout() {
        //set akses token nil
        accessTokenStore.accessToken = nil
    }
    
    func loadProfile(completion: @escaping (Result<Profile, Error>) -> Void) {
        apiService.loadProfile(completion: completion)
    }
    
    var isAlreadyLoggedIn: Bool {
        return accessTokenStore.accessToken != nil
    }
}
    
    

