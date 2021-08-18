//
//  DetailObjectController.swift
//  AndersenRickAndMorty
//
//  Created by Илья Москалев on 18.08.2021.
//

import UIKit

class DetailObjectController: UIViewController {

    var avatar: Package?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.systemBack
        setupView()
    }
    
    let pictureView = UIFabric.shared().makeImageView()
    
    let idLLabel = UIFabric.shared().makeLabel()
    let idRLabel = UIFabric.shared().makeLabel()
    
    let nameLLabel = UIFabric.shared().makeLabel()
    let nameRLabel = UIFabric.shared().makeLabel()
    
    let statusLLabel = UIFabric.shared().makeLabel()
    let statusRLabel = UIFabric.shared().makeLabel()
    
    let genderLLabel = UIFabric.shared().makeLabel()
    let genderRLabel = UIFabric.shared().makeLabel()
    
    let speciesLLabel = UIFabric.shared().makeLabel()
    let speciesRLabel = UIFabric.shared().makeLabel()
    
    private func setupView() {
        let globalStack: UIStackView = {
            let stack = UIFabric.shared().makeAStack(with: [])
            
             let idStack: UIStackView = {
                idLLabel.text = "ID: "
                idLLabel.textColor = Colors.systemGreen
                
                idRLabel.text = "\(avatar!.id)"
                idRLabel.textColor = Colors.systemWhite
                
                let stack = UIFabric.shared().makeAStack(with: [idLLabel, idRLabel])
                stack.axis = .horizontal
                
                return stack
            }()
            stack.addArrangedSubview(idStack)
            
             let nameStack: UIStackView = {
                nameLLabel.text = "Name: "
                nameLLabel.textColor = Colors.systemGreen
                
                nameRLabel.text = "\(avatar!.name)"
                nameRLabel.textColor = Colors.systemWhite
                
                nameRLabel.text = "\(self)"
                let stack = UIFabric.shared().makeAStack(with: [nameLLabel, nameRLabel])
                stack.axis = .horizontal
                
                return stack
            }()
            stack.addArrangedSubview(nameStack)
            
            if let status = avatar?.status {
                let statusStack: UIStackView = {
                   statusLLabel.text = "Status: "
                   statusLLabel.textColor = Colors.systemGreen
                       
                    statusRLabel.text = "\(status)"
                   statusRLabel.textColor = Colors.systemWhite
                   
                   let stack = UIFabric.shared().makeAStack(with: [statusLLabel, statusRLabel])
                   stack.axis = .horizontal
                   return stack
               }()
                stack.addArrangedSubview(statusStack)
            }
             
            if let gender = avatar?.gender {
                let genderStack: UIStackView = {
                   genderLLabel.text = "Gender: "
                   genderLLabel.textColor = Colors.systemGreen
                   
                   genderRLabel.text = "\(gender)"
                   genderRLabel.textColor = Colors.systemWhite
                   
                   let stack = UIFabric.shared().makeAStack(with: [genderLLabel, genderRLabel])
                   stack.axis = .horizontal
                   
                   return stack
               }()
                stack.addArrangedSubview(genderStack)
            }
             
            if let species = avatar?.species {
                let speciesStack: UIStackView = {
                   speciesLLabel.text = "Species: "
                   speciesLLabel.textColor = Colors.systemGreen
                   
                   speciesRLabel.text = "\(species)"
                   
                   let stack = UIFabric.shared().makeAStack(with: [speciesLLabel, speciesRLabel])
                   stack.axis = .horizontal
                   
                   return stack
               }()
                stack.addArrangedSubview(speciesStack)
            }
            return stack
        }()
        
        view.addSubview(globalStack)
        view.addSubview(pictureView)
        
        NSLayoutConstraint.activate([
            pictureView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            pictureView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            pictureView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            globalStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            globalStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            globalStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            globalStack.topAnchor.constraint(equalTo: pictureView.bottomAnchor, constant: 20)
        ])
       
    }
}
