//
//  DataManager.swift
//  AndersenRickAndMorty
//
//  Created by Илья Москалев on 31.08.2021.
//

import Foundation

class DataManager {
    
    static func shared() -> DataManager {
        return DataManager()
    }
    
    private init() { }
    
    private let defaults = UserDefaults.standard
    
    func saveToDefaults(_ word: String, for key: String) {
        defaults.setValue(word, forKey: key)
    }
    
    func loadFromDefaults(from key: String) -> String? {
        let result = defaults.string(forKey: key)
        return result
    }
    
    func deleteFromDefaults(from key: String) {
        defaults.removeObject(forKey: key)
    }
}
