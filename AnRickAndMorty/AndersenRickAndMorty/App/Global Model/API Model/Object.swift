//
//  Character.swift
//  AndersenRickAndMorty
//
//  Created by Илья Москалев on 10.08.2021.
//

import Foundation

struct Package: Codable {
    // Общее для всех
    let id: Int
    let name: String
    let image: String?
    let status: String?
    let gender: String?
    let species: String?
    
    
}

struct Response: Codable {
    var results: [Package]
}
