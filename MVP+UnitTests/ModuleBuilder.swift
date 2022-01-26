//
//  ModuleBuilder.swift
//  MVP+UnitTests
//
//  Created by F1xTeoNtTsS on 26.01.2022.
//

import Foundation
import UIKit

protocol Builder {
    static func createMainVC() -> UIViewController
    static func createInfoVC(pokemon: CurrentPokemonModel?) -> UIViewController
}

class ModuleBuilder: Builder {
    
    static func createMainVC() -> UIViewController {
        let view = MainViewController()
        let networkManager = NetworkManager()
        let presenter = MainPresenter(view: view, networkManager: networkManager)
        view.presenter = presenter
        return view
    }
    
    static func createInfoVC(pokemon: CurrentPokemonModel?) -> UIViewController {
        let view = InfoViewController()
        let networkManager = NetworkManager()
        let presenter = InfoViewPresenter(view: view,
                                          networkManager: networkManager,
                                          currentPokemon: pokemon)
        view.presenter = presenter
        return view
    }
}
