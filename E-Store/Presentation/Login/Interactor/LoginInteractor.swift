//
//  LoginInteractor.swift
//  E-Store
//
//  Created by Naela Fauzul Muna on 18/11/23.
//
import Foundation

protocol LoginInteractor {
    func login(username: String, password: String, completion: @escaping (Error?) -> Void)
}

class DefaultLoginInteractor: LoginInteractor {
    private let apiService: ApiService
    
    init(apiService: ApiService) {
        self.apiService = apiService
    }
    
    func login(username: String, password: String, completion: @escaping (Error?) -> Void) {
        apiService.login(username: username, password: password) { result in
            switch result {
            case .success:
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
        
    }
}

