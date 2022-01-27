//
//  ModuleBuilder.swift
//  MVP+UnitTests
//
//  Created by F1xTeoNtTsS on 26.01.2022.
//

import Foundation
import UIKit

protocol AssemblyBuilder {
    func createMainVC(router: RouterProtocol) -> UIViewController
    func createInfoVC(pokemon: CurrentPokemonModel?, router: RouterProtocol) -> UIViewController
}

class AssemblyModuleBuilder: AssemblyBuilder {
    func createMainVC(router: RouterProtocol) -> UIViewController {
        let view = MainViewController()
        let networkManager = NetworkManager()
        let presenter = MainPresenter(view: view, networkManager: networkManager, router: router)
        view.presenter = presenter
        return view
    }
    
    func createInfoVC(pokemon: CurrentPokemonModel?, router: RouterProtocol) -> UIViewController {
        let view = InfoViewController()
        let networkManager = NetworkManager()
        let presenter = InfoViewPresenter(view: view,
                                          networkManager: networkManager,
                                          currentPokemon: pokemon,
                                          router: router)
        view.presenter = presenter
        return view
    }
}
