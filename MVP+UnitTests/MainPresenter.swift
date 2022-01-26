//
//  MainPresenter.swift
//  MVP+UnitTests
//
//  Created by F1xTeoNtTsS on 26.01.2022.
//

import Foundation

protocol MainViewProtocol: AnyObject {
    func success()
    func failure(error: Error)
}

protocol MainViewPresenterProtocol: AnyObject {

    var pokemons: [CurrentPokemonModel]? {get set}
    init(view: MainViewProtocol, networkManager: NetworkManagerProtocol)
    func fetchPokemons()
}

class MainPresenter: MainViewPresenterProtocol {
    var pokemons: [CurrentPokemonModel]?
    weak var view: MainViewProtocol?
    var networkManager: NetworkManagerProtocol
    
    required init(view: MainViewProtocol, networkManager: NetworkManagerProtocol) {
        self.view = view
        self.networkManager = networkManager
        fetchPokemons()
    }
    
    func fetchPokemons() {
        networkManager.fetchPokemon { [weak self] pokemons, error in
            guard let self = self else { return }
            if let error = error {
                self.view?.failure(error: error)
            }
            self.pokemons = pokemons
            self.view?.success()
        }
    }
}
