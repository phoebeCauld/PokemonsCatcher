//
//  NetworkManager.swift
//  MVP+UnitTests
//
//  Created by F1xTeoNtTsS on 26.01.2022.
//

import Foundation
import UIKit

protocol NetworkManagerProtocol {
    func fetchPokemon(completion: @escaping ([CurrentPokemonModel]?, Error?) -> Void)
}

class NetworkManager: NetworkManagerProtocol {
    func fetchPokemon(completion: @escaping ([CurrentPokemonModel]?, Error?) -> Void) {
        var pokemonsArray = [CurrentPokemonModel]()
        let group = DispatchGroup()
        self.fetchPokemons { pokemons, error in
            if let error = error {
                completion(nil, error)
                return
            }
            if let pokemons = pokemons {
                let results = pokemons.results
                for currentPockemon in results {
                    group.enter()
                    self.fetchPokemonWith(url: currentPockemon.url) { pokemon, error in
                        if let error = error {
                            completion(nil, error)
                            return
                        }
                        if let pokemon = pokemon {
                            let imageString = pokemon.sprites.other.artwork.pokemonImage
                            self.transformImage(url: imageString) { image, error in
                                guard let image = image else { return }
                                let newPokemon = CurrentPokemonModel(name: currentPockemon.name.capitalized,
                                                                     url: currentPockemon.url,
                                                                     image: image)
                                pokemonsArray.append(newPokemon)
                                group.leave()
                            }
                        }
                    }
                }
                group.notify(queue: .main) {
                    completion(pokemonsArray, nil)
                }
            }
        }
    }
    
    private func fetchGenericsData<T: Decodable>(urlString: String,
                                                 completion: @escaping(T?, Error?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Fetching data failed with: \(error.localizedDescription)")
                completion(nil, error)
                return
            }
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    completion(decodedData, nil)
                } catch let error {
                    print("Decoding failed with: \(error)")
                    completion(nil, error)
                }
            }
        }.resume()
    }

    func fetchPokemons(completion: @escaping (PokemonModel?, Error?) -> Void) {
        let urlString = "https://pokeapi.co/api/v2/pokemon"
        fetchGenericsData(urlString: urlString, completion: completion)
    }
    
    func fetchPokemonWith(url: String, completion: @escaping (CurrentPokemon?, Error?) -> Void) {
        let urlString = url
        fetchGenericsData(urlString: urlString, completion: completion)
    }
    
    func transformImage(url: String, completion: @escaping (UIImage?, Error?) -> Void){
        let urlString = url
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, resp, error in
            if let error = error {
                print("Fetching data failed with ", error.localizedDescription)
                completion(nil, error)
                return
            }
            
            if let data = data {
                let imageFromData = UIImage(data: data)
                completion(imageFromData, nil)
            }
        }.resume()
    }
}
