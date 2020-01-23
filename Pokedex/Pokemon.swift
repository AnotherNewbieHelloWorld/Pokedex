//
//  Pokemon.swift
//  Pokedex
//
//  Created by Apple User on 12.01.2020.
//  Copyright © 2020 Alena Khoroshilova. All rights reserved.
//

import Foundation

struct PokemonList: Codable{
    let results: [Pokemon]
}

struct Pokemon: Codable{
    let name: String
    let url: String
}

// Structs for the PokemonViewController
struct PokemonData: Codable{
    let id: Int
    let types: [PokemonTypeEntry]
}

struct PokemonType: Codable{
    let name: String
    let url: String
}

struct PokemonTypeEntry: Codable{
    let slot: Int
    let type: PokemonType
}
