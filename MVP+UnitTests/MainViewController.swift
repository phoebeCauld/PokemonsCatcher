//
//  ViewController.swift
//  MVP+UnitTests
//
//  Created by F1xTeoNtTsS on 26.01.2022.
//

import UIKit

class MainViewController: UICollectionViewController {

    var presenter: MainViewPresenterProtocol?
    
    private let reuseIdentifier = "Cell"
    let activityIndicator: UIActivityIndicatorView = {
        let activityIV = UIActivityIndicatorView(style: .large)
        activityIV.startAnimating()
        activityIV.hidesWhenStopped = true
        activityIV.color = .darkGray
        activityIV.translatesAutoresizingMaskIntoConstraints = false
        return activityIV
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.backgroundColor = .white
        self.collectionView.register(PokemonInfoCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        setConstraints()
    }
    
    func setConstraints() {
        self.collectionView.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }

    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        guard let presenter = presenter else { return 0 }
        return presenter.pokemons?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                            for: indexPath) as? PokemonInfoCell else {
            return UICollectionViewCell()
        }

        if let pokemons = presenter?.pokemons {
            let currentPokemon = pokemons[indexPath.row]
            cell.pokemonInfo = currentPokemon
            return cell
        }
        return UICollectionViewCell()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let currentPokemon = presenter?.pokemons?[indexPath.row] else { return }
        let infoVC = ModuleBuilder.createInfoVC(pokemon: currentPokemon)
        self.navigationController?.pushViewController(infoVC, animated: true)
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: self.view.frame.width - 20, height: 100)
    }
}

extension MainViewController: MainViewProtocol {
    func success() {
        activityIndicator.stopAnimating()
        self.collectionView.reloadData()
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
}
