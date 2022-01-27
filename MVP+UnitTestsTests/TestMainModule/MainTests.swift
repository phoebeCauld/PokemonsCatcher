//
//  MainTests.swift
//  MVP+UnitTestsTests
//
//  Created by F1xTeoNtTsS on 26.01.2022.
//

import XCTest
@testable import MVP_UnitTests

class MockView: MainViewProtocol {
    func success() {
    }
    
    func failure(error: Error) {
    }
}

class MockNetworkManager: NetworkManagerProtocol {
    var pokemons: [CurrentPokemonModel]?
    init() {}
    
    convenience init(pokemons: [CurrentPokemonModel]) {
        self.init()
        self.pokemons = pokemons
    }
    
    func fetchPokemon(completion: @escaping ([CurrentPokemonModel]?, Error?) -> Void) {
        if let pokemons = pokemons {
            completion(pokemons, nil)
        } else {
            let error = NSError(domain: "", code: 0, userInfo: nil)
            completion(nil, error)
        }
    }
}

class MainTests: XCTestCase {

    var view: MainViewProtocol!
    var networkManager: NetworkManagerProtocol!
    var presenter: MainViewPresenterProtocol!
    var router: RouterProtocol!
    var pokemons = [CurrentPokemonModel]()
    override func setUpWithError() throws {
        try super.setUpWithError()
        let nav = UINavigationController()
        let assembly = AssemblyModuleBuilder()
        router = Router(navigationController: nav, assemblyBuilder: assembly)
    }

    override func tearDownWithError() throws {
        view = nil
        networkManager = nil
        presenter = nil
        try super.tearDownWithError()
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
    func testCatchingPokemonsIsSuccess() {
        let pokemon = CurrentPokemonModel(name: "Bazz", url: "fuzz", image: UIImage())
        pokemons.append(pokemon)
        view = MockView()
        networkManager = MockNetworkManager(pokemons: pokemons)
        presenter = MainPresenter(view: view, networkManager: networkManager, router: router)
        
        var catchedPokemons: [CurrentPokemonModel]?
        networkManager.fetchPokemon { pokemon, error in
            if let error = error {
                print(error.localizedDescription)
                return
            } else {
                catchedPokemons = pokemon
            }
        }

        XCTAssertNotEqual(catchedPokemons?.count, 0)
        XCTAssertEqual(catchedPokemons?.first?.name, "Bazz")
    }
    
    func testCatchingPokemonsIsFailure() {
        let pokemon = CurrentPokemonModel(name: "Bazz", url: "fuzz", image: UIImage())
        pokemons.append(pokemon)
        view = MockView()
        networkManager = MockNetworkManager()
        presenter = MainPresenter(view: view, networkManager: networkManager, router: router)
        
        var catchedError: Error?
        networkManager.fetchPokemon { pokemon, error in
            if let error = error {
                catchedError = error
            } else {
                return
            }
        }
        XCTAssertNotNil(catchedError)
    }
}
