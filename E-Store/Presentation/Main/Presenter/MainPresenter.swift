//
//  MainPresenter.swift
//  E-Store
//
//  Created by Naela Fauzul Muna on 21/12/23.
//

import Foundation

protocol MainPresenter {
    func shoudSelectTab(index: Int) -> Bool
}

class DefaultMainPresenter: MainPresenter {
    private weak var view: MainView?
    private let interactor: MainInteractor
    private let router: MainRouter
    
    init(view: MainView, interactor: MainInteractor, router: MainRouter) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func shoudSelectTab(index: Int) -> Bool {
        if index == 2 { // jika index = 2 Profile tab
            if interactor.canShowProfile() {
                return true
            } else {
                router.presentLogin {
                    self.view?.selectTab(index: index)
                }
                return false
            }
        } else {
            return true
        }
    }
}
