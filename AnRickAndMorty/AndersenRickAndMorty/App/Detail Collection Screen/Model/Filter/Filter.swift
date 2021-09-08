//
//  ModelDetail.swift
//  AndersenRickAndMorty
//
//  Created by Илья Москалев on 03.09.2021.
//

import Foundation

final class Filter {
    static let shared = Filter()
    
    private init() { }
    private let dataManager = DataManager.shared
    
    func filterContentWithSettings(_ array: [Package]) -> [Package] {
        let status = dataManager.loadStringFromDefaults(from: UserDefaultsKeys.status)
        let gender = dataManager.loadStringFromDefaults(from: UserDefaultsKeys.gender)
        
        let resultArray = array.filter { (object: Package) -> Bool in
            if dataManager.statusKeyExistsInDefaults() && dataManager.genderKeyExistsInDefaults() {
                return object.status?.lowercased() == status && object.gender?.lowercased() == gender
            }
            else if dataManager.statusKeyExistsInDefaults() && !dataManager.genderKeyExistsInDefaults() {
                return object.status?.lowercased() == status
            }
            else if !dataManager.statusKeyExistsInDefaults() && dataManager.genderKeyExistsInDefaults() {
                return object.gender?.lowercased() == gender
            }
            return false
        }
        return resultArray
    }
    
}
