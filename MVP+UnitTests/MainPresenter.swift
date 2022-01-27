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
    init(view: MainViewProtocol, networkManager: NetworkManagerProtocol, router: RouterProtocol)
    func fetchPokemons()
    func tapOnPokemon(pokemon: CurrentPokemonModel?)
}

class MainPresenter: MainViewPresenterProtocol {
 
    var pokemons: [CurrentPokemonModel]?
    var router: RouterProtocol?
    weak var view: MainViewProtocol?
    var networkManager: NetworkManagerProtocol
    
    required init(view: MainViewProtocol, networkManager: NetworkManagerProtocol, router: RouterProtocol) {
        self.view = view
        self.networkManager = networkManager
        self.router = router
        fetchPokemons()
    }
    
    func tapOnPokemon(pokemon: CurrentPokemonModel?) {
        router?.showInfoVC(pokemon: pokemon)
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
