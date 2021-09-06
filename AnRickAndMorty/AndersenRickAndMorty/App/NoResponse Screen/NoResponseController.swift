//
//  NoResponseController.swift
//  AndersenRickAndMorty
//
//  Created by Илья Москалев on 03.09.2021.
//

import UIKit

class NoResponseController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Colors.systemBack
        setupView()
    }
    
    let imageView = UIFabric.shared.makeImageView()
    let topLabel = UIFabric.shared.makeLabel()
    let botLabel = UIFabric.shared.makeLabel()
    
    private func setupView() {
        imageView.image = UIImage(named: "noResponsePic")
        view.addSubview(imageView)
        setupTopLabel()
        setupBotLabel()
        let stack = UIFabric.shared.makeAStack(with: [topLabel, botLabel], distribution: .equalSpacing, spacing: 10)
        view.addSubview(stack)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 75),
            imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            imageView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.6),
            
            stack.leadingAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            stack.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            

        ])
    }

    private func setupTopLabel() {
        
        topLabel.text = "Look, Morty!"
        topLabel.font = UIFont.boldSystemFont(ofSize: 24)
        topLabel.textColor = Colors.systemGreen
    }
    
    private func setupBotLabel() {
        
        botLabel.text = "There's nothing there!"
        botLabel.font = UIFont.boldSystemFont(ofSize: 24)
        botLabel.textColor = Colors.systemGreen
    }
}
