//
//  CustomCell.swift
//  AndersenRickAndMorty
//
//  Created by Илья Москалев on 10.08.2021.
//

import UIKit

let imageCache = NSCache<NSString, AnyObject>()

class CustomCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Заднее изображение для картинки из API
    let backG = UIFabric.shared.makeImageView()
        
    // Переднее изображение, белая прослойка
    let foreG: UIImageView = {
        let iv = UIFabric.shared.makeImageView()
        iv.layer.cornerRadius = 0
        iv.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        return iv
    }()
    
    // Лейбл названия элемента
    let label: UILabel = {
        let label = UIFabric.shared.makeLabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
         return label
    }()
    
    let loadingIndicator = UIFabric.shared.makeActivityIndicator()
    
    var object: Package?
    
    private func displayObject(_ object: Package?) {
      self.object = object
      if let object = object {
        if object.air_date != nil {
            label.text = "\(object.id). \(object.name)"
        } else {
            label.text = object.name
        }
        if object.gender != nil {
            backG.cacheImage(url: URL(string: object.image!)!)
        }
        label.alpha = 1
        backG.alpha = 1
        foreG.alpha = 1
        loadingIndicator.alpha = 0
        loadingIndicator.stopAnimating()
        backgroundColor = Colors.systemWhite
      } else {
        label.alpha = 0
        backG.alpha = 0
        foreG.alpha = 0
        loadingIndicator.alpha = 1
        loadingIndicator.startAnimating()
        backgroundColor = Colors.systemWhite
    }}
    
    override func prepareForReuse() {
        DispatchQueue.main.async {
            self.displayObject(.none)
    }}
    
    func updateAppearanceFor(_ object: Package?, animated: Bool = true) {
      DispatchQueue.main.async {
        if animated {
          UIView.animate(withDuration: 0.5) {
            self.displayObject(object)
          }
        } else {
            self.displayObject(object)
    }}}
    
    private func setupview() {
        contentView.addSubview(backG)
        contentView.addSubview(foreG)
        contentView.addSubview(label)
        contentView.addSubview(loadingIndicator)
        self.layer.cornerRadius = 25
        self.clipsToBounds = true
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backG.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backG.topAnchor.constraint(equalTo: contentView.topAnchor),
            backG.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backG.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            foreG.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            foreG.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            foreG.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            foreG.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -80),
            
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            label.topAnchor.constraint(equalTo: foreG.topAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            loadingIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
}}

extension UIImageView {
  func cacheImage(url: URL){
    
    image = nil
    
    if let imageFromCache = imageCache.object(forKey: url.absoluteString as NSString) as? UIImage {
        self.image = imageFromCache
        print("Got it from cash")
        return
    } else {
        URLSession.shared.dataTask(with: url) { data, resp, error in
            guard let data = data, error == nil else { return }
            
            let imageToCache = UIImage(data: data)
            imageCache.setObject(imageToCache!, forKey: url.absoluteString as NSString)
            DispatchQueue.main.async {
                self.image = imageToCache
            }
        }.resume()
    }
  }
}
