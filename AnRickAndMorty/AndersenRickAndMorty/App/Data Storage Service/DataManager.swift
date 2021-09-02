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
    
    func saveToDefaults(_ object: Any, for key: String) {
        defaults.set(object, forKey: key)
    }
    
    func attachBoolToDefaults(_ status: Bool, for key: String) {
        defaults.setValue(status, forKey: key)
    }
    
    func loadStringFromDefaults(from key: String) -> String? {
        let result = defaults.string(forKey: key)
        return result
    }
    
    func loadBoolFromDefaults(from key: String) -> Bool? {
        let result = defaults.bool(forKey: key)
        return result
    }
    
    func deleteFromDefaults(from key: String) {
        defaults.removeObject(forKey: key)
    }
}
