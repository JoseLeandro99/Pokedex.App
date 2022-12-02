import Foundation
import UIKit

struct EvolutionChain {
    var evolutionArray: [[String: AnyObject]]?
    var evolutionsId = [Int]()
    
    init(evolutionArray: [[String : AnyObject]]) {
        self.evolutionArray = evolutionArray
        self.evolutionsId = setEvolutionIds()
    }
    
    func setEvolutionIds() -> [Int] {
        var results = [Int]()
        
        evolutionArray?.forEach({ (dictionary) in
            if let idString = dictionary["id"] as? String {
                guard let id = Int(idString) else {return}
                
                if id <= 151 {
                    results.append(id)
                }
            }
        })
        
        return results
    }
}

class Pokemon {
    var name: String?
    var imageUrl: String?
    var image: UIImage?
    var id: Int?
    var weight: Int?
    var height: Int?
    var attack: Int?
    var defense: Int?
    var description: String?
    var type: String?
    var baseExperience: Int?
    var evolutionChain: [[String: AnyObject]]?
    var evoArray: [Pokemon]?
    
    init(id: Int, dictionary: [String: AnyObject]) {
        self.id = id
        
        if let name = dictionary["name"] as? String {
            self.name = name
        }
        
        if let imageUrl = dictionary["imageUrl"] as? String {
            self.imageUrl = imageUrl
        }
        
        if let weight = dictionary["weight"] as? Int {
            self.weight = weight
        }
        
        if let height = dictionary["height"] as? Int {
            self.height = height
        }
        
        if let attack = dictionary["attack"] as? Int {
            self.attack = attack
        }
        
        if let defense = dictionary["defense"] as? Int {
            self.defense = defense
        }
        
        if let description = dictionary["description"] as? String {
            self.description = description
        }
        
        if let type = dictionary["type"] as? String {
            self.type = type
        }
        
        if let baseExperience = dictionary["baseExperience"] as? Int {
            self.baseExperience = baseExperience
        }
        
        if let evolutionChain = dictionary["evolutionChain"] as? [[String: AnyObject]] {
            self.evolutionChain = evolutionChain
        }
    }
}
