//
//  ViewController.swift
//  AndersenRickAndMorty
//
//  Created by Илья Москалев on 04.08.2021.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = #colorLiteral(red: 0.1365897357, green: 0.1572630107, blue: 0.1870015562, alpha: 1)
        self.title = "Choose section"
        
        setupMainScreen()
    }
    
    private func setupMainScreen() {
        // Делаем кнопочки
        let charView = UIFabric.shared().createButton(title: "Characters", image: "charactersPic", selector: #selector(openDetail))
        let locView = UIFabric.shared().createButton(title: "Locations", image: "locationsPic", selector: #selector(openDetail))
        let epiView = UIFabric.shared().createButton(title: "Episodes", image: "episodesPic", selector: #selector(openDetail))
        // Делаем stackView из кнопочек
        let labelStackView = UIFabric.shared().makeAStack(with: [charView, locView, epiView])
        
        view.addSubview(labelStackView)
        NSLayoutConstraint.activate([
            labelStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            labelStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            labelStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            labelStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        ])
    }
    
    // Навигация
    @objc func openDetail(_ sender: UIButton) {
        let vc = DetailViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        vc.titleText = sender.currentTitle
    }

}

