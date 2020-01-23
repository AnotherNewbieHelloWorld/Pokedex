//
//  ViewController.swift
//  Pokedex
//
//  Created by Apple User on 12.01.2020.
//  Copyright © 2020 Alena Khoroshilova. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var pokemon: [Pokemon] = []
    
    // Now we gonna capitalize the first letter in a Pokemon name
    func capitalize(text: String) -> String{
        // bulbasaur: 'b' -> 'B', 'B' + 'ulbasaur'
        return text.prefix(1).uppercased() + text.dropFirst()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Work with API
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=151")
        guard let u = url else { return }
        
        // Closure
        // In closures we use self.something
        URLSession.shared.dataTask(with: u) { (data, response, error) in
            guard let data = data else { return }
            
            do{
                let pokemonList = try JSONDecoder().decode(PokemonList.self, from: data)
                self.pokemon = pokemonList.results
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            catch let error{
                print("\(error)")
            }
        }.resume()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemon.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        cell.textLabel?.text = capitalize(text: pokemon[indexPath.row].name)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "PokemonSegue"{
            if let destination = segue.destination as? PokemonViewController{
                destination.pokemon = pokemon[tableView.indexPathForSelectedRow!.row]
            }
        }
    }
}

