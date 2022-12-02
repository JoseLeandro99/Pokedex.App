import UIKit

protocol PokedexCellDelegate {
    func presentInfoView(withPokemon pokemon: Pokemon)
}

class PokedexCell: UICollectionViewCell {
    static let identifier = "PokedexCellIdentifier"
    
    var delegate: PokedexCellDelegate?
    
    var pokemon: Pokemon? {
        didSet {
            nameLabel.text = pokemon?.name
            imageView.image = pokemon?.image
        }
    }
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.noResizingMask()
        imageView.backgroundColor = .tertiarySystemBackground
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var nameContainerView: UIView = {
        let view = UIView()
        view.noResizingMask()
        view.backgroundColor = .mainPink()
        view.addSubview(nameLabel)
        nameLabel.center(inView: view)
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "labelText"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configViewComponents()
        self.configLongPressRecognizer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configViewComponents() {
        layer.cornerRadius = 10
        self.clipsToBounds = true
        
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -36)
        ])
        
        contentView.addSubview(nameContainerView)
        NSLayoutConstraint.activate([
            nameContainerView.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            nameContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            nameContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            nameContainerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    func configLongPressRecognizer() {
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        self.addGestureRecognizer(longPressRecognizer)
    }
    
    @objc func handleLongPress(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            print("press has began")
            
            guard let pokemon = self.pokemon else {return}
            self.delegate?.presentInfoView(withPokemon: pokemon)
        }
    }
}
