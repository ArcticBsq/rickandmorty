//
//  DetailObjectVCStack.swift
//  AndersenRickAndMorty
//
//  Created by Илья Москалев on 26.08.2021.
//

import UIKit

class DetailObjectVCStack {
    
    static func shared() -> DetailObjectVCStack {
        return DetailObjectVCStack()
    }
    
    private init() { }
    
    // Функция возвращает стеквью, из которых происходит заполнение страницы
    // 1 стеквью = 1 строка информации
    private func makeTextRowStack(leftText: String, rightText: String, addToParent: UIStackView){
        let leftLabel = UIFabric.shared.makeLabel(text: leftText, textColor: Colors.systemGreen, textAlignment: .left, font: Fonts.detailObjectScreenLeft, horizontalHugPriority: .defaultLow + 1)
        
        let rightLabel = UIFabric.shared.makeLabel(text: rightText, textColor: Colors.systemWhite, textAlignment: .left, font: Fonts.detailObjectScreenRight)
        
        let stack = UIFabric.shared.makeAStack(with: [leftLabel, rightLabel], axis: .horizontal, distribution: .fill, spacing: 30, isHidden: false)
        
        addToParent.addArrangedSubview(stack)
    }
    
    func createStack(from avatar: Package) -> UIStackView {
    // Главный stack, контейнер для элементов
        let innerStack = UIFabric.shared.makeAStack(with: [], distribution: .fill, spacing: ViewMetrics.detailObjectStackSpacing)
    // Так создаются строки, пример - код создания строки Name
        makeTextRowStack(leftText: "Name:", rightText: avatar.name, addToParent: innerStack)
    
        if let status = avatar.status { makeTextRowStack(leftText: "Status:", rightText: status, addToParent: innerStack) }
    
        if let species = avatar.species { makeTextRowStack(leftText: "Species:", rightText: species, addToParent: innerStack) }
    
        if let gender = avatar.gender { makeTextRowStack(leftText: "Gender:", rightText: gender, addToParent: innerStack) }
    
        if let dimension = avatar.dimension { makeTextRowStack(leftText: "Dimension:", rightText: dimension, addToParent: innerStack) }
        
        if let type = avatar.type {
            if !type.isEmpty { makeTextRowStack(leftText: "Type:", rightText: type, addToParent: innerStack) }
        }
        
        if let airDate = avatar.air_date { makeTextRowStack(leftText: "Air date:", rightText: airDate, addToParent: innerStack) }
            
        let outerStack = UIFabric.shared.makeAStack(with: [innerStack], distribution: .fill, spacing: ViewMetrics.detailObjectStackSpacing)
            
        return outerStack
    }
}
