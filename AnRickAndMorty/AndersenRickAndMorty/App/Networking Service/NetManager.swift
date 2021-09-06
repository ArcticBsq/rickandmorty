//
//  NetManager.swift
//  AndersenRickAndMorty
//
//  Created by Илья Москалев on 18.08.2021.
//

import UIKit

class NetManager {
    static let shared = NetManager()
    // Метод загрузки данных из API
    func fetchFilterDataPage(url: String, completion: @escaping ([Package]?, String?, Int?) -> ()) {
        guard let url = URL(string: url) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, resp, error in
            guard let data = data else {
                print("data was nil")
                return
            }
            
            guard let list = try? JSONDecoder().decode(Response.self, from: data) else {
                print("Couldn't decode JSON")
                let result = [Package]()
                let nextPage: String? = nil
                let totalObjects: Int? = nil
                completion(result, nextPage, totalObjects)
                return
            }
            
            let result = list.results
            let nextPage = list.info.next
            let totalObjects = list.info.count
            completion(result, nextPage, totalObjects)
        }
        task.resume()
    }
    
    func isResponse(url: String, completion: @escaping ((Bool) -> ())) {
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard response != nil else {
                completion(false)
                return
            }
            completion(true)
        }.resume()
    }
    
    //MARK: DetailViewController
    // Метод оперделяет нужный URL по ViewController.title
    func getUrl(from title: String, isFiltering: Bool = false) -> String {
        if isFiltering {
            switch title {
            case "Characters":
                return APIconstants.charactersFilterName
            case "Locations":
                return APIconstants.locationsFilterName
            case "Episodes":
                return APIconstants.episodesFilterName
            default:
                print("Incorrect word in switch statement in DetailVC")
                break
            }
        } else {
            switch title {
            case "Characters":
                return APIconstants.characters
            case "Locations":
                return APIconstants.locations
            case "Episodes":
                return APIconstants.episodes
            default:
                print("Incorrect word in switch statement in DetailVC")
                break
        }}
        return ""
    }
    
    private init() {}
}
