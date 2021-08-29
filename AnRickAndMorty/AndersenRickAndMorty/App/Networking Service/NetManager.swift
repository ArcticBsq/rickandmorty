//
//  NetManager.swift
//  AndersenRickAndMorty
//
//  Created by Илья Москалев on 18.08.2021.
//

import UIKit

class NetManager {
    static func shared() -> NetManager {
        return NetManager()
    }
    
//    func fetchData(url: String, completion: @escaping ([Package], String) -> Void) {
//        DispatchQueue.global().async {
//            guard let url = URL(string: url) else { return }
//            
//            let task = URLSession.shared.dataTask(with: url) { data, resp, error in
//                guard let data = data else {
//                    print("data was nil")
//                    return
//                }
//                
//                guard let list = try? JSONDecoder().decode(Response.self, from: data) else {
//                    print("Couldn't decode JSON")
//                    return
//                }
//                
//                let result = list.results
//                let nextPage = list.info.next ?? ""
//                completion(result, nextPage)
//            }
//            task.resume()
//        }
//    }
    
    func fetchDataPage(url: String, page: Int, completion: @escaping ([Package], Int) -> ()) {
        let finalURL = url + String(page)
        
        guard let url = URL(string: finalURL) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, resp, error in
            guard let data = data else {
                print("data was nil")
                return
            }
            
            guard let list = try? JSONDecoder().decode(Response.self, from: data) else {
                print("Couldn't decode JSON")
                return
            }
            let result = list.results
            let allPages = list.info.pages
            completion(result, allPages)
        }
        task.resume()
    }
    
    //MARK: DetailViewController
    func getUrl(from title: String) -> String {
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
        }
        return ""
    }
    
    // Для загрузки картинок, используемых в Collection View Cell
    func loadImage(from: Package, completion: @escaping (UIImage) -> Void) {
        
        DispatchQueue.global().async {
            guard let imgURL = URL(string: from.image!) else {
                print("No image URL")
                return
            }
            guard let imgData = try? Data.init(contentsOf: imgURL) else { return }
            let image = UIImage.init(data: imgData)
            completion(image!)
        }
    }
    
    private init() {}
}
