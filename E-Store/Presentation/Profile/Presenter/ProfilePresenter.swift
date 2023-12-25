//
//  ProfilePresenter.swift
//  E-Store
//
//  Created by Naela Fauzul Muna on 11/11/23.
//

import Foundation

protocol ProfilePresenter {
    func logout()
    func loadProfile()
    var name: String? {get}
}

class DefaultProfilePresenter: ProfilePresenter{
    
    private weak var view: ProfileView?
    private var interactor: ProfileInteractor
    private var router: ProfileRouter
    
    var profile: Profile?
    
    init(view: ProfileView, interactor: ProfileInteractor, router: ProfileRouter) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func logout() {
        if interactor.isAlreadyLoggedIn {
            interactor.logout()
            view?.setStateLoggedOut()
        } else {
            router.presentLogin {
                self.loadProfile()
            }
        }
    }
    
    func loadProfile() {
        interactor.loadProfile { result in
            switch result {
            case.success(let profile):
                self.profile = profile
            case .failure(let error):
                print(String(describing: error))
                
            }
            self.view?.setStateLoggedIn()
        }
    }
    
    var name: String? {
        return profile?.name
    }
}
