//
//  PokemonCell.swift
//  MVP+UnitTests
//
//  Created by F1xTeoNtTsS on 26.01.2022.
//

import UIKit

class PokemonInfoCell: UICollectionViewCell {
    
    var pokemonInfo: CurrentPokemonModel? {
        didSet {
            guard let pokemonInfo = pokemonInfo else { return }
            pokemonName.text = pokemonInfo.name
            pokemonImage.image = pokemonInfo.image
        }
    }
    
    let pokemonImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 40
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let pokemonName: UILabel = {
        let name = UILabel()
        name.font = .boldSystemFont(ofSize: 20)
        name.textColor = .darkGray
        name.text = "Some cool name"
        name.numberOfLines = 0
        return name
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
    }
    
    
    func setConstraints() {
        let stack = UIStackView(arrangedSubviews: [pokemonImage, pokemonName])
        stack.spacing = 10
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            stack.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            stack.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
            stack.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10),
            pokemonImage.widthAnchor.constraint(equalToConstant: 80),
            pokemonImage.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
