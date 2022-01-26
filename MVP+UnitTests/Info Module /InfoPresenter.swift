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
         currentPokemon: CurrentPokemonModel?)
    func setPokemonInfo()
}

class InfoViewPresenter: InfoViewPresenterProtocol {
    
    weak var view: InfoViewProtocol?
    var currentPokemon: CurrentPokemonModel?
    var networkManager: NetworkManagerProtocol
    required init(view: InfoViewProtocol,
                  networkManager: NetworkManagerProtocol,
                  currentPokemon: CurrentPokemonModel?) {
        self.view = view
        self.networkManager = networkManager
        self.currentPokemon = currentPokemon
    }
    
    func setPokemonInfo() {
        self.view?.setPokemon(as: currentPokemon)
    }
}
