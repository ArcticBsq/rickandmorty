//
//  UIElements.swift
//  AndersenRickAndMorty
//
//  Created by Илья Москалев on 17.08.2021.
//

import UIKit

// В этом классе собрано все для создания UI элементов. Можно было бы в extension, но хотелось попрактиковать singleton
class UIFabric {
    // Синглтон, почему бы и нет
    static func shared() -> UIFabric {
        return UIFabric()
    }
    
    private init() { }
    
    func makeView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = ViewMetrics.corner
        view.clipsToBounds = true
        
        return view
    }
    
    func makeButton(backColor: UIColor? = nil, text: String, textColor: UIColor?, textActiveColor: UIColor? = Colors.systemGreen) -> UIButton {
        let button = UIButton()
        button.layer.cornerRadius = ViewMetrics.corner
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = backColor
        button.setTitle(text, for: .normal)
        button.setTitleColor(textColor, for: .normal)
        button.setTitleColor(textActiveColor, for: .selected)
        return button
    }
    
    func makeImageView() -> UIImageView {
        let imgv = UIImageView()
        imgv.translatesAutoresizingMaskIntoConstraints = false
        imgv.layer.cornerRadius = ViewMetrics.corner
        imgv.clipsToBounds = true
        return imgv
    }
    
    func makeLabel(text: String? = nil, textColor: UIColor = Colors.systemBlack, fontSize: CGFloat = 28, textAlignment: NSTextAlignment = .center) -> UILabel {
        let label = UILabel()
        label.textColor = textColor
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.textAlignment = textAlignment
        label.text = text
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    func makeAStack(with views: [UIView], axis: NSLayoutConstraint.Axis = .vertical, distribution: UIStackView.Distribution, alignment: UIStackView.Alignment = .fill, spacing: CGFloat = 30) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = axis
        stackView.spacing = spacing
        stackView.distribution = distribution
        stackView.alignment = alignment
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
    
    func makeActivityIndicator() -> UIActivityIndicatorView {
        let view = UIActivityIndicatorView(style: .large)
        view.hidesWhenStopped = true
        return view
    }
    
    // Кастомная кнопка с image для nav bar
    func makeBarButton(_ target: Any?, action: Selector, imageName: String, size: CGSize) -> UIBarButtonItem {
        let button = UIButton(type: .system)
        
        button.setImage(UIImage(named: imageName), for: .normal)
        button.addTarget(target, action: action, for: .touchUpInside)

        let menuBarItem = UIBarButtonItem(customView: button)
        menuBarItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        menuBarItem.customView?.heightAnchor.constraint(equalToConstant: size.height).isActive = true
        menuBarItem.customView?.widthAnchor.constraint(equalToConstant: size.width).isActive = true

        return menuBarItem
    }
    
    func makeCollectionView(scroll: UICollectionView.ScrollDirection, backColor: UIColor, cellIdentifier: String) -> UICollectionView {
           let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = scroll
            let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
            cv.translatesAutoresizingMaskIntoConstraints = false
            cv.backgroundColor = backColor
            // Регистрируем cell для object
            cv.register(CustomCell.self, forCellWithReuseIdentifier: cellIdentifier)
            return cv
    }
}
