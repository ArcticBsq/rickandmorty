//
//  ModelDetail.swift
//  AndersenRickAndMorty
//
//  Created by Илья Москалев on 03.09.2021.
//

import Foundation

class ModelDetail {
//    var objects = [Package]()
//    var filteredObjects = [Package]()
//    
//    private var totalObjectsCount: Int?
//    // Переменная отображающая статус загрузки новых элементов из API
//    var isLoading = false
//    // Переменная в которой хранится следующая страница загрузки из API
//    private var nextPageToLoad: String?
//    // Метод по загрузке первой страницы (20 объектов) из API
//    private func loadData(title: String, searchText: String, isSearching: Bool, isFiltering: Bool) {
//        var url = ""
//        // Если мы не производим поиск, то загрузка идет по обычному сценарию
//        if !isSearching { url = NetManager.shared().getUrl(from: title) }
//        // Если поиск идет, то переключаем URL на поисковой путем выставления в методе getUrl isFiltering = true
//        else { url = NetManager.shared().getUrl(from: title, isFiltering: true) + searchText }
//        
//        var getObjects: [Package]? {
//            didSet {
//                guard let array = getObjects else {
//                    if !isFiltering {
//                        self.objects.removeAll()
//                    } else {
//                        self.objects.removeAll()
//                        self.filteredObjects.removeAll()
//                    }
//                    return
//                }
//                if !isFiltering {
//                    self.objects = array
//                } else {
//                    self.objects = array
//                    self.filteredObjects = self.filterContentWithSettings(self.objects)
//                    if self.filteredObjects.count < 8 {
//                        self.loadNextPage()
//         }}}
//        }
//        
//        DispatchQueue.global().async {
//            NetManager.shared().fetchFilterDataPage(url: url) { objects, nextPage, totalObjects in
//                guard let _objects = objects else {
//                    self.objects.removeAll()
//                    return
//                }
//                self.nextPageToLoad = nextPage
//                self.totalObjectsCount = totalObjects
//                getObjects = _objects
//                
//    }}}
    
//    private func loadNextPage(isFiltering: Bool) {
//            if let url = self.nextPageToLoad {
//                var getObjects: [Package]?{
//                    didSet {
//                        guard let array = getObjects else {
//                            if !isFiltering {
//                                self.objects.removeAll()
//                            } else {
//                                self.objects.removeAll()
//                                self.filteredObjects.removeAll()
//                            }
//                            return
//                        }
//                        if !isFiltering {
//                            self.objects = array
//                        } else {
//                            self.objects = array
//                            self.filteredObjects = self.filterContentWithSettings(self.objects)
//                            if self.filteredObjects.count < 8 {
//                                self.loadNextPage(isFiltering: isFiltering)
//                 }}}
//                }
//                NetManager.shared().fetchFilterDataPage(url: url) { [weak self] objects, nextPage, totalObjects in
//                    guard let strongSelf = self else { return }
//                    strongSelf.isLoading = false
//                    print("Is loading: false - nextPage")
//                    guard let _objects = objects else { return }
//                    strongSelf.nextPageToLoad = nextPage
//                    strongSelf.totalObjectsCount = totalObjects
//                    getObjects = _objects
//                    DispatchQueue.main.async {
//                        if !isFiltering {
//                            DispatchQueue.global().async {
//                                strongSelf.objects += objects
//                            }
//                        } else {
//                            DispatchQueue.global().async {
//                                strongSelf.objects += objects
//                                strongSelf.filteredObjects = strongSelf.filterContentWithSettings(strongSelf.objects)
//    }}}}}}
}
