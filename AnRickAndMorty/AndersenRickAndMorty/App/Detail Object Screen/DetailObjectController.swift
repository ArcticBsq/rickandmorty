//
//  DetailObjectController.swift
//  AndersenRickAndMorty
//
//  Created by Илья Москалев on 18.08.2021.
//

import UIKit

class DetailObjectController: UIViewController {

    var avatar: Package?
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.systemBack
        setupView()
        title = avatar?.name
    }
    
    private func setupView() {
        let pictureView = UIFabric.shared().makeImageView()
        pictureView.image = image

        let globalStack = DetailObjectVCStack.shared().createStack(from: avatar!)
        
        view.addSubview(globalStack)
        view.addSubview(pictureView)
        
        NSLayoutConstraint.activate([
            pictureView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            pictureView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            pictureView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            pictureView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.45),
            
            globalStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            globalStack.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -70),
            globalStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            globalStack.topAnchor.constraint(equalTo: pictureView.bottomAnchor, constant: 20)
        ])
       
    }
}
