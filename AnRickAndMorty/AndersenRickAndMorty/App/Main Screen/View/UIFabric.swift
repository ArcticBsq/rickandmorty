//
//  UIElements.swift
//  AndersenRickAndMorty
//
//  Created by Илья Москалев on 17.08.2021.
//

import UIKit

class UIFabric {
    // Синглтон, почему бы и нет
    static func shared() -> UIFabric {
        return UIFabric()
    }
    
    private init() { }
    
    //MARK: магия с белым слоем
    func imageOpacity(image: String) -> UIImage {
        let img = UIImage(named: image)
        let alphaImage = UIGraphicsImageRenderer(size: img?.size ?? .zero, format: UIGraphicsImageRendererFormat()).image { _ in
            img?.draw(at: CGPoint.zero, blendMode: .normal, alpha: 0.5)
        }
        return alphaImage
    }
    
    //MARK: функция по созданию начинки для кнопок стартового меню
    // по составу: UIView -> Uibutton -> UIImageView -> UILabel
    func createButton(title: String, image: String, selector: Selector) -> UIView {
        
        let view: UIView = {
            
        // 1 создаем нижний слой uiview
           let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.layer.cornerRadius = ViewMetrics.corner
            view.clipsToBounds = true
            
        // 2 создаем средний слой uibutton
            let button = UIButton()
            button.setImage(UIImage(named: image), for: .normal)
            button.layer.cornerRadius = ViewMetrics.corner
            button.clipsToBounds = true
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: selector, for: .touchUpInside)
            button.setTitle(title, for: .normal)
            
        // 3 создаем верхний слой uimageview
            let imageview: UIImageView = {
                // Делаем картинку бледной
                let image = imageOpacity(image: "white")
                
               let imgv = UIImageView()
                imgv.image = image
                imgv.translatesAutoresizingMaskIntoConstraints = false
                imgv.layer.cornerRadius = ViewMetrics.corner
                imgv.clipsToBounds = true
                return imgv
            }()
            
        // 4 верхушка айсберга uilabel
            let label: UILabel = {
               let label = UILabel()
                label.text = title
                label.textColor = .black
                label.font = UIFont.systemFont(ofSize: 28)
                label.textAlignment = .center
                label.translatesAutoresizingMaskIntoConstraints = false
                return label
            }()
            
            view.addSubview(button)
            view.addSubview(imageview)
            view.addSubview(label)
            
            NSLayoutConstraint.activate([
                button.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                button.topAnchor.constraint(equalTo: view.topAnchor),
                button.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                button.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                
                imageview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                imageview.topAnchor.constraint(equalTo: view.topAnchor),
                imageview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                imageview.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                
                label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                label.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
                label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
            ])
                return view
            }()
        return view
    }
    
    //MARK: создание stackView
    func makeAStack(with views: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = .vertical
        stackView.spacing = 30
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
    
    func makeActivityIndicator() -> UIActivityIndicatorView {
        let view = UIActivityIndicatorView(style: .large)
        return view
    }
    
}
