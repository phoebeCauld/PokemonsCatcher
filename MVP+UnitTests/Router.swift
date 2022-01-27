//
//  Router.swift
//  MVP+UnitTests
//
//  Created by F1xTeoNtTsS on 27.01.2022.
//

import Foundation
import UIKit


protocol MainRouter {
    var navigationController: UINavigationController? {get set}
    var assemblyBuilder: AssemblyBuilder? {get set}
}

protocol RouterProtocol: MainRouter {
    func showInitialVC()
    func showInfoVC(pokemon: CurrentPokemonModel?)
    func popToRoot()
}

class Router: RouterProtocol {
    var navigationController: UINavigationController?
    
    var assemblyBuilder: AssemblyBuilder?
    
    init(navigationController: UINavigationController,assemblyBuilder: AssemblyBuilder) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func showInitialVC() {
        if let navigationController = navigationController {
            guard let initialVC = assemblyBuilder?.createMainVC(router: self) else { return }
            navigationController.viewControllers = [initialVC]
        }
    }
    
    func showInfoVC(pokemon: CurrentPokemonModel?) {
        if let navigationController = navigationController {
            guard let infolVC = assemblyBuilder?.createInfoVC(pokemon: pokemon,
                                                              router: self) else { return }
            navigationController.pushViewController(infolVC, animated: true)
        }
    }
    
    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
}
