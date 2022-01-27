//
//  InfoPresenter.swift
//  MVP+UnitTests
//
//  Created by F1xTeoNtTsS on 26.01.2022.
//

import Foundation

protocol InfoViewProtocol: AnyObject {
    func setPokemon(as info: CurrentPokemonModel?)
}

protocol InfoViewPresenterProtocol: AnyObject {
    init(view: InfoViewProtocol,
         networkManager: NetworkManagerProtocol,
         currentPokemon: CurrentPokemonModel?,
         router: RouterProtocol)
    func setPokemonInfo()
}

class InfoViewPresenter: InfoViewPresenterProtocol {
    
    weak var view: InfoViewProtocol?
    var currentPokemon: CurrentPokemonModel?
    var networkManager: NetworkManagerProtocol?
    var router: RouterProtocol?
    
    required init(view: InfoViewProtocol,
                  networkManager: NetworkManagerProtocol,
                  currentPokemon: CurrentPokemonModel?,
                  router: RouterProtocol) {
        self.view = view
        self.networkManager = networkManager
        self.currentPokemon = currentPokemon
        self.router = router
    }
    
    func setPokemonInfo() {
        self.view?.setPokemon(as: currentPokemon)
    }
}
