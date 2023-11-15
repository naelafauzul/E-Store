//
//  ProfilePresenter.swift
//  E-Store
//
//  Created by Naela Fauzul Muna on 11/11/23.
//

import Foundation

class ProfilePresenter {
    
}

class DefaultProfilePresenter: ProfilePresenter{
    private weak var view: ProfileView?
    private var interactor: ProfileInteractor
    private var router: ProfileRouter
    
    init(view: ProfileView, interactor: ProfileInteractor, router: ProfileRouter) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}
