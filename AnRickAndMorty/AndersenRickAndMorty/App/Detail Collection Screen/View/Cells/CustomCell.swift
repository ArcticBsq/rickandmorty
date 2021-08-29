//
//  CustomCell.swift
//  AndersenRickAndMorty
//
//  Created by Илья Москалев on 10.08.2021.
//

import UIKit

class CustomCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Заднее изображение
    let backG = UIFabric.shared().makeImageView()
        
    
    // Переднее изображение, белая прослойка
    let foreG: UIImageView = {
        let iv = UIFabric.shared().makeImageView()
        iv.layer.cornerRadius = 0
        iv.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        return iv
    }()
    
    // Лейбл названия элемента
    let label: UILabel = {
        let label = UIFabric.shared().makeLabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
         return label
    }()
    
    private func setupview() {
        contentView.addSubview(backG)
        contentView.addSubview(foreG)
        contentView.addSubview(label)
        self.layer.cornerRadius = 25
        self.backgroundColor = .gray
        self.clipsToBounds = true
        
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