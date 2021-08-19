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
    
    func makeView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = ViewMetrics.corner
        view.clipsToBounds = true
        
        return view
    }
    
    func makeButton() -> UIButton {
        let button = UIButton()
        button.layer.cornerRadius = ViewMetrics.corner
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    func makeImageView() -> UIImageView {
        let imgv = UIImageView()
        imgv.translatesAutoresizingMaskIntoConstraints = false
        imgv.layer.cornerRadius = ViewMetrics.corner
        imgv.clipsToBounds = true
        return imgv
    }
    
    func makeLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 28)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
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
        view.hidesWhenStopped = true
        return view
    }
    
    
    
}
