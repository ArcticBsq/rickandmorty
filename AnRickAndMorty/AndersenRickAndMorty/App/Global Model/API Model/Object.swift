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
    // Character
    let name: String
    let image: String?
    let status: String?
    let gender: String?
    let species: String?
    // Location
    let dimension: String?
    let type: String?
    // Episode
    let air_date: String?
    
}

struct information: Codable {
    let next: String?
    let prev: String?
    let pages: Int
}

struct Response: Codable {
    var info: information
    var results: [Package]
}
