//
//  InfoViewController.swift
//  MVP+UnitTests
//
//  Created by F1xTeoNtTsS on 27.01.2022.
//

import UIKit

class InfoViewController: UIViewController {
    
    var presenter: InfoViewPresenterProtocol?
    var pokemon: CurrentPokemonModel? {
        didSet {
            guard let pokemon = pokemon else { return }
            self.pokemonName.text = pokemon.name.capitalized
            self.pokemonImage.image = pokemon.image
        }
    }
    let pokemonImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let pokemonName: UILabel = {
        let name = UILabel()
        name.textAlignment = .center
        name.font = .boldSystemFont(ofSize: 30)
        name.textColor = .systemGray
        return name
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setConstraints()
        presenter?.setPokemonInfo()
    }
    
    func setConstraints() {
        let stack = UIStackView(arrangedSubviews: [pokemonImage, pokemonName])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            stack.widthAnchor.constraint(equalToConstant: 200),
            stack.heightAnchor.constraint(equalToConstant: 400)
        ])
    }
}

extension InfoViewController: InfoViewProtocol {
    func setPokemon(as info: CurrentPokemonModel?) {
        self.pokemon = info
    }
}
