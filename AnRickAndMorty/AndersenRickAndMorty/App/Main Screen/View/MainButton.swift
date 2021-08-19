//
//  ButtonsView.swift
//  AndersenRickAndMorty
//
//  Created by Илья Москалев on 18.08.2021.
//

import UIKit

class MainButtonView {
    static func shared() -> MainButtonView {
        return MainButtonView()
    }
    
    private init() { }
    //MARK: функция по созданию начинки для кнопок стартового меню
    // по составу: UIView -> Uibutton -> UIImageView -> UILabel
    func createButton(title: String, image: String, selector: Selector) -> UIView {
            
        // 1 создаем нижний слой uiview
        let view = UIFabric.shared().makeView()
            
        // 2 создаем средний слой uibutton
        let button = UIFabric.shared().makeButton()
            button.setImage(UIImage(named: image), for: .normal)
            button.addTarget(self, action: selector, for: .touchUpInside)
            button.setTitle(title, for: .normal)
            
        // 3 создаем верхний слой uimageview
        let imageview = UIFabric.shared().makeImageView()
        // Делаем картинку бледной
        let image = UIFabric.shared().imageOpacity(image: "white")
            imageview.image = image
            
        // 4 верхушка айсберга uilabel
        let label = UIFabric.shared().makeLabel()
            label.text = title
        label.font = UIFont.boldSystemFont(ofSize: ViewMetrics.MainScreenButtonFontSize)
        
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
    }
}
