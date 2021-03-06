//
//  DetailViewController.swift
//  AndersenRickAndMorty
//
//  Created by Илья Москалев on 09.08.2021.
//

import UIKit

final class DetailViewController: UIViewController {
    //MARK: Services
    private let dataService = DataManager.shared
    private let networkService = NetManager.shared
    
    // Массив где хранятся объекты, полученные из API
    private var objects = [Package]() {
        didSet {
            DispatchQueue.main.async {
                if !self.isFiltering {
                    self.collectionView.reloadData()
                    print("reload data in Objects")
    }}}}
    
    private var filteredObjects = [Package]() {
        didSet {
            DispatchQueue.main.async {
                if self.isFiltering {
                    self.collectionView.reloadData()
                    print("reload data in FilteredObjects")
    }}}}
    
    private func loadObject(at index: Int) -> Package? {
        var object: Package?
        if isFiltering {
            object = filteredObjects[index]
        } else {
            object = objects[index]
        }
        return object
    }
    var controllerTitle: String?
    
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
            self.navigationItem.rightBarButtonItem = UIFabric.shared.makeBarButton(self, action: #selector(openFilterDetail), imageName: "filterIcon2x", size: CGSize(width: 30, height: 30))
        }
        // Убираем слова из кнопки назад
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    // Первый показ этого контроллера
    var isFirstLoad = true
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        guard let isFilterSettingsChanged = dataService.loadBoolFromDefaults(from: UserDefaultsKeys.filterSettingsChanged) else { return }
        if !isFirstLoad && isFilterSettingsChanged{
            loadData()
        } else {
            isFirstLoad = false
        }
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
        var url = ""
        // Если мы не производим поиск, то загрузка идет по обычному сценарию
        if !isSearching { url = NetManager.shared.getUrl(from: title) }
        // Если поиск идет, то переключаем URL на поисковой путем выставления в методе getUrl isFiltering = true
        else { url = NetManager.shared.getUrl(from: title, isFiltering: true) + searchText }
        
        var getObjects: [Package]? {
            didSet {
                guard let array = getObjects else {
                    self.objects.removeAll()
                    if self.isFiltering {
                        self.filteredObjects.removeAll()
                    }
                    return
                }
                
                self.objects = array
                // Если происходит фильтрация с FilterViewController
                if self.isFiltering {
                    DispatchQueue.global().async {
                        self.filteredObjects = Filter.shared.filterContentWithSettings(self.objects)
                        // Если на экране меньше 8 элементов, происходит загрузка следующей страницы из АПИ
                        // меньше 8 потому что на экране помещается 6 элементов и чтобы грузилась следующая страница
                        // в didScroll методе нужна возможность скрола, она появляется, если 7 элементов и больше
                        if self.filteredObjects.count < 8 && self.objects.count < self.totalObjectsCount ?? 0 {
                            print("Is filtering = \(self.isFiltering)")
                            self.loadNextPage()
                        }
                    }
    }}}
        DispatchQueue.global().async {
            NetManager.shared.fetchFilterDataPage(url: url) { objects, nextPage, totalObjects in
                guard let _objects = objects else {
                    self.objects.removeAll()
                    return
                }
                self.nextPageToLoad = nextPage
                self.totalObjectsCount = totalObjects
                getObjects = _objects
    }}}
    
    // Метод загрузки всех следующих страниц из API
    // если результат фильтрации меньше 1 страницы из 8 объектов, то происходит загрузка следующих страниц
    private func loadNextPage() {
        DispatchQueue.global().async {
            if let url = self.nextPageToLoad {
                var getObjects: [Package]? {
                    didSet {
                        guard let array = getObjects else { return }
                        
                        self.objects = Array(Set(self.objects + array))
                        self.objects.sort {$0.id < $1.id }
                        if self.isFiltering {
                            
                            self.filteredObjects = Filter.shared.filterContentWithSettings(self.objects)
                            if self.filteredObjects.count < 8 {
                                print("Is Filterong = \(self.isFiltering)")
                                self.loadNextPage()
                        }
                        
    }}}
                NetManager.shared.fetchFilterDataPage(url: url) { [weak self] objects, nextPage, totalObjects in
                    guard let strongSelf = self else { return }
                    strongSelf.isLoading = false
                    print("Is loading: false - nextPage")
                    guard let _objects = objects else { return }
                    strongSelf.nextPageToLoad = nextPage
                    strongSelf.totalObjectsCount = totalObjects
                    getObjects = _objects
    }}}}
    
    //MARK: UI
    // создание collection view
    private let collectionView = UIFabric.shared.makeCollectionView(scroll: .vertical, backColor: Colors.systemBack, cellIdentifier: "cell")
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
    private let activityIndicator = UIFabric.shared.makeActivityIndicator()
    
    private func loadIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.center = self.view.center
        activityIndicator.startAnimating()
    }
    
    //MARK: Search Controller
    // Для отслеживания изменений в тексте search bar
    private var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    // Для отслеживания состояния фильтрации, True если происходит фильтрация по gender/status
    private var isFiltering: Bool {
        let result = controllerTitle == "Characters" ? dataService.statusKeyExistsInDefaults() || dataService.genderKeyExistsInDefaults() : false
        return result
    }
    // Ведется ли поиск по имени в NavigationBar
    private var isSearching: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    //MARK: Search controller
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
        if objects.count == totalObjectsCount {
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        if let cell = cell as? CustomCell {
            cell.updateAppearanceFor(.none, animated: false)
            if let object = loadObject(at: indexPath.item) {
                cell.updateAppearanceFor(object, animated: true)
            }
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
            if objects.count == totalObjectsCount {
                isLoading = false
            } else {
                self.loadNextPage()
            }
            
            print("Filtered objects: \(filteredObjects.count)")
            print("Objects : \(objects.count)")
            print("Total : \(totalObjectsCount)")
}}}
