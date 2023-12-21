//
//  LoginPresenter.swift
//  E-Store
//
//  Created by Naela Fauzul Muna on 18/11/23.
//

import Foundation

protocol LoginPresenter {
    func login(username: String, password: String)
}

class DefaultLoginPresenter: LoginPresenter {
    private weak var view: LoginView?
    private let interactor: LoginInteractor
    private let router: LoginRouter
    
    init(view: LoginView, interactor: LoginInteractor, router: LoginRouter) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func login(username: String, password: String) {
        
    }
}
