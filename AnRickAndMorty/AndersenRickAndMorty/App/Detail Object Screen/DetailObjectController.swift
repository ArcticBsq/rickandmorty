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
    
    let pictureView = UIFabric.shared().makeImageView()
    
    let idLLabel = UIFabric.shared().makeLabel()
    let idRLabel = UIFabric.shared().makeLabel()
    
    let nameLLabel = UIFabric.shared().makeLabel()
    let nameRLabel = UIFabric.shared().makeLabel()
    
    let statusLLabel = UIFabric.shared().makeLabel()
    let statusRLabel = UIFabric.shared().makeLabel()
    
    let speciesLLabel = UIFabric.shared().makeLabel()
    let speciesRLabel = UIFabric.shared().makeLabel()
    
    let genderLLabel = UIFabric.shared().makeLabel()
    let genderRLabel = UIFabric.shared().makeLabel()
    
    let dimensionLLabel = UIFabric.shared().makeLabel()
    let dimensionRLabel = UIFabric.shared().makeLabel()
    
    let typeLLabel = UIFabric.shared().makeLabel()
    let typeRLabel = UIFabric.shared().makeLabel()
    
    let airDateLLabel = UIFabric.shared().makeLabel()
    let airDateRLabel = UIFabric.shared().makeLabel()
    
    let episodeLLabel = UIFabric.shared().makeLabel()
    let episodeRLabel = UIFabric.shared().makeLabel()
    
    //MARK: Как-то надо вынести во View
    // но проблема со ссылками на переданную переменную avatar
    private func setupView() {
        pictureView.image = image
        
        let globalStack: UIStackView = {
            let stack = UIFabric.shared().makeAStack(with: [])
            
             let idStack: UIStackView = {
                idLLabel.text = "ID: "
                idLLabel.textColor = Colors.systemGreen
                idLLabel.textAlignment = .left
                idLLabel.backgroundColor = .blue
                idLLabel.setContentHuggingPriority(.defaultLow + 1, for: .horizontal)
                idLLabel.font = UIFont.boldSystemFont(ofSize: ViewMetrics.detailObjectFontSize)
                
                idRLabel.text = "\(avatar!.id)"
                idRLabel.textColor = Colors.systemWhite
                idRLabel.textAlignment = .left
                idRLabel.backgroundColor = .red
                idRLabel.font = UIFont.systemFont(ofSize: ViewMetrics.detailObjectFontSize)
                
                let stack = UIFabric.shared().makeAStack(with: [idLLabel, idRLabel])
                stack.axis = .horizontal
                stack.distribution = .fill
                stack.isHidden = true
                
                return stack
            }()
            stack.addArrangedSubview(idStack)
            
             let nameStack: UIStackView = {
                nameLLabel.text = "Name: "
                nameLLabel.textColor = Colors.systemGreen
                nameLLabel.textAlignment = .left
                nameLLabel.setContentHuggingPriority(.defaultLow + 1, for: .horizontal)
                nameLLabel.font = UIFont.boldSystemFont(ofSize: ViewMetrics.detailObjectFontSize)
                
                let name = avatar!.name
                nameRLabel.text = name
                nameRLabel.textAlignment = .left
                nameRLabel.textColor = Colors.systemWhite
                nameRLabel.font = UIFont.systemFont(ofSize: ViewMetrics.detailObjectFontSize)
                
                let stack = UIFabric.shared().makeAStack(with: [nameLLabel, nameRLabel])
                stack.axis = .horizontal
                stack.distribution = .fill
                
                return stack
            }()
            stack.addArrangedSubview(nameStack)
            
            if let status = avatar?.status {
                let statusStack: UIStackView = {
                   statusLLabel.text = "Status: "
                   statusLLabel.textColor = Colors.systemGreen
                    statusLLabel.textAlignment = .left
                    statusLLabel.setContentHuggingPriority(.defaultLow + 1, for: .horizontal)
                    statusLLabel.font = UIFont.boldSystemFont(ofSize: ViewMetrics.detailObjectFontSize)
                       
                    statusRLabel.text = "\(status)"
                   statusRLabel.textColor = Colors.systemWhite
                    statusRLabel.textAlignment = .left
                    statusRLabel.font = UIFont.systemFont(ofSize: ViewMetrics.detailObjectFontSize)
                    
                   let stack = UIFabric.shared().makeAStack(with: [statusLLabel, statusRLabel])
                   stack.axis = .horizontal
                    stack.distribution = .fill
                    
                   return stack
               }()
                stack.addArrangedSubview(statusStack)
            }
            
            if let species = avatar?.species {
                let speciesStack: UIStackView = {
                   speciesLLabel.text = "Species: "
                   speciesLLabel.textColor = Colors.systemGreen
                    speciesLLabel.textAlignment = .left
                    speciesLLabel.setContentHuggingPriority(.defaultLow + 1, for: .horizontal)
                    speciesLLabel.font = UIFont.boldSystemFont(ofSize: ViewMetrics.detailObjectFontSize)
                   
                   speciesRLabel.text = "\(species)"
                    speciesRLabel.textColor = Colors.systemWhite
                    speciesRLabel.textAlignment = .left
                    speciesRLabel.font = UIFont.systemFont(ofSize: ViewMetrics.detailObjectFontSize)
                   
                   let stack = UIFabric.shared().makeAStack(with: [speciesLLabel, speciesRLabel])
                   stack.axis = .horizontal
                    stack.distribution = .fill
                   
                   return stack
               }()
                stack.addArrangedSubview(speciesStack)
            }
             
            if let gender = avatar?.gender {
                let genderStack: UIStackView = {
                   genderLLabel.text = "Gender: "
                   genderLLabel.textColor = Colors.systemGreen
                    genderLLabel.textAlignment = .left
                    genderLLabel.setContentHuggingPriority(.defaultLow + 1, for: .horizontal)
                    genderLLabel.font = UIFont.boldSystemFont(ofSize: ViewMetrics.detailObjectFontSize)
                   
                   genderRLabel.text = "\(gender)"
                   genderRLabel.textColor = Colors.systemWhite
                    genderRLabel.textAlignment = .left
                    genderRLabel.font = UIFont.systemFont(ofSize: ViewMetrics.detailObjectFontSize)
                   
                   let stack = UIFabric.shared().makeAStack(with: [genderLLabel, genderRLabel])
                   stack.axis = .horizontal
                    stack.distribution = .fill
                   
                   return stack
               }()
                stack.addArrangedSubview(genderStack)
            }
            
            if let dimension = avatar?.dimension {
                let dimensionStack: UIStackView = {
                    dimensionLLabel.text = "Dimension: "
                    dimensionLLabel.textColor = Colors.systemGreen
                    dimensionLLabel.textAlignment = .left
                    dimensionLLabel.setContentHuggingPriority(.defaultLow + 1, for: .horizontal)
                    dimensionLLabel.font = UIFont.boldSystemFont(ofSize: ViewMetrics.detailObjectFontSize)
                   
                    dimensionRLabel.text = "\(dimension)"
                    dimensionRLabel.textColor = Colors.systemWhite
                    dimensionRLabel.textAlignment = .left
                    dimensionRLabel.font = UIFont.systemFont(ofSize: ViewMetrics.detailObjectFontSize)
                   
                    let stack = UIFabric.shared().makeAStack(with: [dimensionLLabel, dimensionRLabel])
                    stack.axis = .horizontal
                    stack.distribution = .fill
                   
                   return stack
               }()
                stack.addArrangedSubview(dimensionStack)
            }
            
            if let type = avatar?.type {
                if type.count > 1 {
                    let typeStack: UIStackView = {
                        typeLLabel.text = "Type: "
                        typeLLabel.textColor = Colors.systemGreen
                        typeLLabel.textAlignment = .left
                        typeLLabel.setContentHuggingPriority(.defaultLow + 1, for: .horizontal)
                        typeLLabel.font = UIFont.boldSystemFont(ofSize: ViewMetrics.detailObjectFontSize)
                       
                        typeRLabel.text = "\(type)"
                        typeRLabel.textColor = Colors.systemWhite
                        typeRLabel.textAlignment = .left
                        typeRLabel.font = UIFont.systemFont(ofSize: ViewMetrics.detailObjectFontSize)
                       
                        let stack = UIFabric.shared().makeAStack(with: [typeLLabel, typeRLabel])
                        stack.axis = .horizontal
                        stack.distribution = .fill
                       
                       return stack
                   }()
                    stack.addArrangedSubview(typeStack)
                }
                
            }
            
            if let airDate = avatar?.air_date {
                let airDateStack: UIStackView = {
                    airDateLLabel.text = "Air date: "
                    airDateLLabel.textColor = Colors.systemGreen
                    airDateLLabel.textAlignment = .left
                    airDateLLabel.setContentHuggingPriority(.defaultLow + 1, for: .horizontal)
                    airDateLLabel.font = UIFont.boldSystemFont(ofSize: ViewMetrics.detailObjectFontSize)
                   
                    airDateRLabel.text = "\(airDate)"
                    airDateRLabel.textColor = Colors.systemWhite
                    airDateRLabel.textAlignment = .left
                    airDateRLabel.font = UIFont.systemFont(ofSize: ViewMetrics.detailObjectFontSize)
                   
                    let stack = UIFabric.shared().makeAStack(with: [airDateLLabel, airDateRLabel])
                    stack.axis = .horizontal
                    stack.distribution = .fill
                   
                   return stack
               }()
                stack.addArrangedSubview(airDateStack)
            }
            
//            if let episode = avatar?.episode {
//                let episodeStack: UIStackView = {
//                    episodeLLabel.text = "Episode: "
//                    episodeLLabel.textColor = Colors.systemGreen
//                    episodeLLabel.textAlignment = .left
//                    episodeLLabel.setContentHuggingPriority(.defaultLow + 1, for: .horizontal)
//                    episodeLLabel.font = UIFont.boldSystemFont(ofSize: ViewMetrics.detailObjectFontSize)
//
//                    episodeRLabel.text = "\(episode)"
//                    episodeRLabel.textColor = Colors.systemWhite
//                    episodeRLabel.textAlignment = .left
//                    episodeRLabel.font = UIFont.systemFont(ofSize: ViewMetrics.detailObjectFontSize)
//
//                    let stack = UIFabric.shared().makeAStack(with: [episodeLLabel, episodeRLabel])
//                    stack.axis = .horizontal
//                    stack.distribution = .fill
//
//                   return stack
//               }()
//                stack.addArrangedSubview(episodeStack)
//            }
            stack.spacing = 10.0
            stack.setContentHuggingPriority(.defaultHigh, for: .vertical)
            
            return stack
        }()
        
        view.addSubview(globalStack)
        view.addSubview(pictureView)
        
        NSLayoutConstraint.activate([
            pictureView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            pictureView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            pictureView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            pictureView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.45),
            
            globalStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            globalStack.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -70),
            globalStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            globalStack.topAnchor.constraint(equalTo: pictureView.bottomAnchor, constant: 40)
        ])
       
    }
}
