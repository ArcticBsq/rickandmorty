//
//  UIElements.swift
//  AndersenRickAndMorty
//
//  Created by Илья Москалев on 17.08.2021.
//

import UIKit

class UIFabric {
    
    static func shared() -> UIFabric {
        return UIFabric()
    }
    
    private init() { }
    
    func createButtonStack(title: String, image: String, selector: Selector) -> UIView {
        
        let view: UIView = {
           let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.layer.cornerRadius = ViewMetrics.corner
            view.clipsToBounds = true
            
            let button = UIButton()
            button.setImage(UIImage(named: image), for: .normal)
            button.layer.cornerRadius = ViewMetrics.corner
            button.clipsToBounds = true
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: selector, for: .touchUpInside)
            button.setTitle(title, for: .normal)
            
           
            
            let label: UILabel = {
               let label = UILabel()
                label.text = title
                label.textColor = .black
                label.font = UIFont.systemFont(ofSize: 28)
                label.textAlignment = .center
                label.translatesAutoresizingMaskIntoConstraints = false
                return label
            }()
            //MARK: магия с белым слоем
            let image = UIImage(named: "white")
            let alphaImage = UIGraphicsImageRenderer(size: image?.size ?? .zero, format: UIGraphicsImageRendererFormat()).image { _ in
                image?.draw(at: CGPoint.zero, blendMode: .normal, alpha: 0.5)
            }
            
            let imageview: UIImageView = {
               let imgv = UIImageView()
                imgv.image = alphaImage
                imgv.translatesAutoresizingMaskIntoConstraints = false
                imgv.layer.cornerRadius = ViewMetrics.corner
                imgv.clipsToBounds = true
                return imgv
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
}
