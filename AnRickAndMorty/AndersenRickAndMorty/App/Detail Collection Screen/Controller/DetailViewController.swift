//
//  DetailViewController.swift
//  AndersenRickAndMorty
//
//  Created by Илья Москалев on 09.08.2021.
//

import UIKit

class DetailViewController: UIViewController {
    var objects = [Package]() {
        didSet {
            DispatchQueue.main.async {
                self.loadCollection()
            }
        }
    }
    
    // Переменная куда передается название экрана из предыдущего VC
    var titleText: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Colors.systemBack
        title = titleText
        // 1 activity indicator
        loadIndicator()
        // 2 загрузка из API
        loadObjects()
    }
    
    //MARK: создание collection view
    let collectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = Colors.systemBack
        cv.register(CustomCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()
    
    // Настройка collection view
    private func loadCollection() {
        
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        activityIndicator.stopAnimating()
    }
    
    // Работа с сетью.
    // MARK: Нужно вынести в NetworkManager
    // но при выносе и вызове массив оказывается пустым, не работает
    private func fetchData(from: String) {
        
            guard let url = URL(string: from) else { return }
            
            let task = URLSession.shared.dataTask(with: url) { data, resp, error in
                guard let data = data else {
                    print("data was nil")
                    self.activityIndicator.stopAnimating()
                    return
                }
                
                guard let list = try? JSONDecoder().decode(Response.self, from: data) else {
                    print("Couldn't decode JSON")
                    self.activityIndicator.stopAnimating()
                    return
                }
                let result = list.results
                self.objects += result
            }
            task.resume()
    }
    // MARK: загрузка из API
    // элементов package в массив objects
    private func loadObjects() {
        switch title {
        case "Characters":
            fetchData(from: APIconstants.characters)
        case "Locations":
            fetchData(from: APIconstants.locations)
        case "Episodes":
            fetchData(from: APIconstants.episodes)
        default:
            print("Incorrect word in switch statement in DetailVC")
            break
        }
    }
    
    //MARK: создание activity indicator
    let activityIndicator = UIFabric.shared().makeActivityIndicator()
    
    private func loadIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.center = self.view.center
        activityIndicator.startAnimating()
    }
    
}

//MARK: Extension
extension DetailViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width-15)/2, height: collectionView.frame.width/1.8)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return objects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
        cell.backgroundColor = .gray
        cell.layer.cornerRadius = 25
        cell.clipsToBounds = true

        let object = objects[indexPath.row]
        
        switch title {
        case "Characters":
            cell.label.text = object.name
            DispatchQueue.global().async {
                guard let imgURL = URL(string: object.image!) else {
                    print("No image URL")
                    return
                }
                guard let imgData = try? Data.init(contentsOf: imgURL) else { return }
                
                DispatchQueue.main.async {
                    cell.backG.image = UIImage.init(data: imgData)
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
        let object = objects[indexPath.row]
        let vc = DetailObjectController()
        self.navigationController?.pushViewController(vc, animated: true)
        vc.avatar = object
    }
}
