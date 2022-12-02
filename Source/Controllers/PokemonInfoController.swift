import UIKit

class PokemonInfoController: UIViewController {
    
    var pokemon: Pokemon? {
        didSet {
            navigationItem.title = pokemon?.name?.capitalized
            imageView.image = pokemon?.image
            infoLabel.text = pokemon?.description
            
            if let type = pokemon?.type {
                configureLabel(label: typeLabel, title: "Type", details: type)
            }
            
            if let pokedexId = pokemon?.id {
                configureLabel(label: IdLabel, title: "Pokedex ID", details: String(pokedexId))
            }
            
            if let attack = pokemon?.attack {
                configureLabel(label: attackLabel, title: "ATK", details: String(attack))
            }
            
            if let defense = pokemon?.defense {
                configureLabel(label: defenseLabel, title: "DEF", details: String(defense))
            }
            
            if let weight = pokemon?.weight {
                configureLabel(label: weightLabel, title: "Weight", details: String(weight))
            }
            
            if let height = pokemon?.height {
                configureLabel(label: heightLabel, title: "Height", details: String(height))
            }
            
            if let evoArray = pokemon?.evoArray {
                if evoArray.count > 1 {
                    firstEvoImageView.image = evoArray[0].image
                    secondEvoImageView.image = evoArray[1].image
                }
            }
        }
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.noResizingMask()
        return iv
    }()
    
    let typeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.noResizingMask()
        return label
    }()
    
    let IdLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.noResizingMask()
        label.textAlignment = .right
        return label
    }()
    
    let attackLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.noResizingMask()
        return label
    }()
    
    let defenseLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.noResizingMask()
        label.textAlignment = .right
        return label
    }()
    
    let heightLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.noResizingMask()
        label.textAlignment = .right
        return label
    }()
    
    let weightLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.noResizingMask()
        return label
    }()
    
    let infoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.noResizingMask()
        label.numberOfLines = 0
        return label
    }()
    
    lazy var evolutionView: UIView = {
        let view = UIView()
        view.noResizingMask()
        view.backgroundColor = .mainPink()
        
        view.addSubview(evoLabel)
        evoLabel.translatesAutoresizingMaskIntoConstraints = false
        evoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        evoLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        return view
    }()
    
    let evoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Evolution Chain"
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    let firstEvoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.noResizingMask()
        return iv
    }()
    
    let secondEvoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.noResizingMask()
        return iv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configViewComponents()
    }
    
    func configViewComponents() {
        navigationController?.navigationBar.tintColor = .white
        view.backgroundColor =  .secondarySystemBackground
        
        view.addSubview(imageView)
        view.addSubview(infoLabel)
        view.addSubview(typeLabel)
        view.addSubview(IdLabel)
        view.addSubview(attackLabel)
        view.addSubview(defenseLabel)
        view.addSubview(weightLabel)
        view.addSubview(heightLabel)
        
        view.addSubview(evolutionView)
        view.addSubview(firstEvoImageView)
        view.addSubview(secondEvoImageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 44),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            
            infoLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 44),
            infoLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
            infoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -4),
            infoLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            
            typeLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 32),
            typeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            typeLabel.widthAnchor.constraint(equalToConstant: 120),
            
            IdLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 32),
            IdLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            IdLabel.widthAnchor.constraint(equalToConstant: 140),
            
            attackLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 16),
            attackLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            attackLabel.widthAnchor.constraint(equalToConstant: 120),
            
            defenseLabel.topAnchor.constraint(equalTo: IdLabel.bottomAnchor, constant: 16),
            defenseLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            defenseLabel.widthAnchor.constraint(equalToConstant: 140),
            
            weightLabel.topAnchor.constraint(equalTo: attackLabel.bottomAnchor, constant: 16),
            weightLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            weightLabel.widthAnchor.constraint(equalToConstant: 120),
            
            heightLabel.topAnchor.constraint(equalTo: defenseLabel.bottomAnchor, constant: 16),
            heightLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            heightLabel.widthAnchor.constraint(equalToConstant: 140),
            
            evolutionView.topAnchor.constraint(equalTo: weightLabel.bottomAnchor, constant: 32),
            evolutionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            evolutionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            evolutionView.heightAnchor.constraint(equalToConstant: 50),
            
            firstEvoImageView.topAnchor.constraint(equalTo: evolutionView.bottomAnchor, constant: 16),
            firstEvoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            firstEvoImageView.widthAnchor.constraint(equalToConstant: 120),
            firstEvoImageView.heightAnchor.constraint(equalTo: firstEvoImageView.widthAnchor),
            
            secondEvoImageView.topAnchor.constraint(equalTo: firstEvoImageView.topAnchor),
            secondEvoImageView.trailingAnchor.constraint(equalTo: evolutionView.trailingAnchor, constant: -32),
            secondEvoImageView.widthAnchor.constraint(equalTo: firstEvoImageView.widthAnchor),
            secondEvoImageView.heightAnchor.constraint(equalTo: firstEvoImageView.heightAnchor),
        ])
    }
    
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
}
