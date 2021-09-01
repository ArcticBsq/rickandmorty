//
//  ContainerFilterView.swift
//  AndersenRickAndMorty
//
//  Created by Илья Москалев on 31.08.2021.
//

import UIKit

class ContainerFilterView {
    
    static func shared() -> ContainerFilterView {
        return ContainerFilterView()
    }
    
    private init() { }
    
    // Элементы, относящиеся к Status фильтру
    let statusLLabel = UIFabric.shared().makeLabel(text: "Status", textColor: Colors.systemGreen, fontSize: 18, textAlignment: .left)
    let statusRButton = UIFabric.shared().makeButton(text: "Reset", textColor: Colors.systemRedActiv, textActiveColor: Colors.systemRedActiv)
    // Типы фильтров
    let aliveButton = UIFabric.shared().makeButton(text: "●     Alive", textColor: Colors.systemWhite)
    let deadButton = UIFabric.shared().makeButton(text: "●     Dead", textColor: Colors.systemWhite)
    let unknownButton = UIFabric.shared().makeButton(text: "●     Unknown", textColor: Colors.systemWhite)
    
    // Элементы относящиеся к Gender фильтру
    let genderLLabel = UIFabric.shared().makeLabel(text: "Gender", textColor: Colors.systemGreen, fontSize: 18, textAlignment: .left)
    let genderRButton = UIFabric.shared().makeButton(text: "Reset", textColor: Colors.systemRedActiv, textActiveColor: Colors.systemRedActiv)
    // Типы фильтров
    let femaleButton = UIFabric.shared().makeButton(text: "●     Female", textColor: Colors.systemWhite)
    let maleButton = UIFabric.shared().makeButton(text: "●     Male", textColor: Colors.systemWhite)
    let genderlessButton = UIFabric.shared().makeButton(text: "●     Genderless", textColor: Colors.systemWhite)
    let unknownGenderButton = UIFabric.shared().makeButton(backColor: nil, text: "●     Unknown", textColor: Colors.systemWhite)
    
    // Основной контейнер, в котором лежат все элементы
    func createContainerStack() -> UIStackView {
        statusRButton.contentHorizontalAlignment = .trailing
        genderRButton.contentHorizontalAlignment = .trailing
        
        let topS = UIFabric.shared().makeAStack(with: [statusLLabel, statusRButton], axis: .horizontal, distribution: .fillEqually, alignment: .fill, spacing: .zero)
        let botS = UIFabric.shared().makeAStack(with: [aliveButton, deadButton, unknownButton], axis: .vertical, distribution: .equalSpacing, alignment: .leading, spacing: 0)
        let statusStack = UIFabric.shared().makeAStack(with: [topS, botS], axis: .vertical, distribution: .fill, alignment: .fill, spacing: 15)
        
        let topG = UIFabric.shared().makeAStack(with: [genderLLabel, genderRButton], axis: .horizontal, distribution: .fillEqually, alignment: .fill, spacing: .zero)
        let botG = UIFabric.shared().makeAStack(with: [femaleButton, maleButton, genderlessButton, unknownGenderButton], axis: .vertical, distribution: .equalSpacing, alignment: .leading, spacing: 0)
        let genderStack = UIFabric.shared().makeAStack(with: [topG, botG], axis: .vertical, distribution: .fill, alignment: .fill, spacing: 15)
        
        let resultStack = UIFabric.shared().makeAStack(with: [statusStack, genderStack], axis: .vertical, distribution: .fillProportionally, alignment: .fill, spacing: 25)
        
        // Добавляем tag для работы с элементами
        statusStack.tag = 1
        // Inside statusStack
        topS.tag = 11
        botS.tag = 12
        
        // Inside genderStack
        genderStack.tag = 2
        topG.tag = 21
        botG.tag = 22
        
        // Inside botS stack
        aliveButton.tag = 101
        deadButton.tag = 102
        unknownButton.tag = 103
        
        // Inside botG stack
        femaleButton.tag = 111
        maleButton.tag = 112
        genderlessButton.tag = 113
        unknownGenderButton.tag = 114
        
        // Inside topS stack
        statusRButton.tag = 121
        // Inside topG stack
        genderRButton.tag = 122
        
        statusRButton.isHidden = true
        genderRButton.isHidden = true
        
        return resultStack
    }
}
