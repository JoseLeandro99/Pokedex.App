import UIKit

class PokedexController: UICollectionViewController {
    let infoView: InfoView = {
        let view = InfoView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        return view
    }()
    
    var pokemons = [Pokemon]()
    var filteredPokemon = [Pokemon]()
    var isSearchMode = false
    var searchBar: UISearchBar!
    
    let visualEffectsView: UIVisualEffectView = {
        let blur = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: blur)
        view.noResizingMask()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configViewComponents()
        configCollectionView()
        configVisualEffectsView()
        fetchPokemons()
    }
    
    func fetchPokemons() {
        PokemonService.shared.fetchPokemons { pokemonArray in
            self.pokemons = pokemonArray
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    func configSearchBar(shouldShow: Bool) {
        if (shouldShow) {
            searchBar = UISearchBar()
            searchBar.sizeToFit()
            searchBar.showsCancelButton = true
            searchBar.becomeFirstResponder()
            searchBar.tintColor = .white
            searchBar.delegate = self
            
            navigationItem.rightBarButtonItem = nil
            navigationItem.titleView = searchBar
        } else {
            navigationItem.titleView = nil
            self.configSearchBarButton()
            isSearchMode = false
            collectionView.reloadData()
        }
    }
    
    func configSearchBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .search,
            target: self,
            action: #selector(showSearchBar))
        navigationItem.rightBarButtonItem?.tintColor = .white
    }
    
    func configCollectionView() {
        collectionView.register(PokedexCell.self, forCellWithReuseIdentifier: PokedexCell.identifier)
    }
    
    func configViewComponents() {
        collectionView.backgroundColor = .secondarySystemBackground
        
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = true
        
        navigationItem.title = "Pokedex"
        configSearchBarButton()
    }
    
    func configVisualEffectsView() {
        view.addSubview(self.visualEffectsView)
        NSLayoutConstraint.activate([
            visualEffectsView.topAnchor.constraint(equalTo: view.topAnchor),
            visualEffectsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            visualEffectsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            visualEffectsView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        visualEffectsView.alpha = 0
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleDissmisal))
        visualEffectsView.addGestureRecognizer(gesture)
    }
    
    func showPokemonInfoController(withPokemon pokemon: Pokemon) {
        let controller = PokemonInfoController()
        controller.pokemon = pokemon
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func handleDissmisal() {
        dismissView(pokemon: nil)
    }
    
    @objc func showSearchBar() {
        configSearchBar(shouldShow: true)
    }
    
    func dismissView(pokemon: Pokemon?) {
        UIView.animate(withDuration: 0.5, animations: {
            self.visualEffectsView.alpha = 0
            self.infoView.alpha = 0
            self.infoView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }) { (_) in
            self.navigationItem.rightBarButtonItem?.isEnabled = true
            self.infoView.removeFromSuperview()
            guard let pokemon = pokemon else {return}
            self.showPokemonInfoController(withPokemon: pokemon)
            
        }
    }
}

extension PokedexController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isSearchMode ? filteredPokemon.count : pokemons.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokedexCell.identifier, for: indexPath) as? PokedexCell else {
            return UICollectionViewCell()
        }
        
        cell.delegate = self
        cell.pokemon = isSearchMode ? filteredPokemon[indexPath.row] : pokemons[indexPath.row]
        
        
        return cell
    }
}

extension PokedexController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 8, bottom: 16, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = ((view.frame.width - 36) / 3)
        return CGSize(width: width, height: width)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let poke = isSearchMode ? filteredPokemon[indexPath.row] : pokemons[indexPath.row]
        
        var pokeEvoArray = [Pokemon]()
        
        if let evoChain = poke.evolutionChain {
            let evolutionChain = EvolutionChain(evolutionArray: evoChain)
            let evoIds = evolutionChain.evolutionsId
            
            evoIds.forEach { (id) in
                pokeEvoArray.append(pokemons[id - 1])
            }
            
            poke.evoArray = pokeEvoArray
        }
        showPokemonInfoController(withPokemon: poke)
    }
}

extension PokedexController: PokedexCellDelegate {
    func presentInfoView(withPokemon pokemon: Pokemon) {
        configSearchBar(shouldShow: false)
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        view.addSubview(infoView)
        infoView.delegate = self
        infoView.pokemon = pokemon
        NSLayoutConstraint.activate([
            infoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infoView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            infoView.widthAnchor.constraint(equalToConstant: view.frame.width - 64),
            infoView.heightAnchor.constraint(equalToConstant: 350),
        ])
        
        infoView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        infoView.alpha = 0
        
        UIView.animate(withDuration: 0.5) {
            self.visualEffectsView.alpha = 1
            self.infoView.alpha = 1
            self.infoView.transform = .identity
        }
    }
}

extension PokedexController: InfoViewDelegate {
    func dismissInfoView(withPokemon pokemon: Pokemon?) {
        self.dismissView(pokemon: pokemon)
        
    }
}


extension PokedexController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        configSearchBar(shouldShow: false)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" || searchBar.text == nil {
            isSearchMode = false
            collectionView.reloadData()
            view.endEditing(true)
        } else {
            isSearchMode = true
            filteredPokemon = pokemons.filter({ $0.name?.range(of: searchText.lowercased()) != nil })
            collectionView.reloadData()
        }
    }
}
