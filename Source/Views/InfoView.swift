import UIKit

protocol InfoViewDelegate {
    func dismissInfoView(withPokemon pokemon: Pokemon?)
}

class InfoView: UIView {
    
    // MARK: - Properties
    var delegate: InfoViewDelegate?
    
    var pokemon: Pokemon? {
        didSet {
            guard let pokemon = self.pokemon else { return }
            guard let type = pokemon.type else { return }
            guard let defense = pokemon.defense else { return }
            guard let attack = pokemon.attack else { return }
            guard let id = pokemon.id else { return }
            guard let height = pokemon.height else { return }
            guard let weight = pokemon.weight else { return }
            
            imageView.image = pokemon.image
            nameLabel.text = pokemon.name?.capitalized
            
            configureLabel(label: typeLabel, title: "Type", details: type)
            configureLabel(label: defenseLabel, title: "Defense", details: "\(defense)")
            configureLabel(label: heightLabel, title: "Height", details: "\(height)")
            configureLabel(label: weightLabel, title: "Weight", details: "\(weight)")
            configureLabel(label: pokedexIdLabel, title: "Pokedex Id", details: "\(id)")
            configureLabel(label: attackLabel, title: "Base Attack", details: "\(attack)")
        }
    }
    
    
    // MARK: - UI Elements
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.noResizingMask()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    lazy var nameContainerView: UIView = {
        let view = UIView()
        view.noResizingMask()
        view.backgroundColor = .mainPink()
        view.addSubview(nameLabel)
        view.layer.cornerRadius = 5
        nameLabel.center(inView: view)
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Charmander"
        return label
    }()
    
    let typeLabel: UILabel = {
        let label = UILabel()
        label.noResizingMask()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "80"
        return label
    }()
    
    let defenseLabel: UILabel = {
        let label = UILabel()
        label.noResizingMask()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "80"
        return label
    }()
    
    let heightLabel: UILabel = {
        let label = UILabel()
        label.noResizingMask()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "80"
        return label
    }()
    
    let pokedexIdLabel: UILabel = {
        let label = UILabel()
        label.noResizingMask()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "80"
        return label
    }()
    
    let attackLabel: UILabel = {
        let label = UILabel()
        label.noResizingMask()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "90"
        return label
    }()
    
    let weightLabel: UILabel = {
        let label = UILabel()
        label.noResizingMask()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "90"
        return label
    }()
    
    let infoButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .mainPink()
        button.setTitle("View More Info", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleViewMoreInfo), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        return button
    }()
    
    // MARK: - Behaviors Functions
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configViewComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    // MARK: - Selectors
    
    @objc func handleViewMoreInfo() {
        guard let pokemon = self.pokemon else {return}
        delegate?.dismissInfoView(withPokemon: pokemon)
    }
    
    // MARK: - Custom Methods
    func configureLabel(label: UILabel, title: String, details: String) {
        let attributedText = NSMutableAttributedString(attributedString: NSAttributedString(
            string: "\(title): ",
            attributes: [
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16),
                NSAttributedString.Key.foregroundColor: UIColor.mainPink()]))
        
        attributedText.append(NSAttributedString(string: "\(details)", attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
            NSAttributedString.Key.foregroundColor: UIColor.gray]))
        
        label.attributedText = attributedText
    }
    
    func configViewComponents() {
        backgroundColor = .white
        self.layer.masksToBounds = true
        
        addSubview(self.nameContainerView)
        addSubview(self.imageView)
        addSubview(self.typeLabel)
        addSubview(self.pokedexIdLabel)
        addSubview(self.heightLabel)
        addSubview(self.weightLabel)
        addSubview(self.infoButton)
        
        NSLayoutConstraint.activate([
            nameContainerView.topAnchor.constraint(equalTo: topAnchor),
            nameContainerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            nameContainerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            nameContainerView.heightAnchor.constraint(equalToConstant: 50),
            
            imageView.topAnchor.constraint(equalTo: nameContainerView.bottomAnchor, constant: 24),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 60),
            
            typeLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            typeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            typeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            pokedexIdLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 8),
            pokedexIdLabel.leadingAnchor.constraint(equalTo: typeLabel.leadingAnchor),
            pokedexIdLabel.trailingAnchor.constraint(equalTo: typeLabel.trailingAnchor),
            
            heightLabel.topAnchor.constraint(equalTo: pokedexIdLabel.bottomAnchor, constant: 8),
            heightLabel.leadingAnchor.constraint(equalTo: typeLabel.leadingAnchor),
            heightLabel.trailingAnchor.constraint(equalTo: typeLabel.trailingAnchor),
            
            weightLabel.topAnchor.constraint(equalTo: heightLabel.bottomAnchor, constant: 8),
            weightLabel.leadingAnchor.constraint(equalTo: typeLabel.leadingAnchor),
            weightLabel.trailingAnchor.constraint(equalTo: typeLabel.trailingAnchor),
            
            infoButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            infoButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            infoButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            infoButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        
    }
}
