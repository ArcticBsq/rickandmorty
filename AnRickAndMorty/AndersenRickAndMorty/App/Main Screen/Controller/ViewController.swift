//
//  ViewController.swift
//  AndersenRickAndMorty
//
//  Created by Илья Москалев on 04.08.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = Colors.systemBack
        self.title = "Choose section"
        
        setupMainScreen()
    }
    
    private func setupMainScreen() {
        // Делаем кнопочки
        let charView = MainButtonView.shared().createButton(title: "Characters", image: "charactersPic", selector: #selector(openDetail))
        let locView = MainButtonView.shared().createButton(title: "Locations", image: "locationsPic", selector: #selector(openDetail))
        let epiView = MainButtonView.shared().createButton(title: "Episodes", image: "episodesPic", selector: #selector(openDetail))
        // Делаем stackView из кнопочек
        let buttonsStackView = UIFabric.shared().makeAStack(with: [charView, locView, epiView])
        
        view.addSubview(buttonsStackView)
        NSLayoutConstraint.activate([
            buttonsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            buttonsStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            buttonsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            buttonsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        ])
    }
    
    // Навигация
    @objc func openDetail(_ sender: UIButton) {
        let vc = DetailViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        vc.titleText = sender.currentTitle
    }

    
    
}


