//
//  DetailViewController.swift
//  AndersenRickAndMorty
//
//  Created by Илья Москалев on 09.08.2021.
//

import UIKit

class DetailViewController: UIViewController {
    private var objects = [Package]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }}}
    
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
        // Кастомная иконка фильтра, если выбран Characters
        if title == "Characters" {
            self.navigationItem.rightBarButtonItem = UIFabric.shared().makeBarButton(self, action: #selector(openFilterDetail), imageName: "filterIcon2x", size: CGSize(width: 30, height: 30))
        }
        // Убираем слова из кнопки назад
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    //MARK: Navigation
    // Навигация к FilterViewController - экрану фильтра
    @objc private func openFilterDetail() {
        let vc = FilterViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: Networking
    //TODO: Вынести всю логику фильтрации в отдельный класс Model
    // Переменная отобращающее общее количество элементов по запросу
    private var totalObjectsCount: Int?
    // Переменная отображающая статус загрузки новых элементов из API
    var isLoading = false
    // Переменная в которой хранится следующая страница загрузки из API
    private var nextPageToLoad: String?
    // Метод по загрузке первой страницы (20 объектов) из API
    private func loadData() {
        guard let title = title else { return }
        guard let searchText = searchController.searchBar.text else { return }
        // Если мы не производим фильтрацию, то загрузка идет по обычному сценарию
        if !isFiltering {
            DispatchQueue.global().async {
                let url = NetManager.shared().getUrl(from: title)
                NetManager.shared().fetchFilterDataPage(url: url) { objects, nextPage, totalObjects in
                    self.objects = objects!
                    self.nextPageToLoad = nextPage
                    self.totalObjectsCount = totalObjects
        }}} else {
        // Если фильтрация идет, то перенаправляем objects в filteredObjects и меняем URL по внутренней логике NetManager.getUrl
            DispatchQueue.global().async {
                // Создаем URL из метода NetManager + текст из searchBar
                let url = NetManager.shared().getUrl(from: title, isFiltering: true) + searchText
                NetManager.shared().fetchFilterDataPage(url: url) { objects, nextPage, totalObjects in
                    guard let objects = objects else {
                        self.filteredObjects.removeAll()
                        return
                    } // Необходимая проверка для логики обновления данных на экране
                    if self.filteredObjects.isEmpty {
                        self.filteredObjects += objects
                    } else {
                        self.filteredObjects = objects
                    }
                    self.nextPageToLoad = nextPage
                    self.totalObjectsCount = totalObjects
        }}}}
    // Метод загрузки всех следующих страницы из API (по 20 объектов на страницу)
    private func loadNextPage() {
        DispatchQueue.global().async {
            if let url = self.nextPageToLoad {
                NetManager.shared().fetchFilterDataPage(url: url) { [weak self] objects, nextPage, totalObjects in
                    guard let strongSelf = self else { return }
                    strongSelf.isLoading = false
                    print("Is loading: false - nextPage")
                    guard let objects = objects else { return }
                    strongSelf.nextPageToLoad = nextPage
                    strongSelf.totalObjectsCount = totalObjects
                    DispatchQueue.main.async {
                        if !self!.isFiltering {
                            DispatchQueue.global().async {
                                strongSelf.objects += objects
                            }
                        } else {
                            DispatchQueue.global().async {
                                strongSelf.filteredObjects += objects
    }}}}}}}
    
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
        // Когда коллекция загрузилась, останавливаем activity indicator
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
    private var filteredObjects = [Package]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
    }}}
    // Для отслеживания изменений в тексте search bar
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
        searchController.searchBar.delegate = self
        // Не скрывать контроллер, где будут отображены результаты
        searchController.obscuresBackgroundDuringPresentation = false
        // Что будет в placeholder
        searchController.searchBar.placeholder = "Введите имя"
        // Добавляем в навигационную панель
        navigationItem.searchController = searchController
        // При переходе на другой контроллер search скроется
        definesPresentationContext = true
        // По нажатию на searchBar оставляет его на месте, запрещает подъем выше в NavigationBar
        searchController.hidesNavigationBarDuringPresentation = false
    }
    
    private var timer: Timer?
}

//MARK: Extensions
extension DetailViewController: UISearchBarDelegate {
    // Осуществляется запрос API по имени, введенном в searchBar после завершения ввода
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //MARK: Баг, нужно сравнить количество в массиве с количеством всего элементов
        if filteredObjects.count == totalObjectsCount {
            self.isLoading = true
            print("Is loading: true - searchBar")
        } else {
            self.isLoading = false
            print("Is loading: false - searchBar")
        }
        
        // Если searchBar не пуст, то идет загрузка фильтрованного метода
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
            self.loadData()
        })
    }}

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
            }}
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
        // В зависимости от того, фильтруется что-то в searchBar или нет, выбирается объект для передачи в DetailObjectScreen
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
    
    // Когда скролл упирается снизу, вызывается этот метод для загрузки следующей страницы данных из API
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !self.isLoading && (collectionView.contentOffset.y >= (collectionView.contentSize.height - collectionView.frame.size.height)) {
            self.isLoading = true
            
            print("Is loading: true - scroll")
            // В зависимости от того, фильтруется что-то в searchBar или нет вызываются разные методы для загрузки
            if !isFiltering {
                if objects.count == totalObjectsCount {
                    isLoading = false
                } else {
                    self.loadNextPage()
                }
            } else {
                if filteredObjects.count == totalObjectsCount {
                    isLoading = false
                } else {
                    self.loadNextPage()
                }
                print("isFiltering")
    }}}}
