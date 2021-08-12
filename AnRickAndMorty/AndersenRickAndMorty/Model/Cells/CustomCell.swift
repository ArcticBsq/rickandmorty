//
//  CustomCell.swift
//  AndersenRickAndMorty
//
//  Created by Илья Москалев on 10.08.2021.
//

import UIKit

class CustomCell: UICollectionViewCell {
    // Заднее изображение
    let backG: UIImageView = {
       let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        //MARK: Тест uiimage
        iv.image = UIImage(named: "noResponsePic")
        iv.layer.cornerRadius = ViewMetrics.corner
        return iv
    }()
    // Переднее изображение, белая прослойка
    let foreG: UIImageView = {
        let iv = UIImageView()
         iv.translatesAutoresizingMaskIntoConstraints = false
         iv.contentMode = .scaleAspectFill
         iv.clipsToBounds = true
         let image = UIImage(named: "white")
         let alphaImage = UIGraphicsImageRenderer(size: image?.size ?? .zero, format: UIGraphicsImageRendererFormat()).image { _ in
            image?.draw(at: CGPoint.zero, blendMode: .normal, alpha: 0.5)
         }
         iv.image = alphaImage
         return iv
    }()
    // Лейбл названия элемента
    let label: UILabel = {
        let label = UILabel()
        label.text = "Morty"
         label.textColor = .black
         label.font = UIFont.systemFont(ofSize: 20)
         label.textAlignment = .center
         label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
         return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupview() {
        contentView.addSubview(backG)
        contentView.addSubview(foreG)
        contentView.addSubview(label)
        
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
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}
