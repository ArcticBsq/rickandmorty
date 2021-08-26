//
//  DetailViewController.swift
//  AndersenRickAndMorty
//
//  Created by Илья Москалев on 09.08.2021.
//

import UIKit

class DetailViewController: UIViewController {
    private var objects = [Package]()
    
    // Переменная отображающая статус загрузки новых элементов из API
    var isLoading = false {
        didSet {
            print(isLoading)
        }
    }
    // Переменная в которой хранится следующая страница загрузки из API
    private var nextPageToLoad: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.systemBack
        // 1 activity indicator
        loadIndicator()
        // 2 загрузка из API
        loadData()
        // 3 загрузка search controller
        setupSearchController()
        // 4 загрузка коллекции
        loadCollection()
        // Кастомная иконка фильтра
        self.navigationItem.rightBarButtonItem = UIFabric.shared().makeBarButton(self, action: #selector(openFilterDetail), imageName: "filterIcon2x", size: CGSize(width: 30, height: 30))
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    //MARK: Navigation
    // Навигация к FilterViewController - экрану фильтра
    @objc private func openFilterDetail() {
        let vc = FilterViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: Networking
    private func loadData() {
        NetManager.shared().fetchData(url: NetManager.shared().getUrl(from: title!)) { objects, nextPage in
            self.objects = objects
            self.nextPageToLoad = nextPage
        }
    }
    
    //MARK: UI
    // создание collection view
    private let collectionView = UIFabric.shared().makeCollectionView(scroll: .vertical, backColor: Colors.systemBack, cellIdentifier: "cell")
    
    // Настройка collection view
    private func loadCollection() {
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        activityIndicator.stopAnimating()
    }
    
    // activity indicator
    private let activityIndicator = UIFabric.shared().makeActivityIndicator()
    
    private func loadIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.center = self.view.center
        activityIndicator.startAnimating()
    }
    
    //MARK: Search Controller
    private var filteredObjects = [Package]()
    // Для отслеживания изменений в тексте searc bar
    private var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    // Для отслеживания состояния фильтрации, True если идет поиск
    private var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }
    // Функция возвращает отфилтрованный массив по критерию - "Содержится в имени object"
    private func filterContentForSearchText(_ searchText: String) {
      filteredObjects = objects.filter { (object: Package) -> Bool in
        return object.name.lowercased().contains(searchText.lowercased())
      }
      
      collectionView.reloadData()
        //MARK: Bug
        // дважды перезагружает, когда нажимается Cancel
        print("Reloaded")
    }

    private let searchController = UISearchController(searchResultsController: nil)
    private func setupSearchController() {
        // Информирует о любых изменениях текста
        searchController.searchResultsUpdater = self
        // Не скрывать контроллер, где будут отображены результаты
        searchController.obscuresBackgroundDuringPresentation = false
        // Что будет в placeholder
        searchController.searchBar.placeholder = "Введите имя"
        // Добавляем в навигационную панель
        navigationItem.searchController = searchController
        // При переходе на другой контроллер search скроется
        definesPresentationContext = true
    }
}










//MARK: Extensions
extension DetailViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
        print("updateSearchResults")
    }
}

extension DetailViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width-15)/2, height: collectionView.frame.width/1.8)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFiltering {
            return filteredObjects.count
        }
        return objects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell

        let object: Package
        
        if isFiltering {
            object = filteredObjects[indexPath.row]
        } else {
            object = objects[indexPath.row]
        }
        
        switch title {
        case "Characters":
            cell.label.text = object.name
            NetManager.shared().loadImage(from: object) { image in
                DispatchQueue.main.async {
                    cell.backG.image = image
                }
            }
        case "Locations":
            cell.label.text = object.name
        case "Episodes":
            cell.label.text = "\(object.id). \(object.name)"
        default:
            print("error")
        }
                
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let object: Package
        
        if isFiltering {
            object = filteredObjects[indexPath.row]
        } else {
            object = objects[indexPath.row]
        }
        let vc = DetailObjectController()
        self.navigationController?.pushViewController(vc, animated: true)
        vc.avatar = object
        let cell = collectionView.cellForItem(at: indexPath) as! CustomCell
        vc.image = cell.backG.image
    }
    
}
