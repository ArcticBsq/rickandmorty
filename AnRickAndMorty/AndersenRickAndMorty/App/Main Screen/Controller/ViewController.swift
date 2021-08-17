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
        
        setupView()
    }
    
    private lazy var labelStackView: UIStackView = {
//        let charView = createButtonStack(title: "Characters", image: "charactersPic")
//        let locView = createButtonStack(title: "Locations", image: "locationsPic")
//        let epiView = createButtonStack(title: "Episodes", image: "episodesPic")
        
        let charView = UIFabric.shared().createButtonStack(title: "Characters", image: "charactersPic")
        let locView = UIFabric.shared().createButtonStack(title: "Locations", image: "locationsPic")
        let epiView = UIFabric.shared().createButtonStack(title: "Episodes", image: "episodesPic")
        
        
        
        let stackView = UIStackView(arrangedSubviews: [charView, locView, epiView])
        stackView.axis = .vertical
        stackView.spacing = 30
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private func setupView() {
        view.addSubview(labelStackView)
        NSLayoutConstraint.activate([
            labelStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            labelStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            labelStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            labelStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50)
        ])
    }
    
    @objc func openDetail(_ sender: UIButton) {
        let vc = DetailViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        vc.titleText = sender.currentTitle
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
// MARK: Функция для создания кастомных кнопок
// Убрать куда-нибудь этого монстра
    private func createButtonStack(title: String, image: String) -> UIView {
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
            button.addTarget(self, action: #selector(openDetail), for: .touchUpInside)
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

