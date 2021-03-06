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
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        setupMainScreen()
    }
    
    private func setupMainScreen() {
    // Делаем кнопочки
        let charView = MainButtonView.shared().createButton(title: Titles.character, image: "charactersPic", selector: #selector(openDetail))
        let locView = MainButtonView.shared().createButton(title: Titles.location, image: "locationsPic", selector: #selector(openDetail))
        let epiView = MainButtonView.shared().createButton(title: Titles.episode, image: "episodesPic", selector: #selector(openDetail))
    // Делаем stackView из кнопочек
        let buttonsStackView = UIFabric.shared.makeAStack(with: [charView, locView, epiView], distribution: .fillEqually)
        
        view.addSubview(buttonsStackView)
        NSLayoutConstraint.activate([
            buttonsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            buttonsStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            buttonsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            buttonsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        ])
    }
    
    // Навигация
    @objc func openDetail(_ sender: UIButton) {
        guard let title = sender.currentTitle else { return }
        NetManager.shared.isResponse(url: NetManager.shared.getUrl(from: title)) { isResponse in
            if isResponse {
                DispatchQueue.main.async {
                    let vc = DetailViewController()
                    self.navigationController?.pushViewController(vc, animated: true)
                    vc.title = sender.currentTitle
                    vc.controllerTitle = sender.currentTitle
                }
            } else {
                DispatchQueue.main.async {
                    let vc = NoResponseController()
                    self.navigationController?.pushViewController(vc, animated: true)
                }
    }}}
}


