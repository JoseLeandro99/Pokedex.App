import Foundation
import UIKit

class PokemonService {
    static let shared = PokemonService()
    
    private let base_url = "https://pokedex-bb36f.firebaseio.com/pokemon.json"
    
    private var pokemonArray = [Pokemon]()
    
    func fetchPokemons(completion: @escaping ([Pokemon]) -> Void) {
        guard let url = URL(string: base_url) else {return}
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("failed to fetch data from api with error: ", error.localizedDescription)
                return
            }
            
            guard let data = data else {return}
            
            do {
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: []) as! [AnyObject]
                
                for (key, result) in jsonResult.enumerated() {
                    if let dictionary = result as? [String: AnyObject] {
                        let pokemon = Pokemon(id: key, dictionary: dictionary)
                        
                        guard let imageUrl = pokemon.imageUrl else {return}
                        self.fetchImage(withUrlString: imageUrl) { image in
                            pokemon.image = image
                            self.pokemonArray.append(pokemon)
                         
                            self.pokemonArray.sort(by: { (poke1, poke2) -> Bool in
                                return poke1.id! < poke2.id!
                            })
                            
                            completion(self.pokemonArray)
                        }
                    }
                }
                
            } catch let error {
                print("failed to create json object with error: ", error.localizedDescription)
            }
        }
        
        dataTask.resume()
    }
    
    private func fetchImage(withUrlString: String, completion: @escaping(UIImage) -> Void) {
        guard let url = URL(string: withUrlString) else {return}
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("failed to fetch data from api with error: ", error.localizedDescription)
                return
            }
            
            guard let data = data else {return}
            guard let Image = UIImage(data: data) else {return}
            completion(Image)
        }
        
        task.resume()
    }
}
