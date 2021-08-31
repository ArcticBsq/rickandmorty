//
//  FilterViewController.swift
//  AndersenRickAndMorty
//
//  Created by Илья Москалев on 31.08.2021.
//

import UIKit

class FilterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Filter"
        view.backgroundColor = Colors.systemBack
        
        setupContainerView()
        setupActions()
    }
    // Инициализируем стеквью, в котором весь UI
    private let container = ContainerFilterView.shared().createContainerStack()
    
    // Настройка UI контейнера
    private func setupContainerView() {
        view.addSubview(container)
        
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25),
            container.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            container.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -45)
        ])
    }
    // Массив, где хранятся все кнопки из status
    // По нему будет проходить логика для изменения цвета кнопок и deselect лишних
    private var statusButtons = [UIButton]()
    private var selectedStatus = [UIButton]() {
        // При обновлении массива, если элементов 0, то удаляет значение из defaults, логика reset
        didSet {
            if statusButtons.isEmpty {
                DataManager.shared().deleteFromDefaults(from: "statusParam")
            } else {
                // Здесь происходит инициализация кнопки reset
                let resetStatusButton = self.view.viewWithTag(121) as? UIButton
                resetStatusButton?.addTarget(self, action: #selector(setParameters), for: .touchUpInside)
                resetStatusButton?.isHidden = false
            }}}
    // По аналогии, только gender
    private var genderButtons = [UIButton]()
    private var selectedGender = [UIButton]() {
        didSet {
            if genderButtons.isEmpty {
                DataManager.shared().deleteFromDefaults(from: "genderParam")
            } else {
                // Здесь происходит инициализация кнопки reset
                let resetGenderButton = self.view.viewWithTag(122) as? UIButton
                resetGenderButton?.addTarget(self, action: #selector(setParameters), for: .touchUpInside)
                resetGenderButton?.isHidden = false
            }}}
    
    // Заполняем массивы statusButtons/genderButtons по view.tag
    private func setupActions() {
        let aliveButton = self.view.viewWithTag(101) as? UIButton
        statusButtons.append(aliveButton!)
        aliveButton?.addTarget(self, action: #selector(setParameters), for: .touchUpInside)
        
        let deadButton = self.view.viewWithTag(102) as? UIButton
        statusButtons.append(deadButton!)
        deadButton?.addTarget(self, action: #selector(setParameters), for: .touchUpInside)
        
        let unknownButton = self.view.viewWithTag(103) as? UIButton
        statusButtons.append(unknownButton!)
        unknownButton?.addTarget(self, action: #selector(setParameters), for: .touchUpInside)
        
        let femaleButton = self.view.viewWithTag(111) as? UIButton
        genderButtons.append(femaleButton!)
        femaleButton?.addTarget(self, action: #selector(setParameters), for: .touchUpInside)
        
        let maleButton = self.view.viewWithTag(112) as? UIButton
        genderButtons.append(maleButton!)
        maleButton?.addTarget(self, action: #selector(setParameters), for: .touchUpInside)
        
        let genderLess = self.view.viewWithTag(113) as? UIButton
        genderButtons.append(genderLess!)
        genderLess?.addTarget(self, action: #selector(setParameters), for: .touchUpInside)
        
        let unknownGenderButton = self.view.viewWithTag(114) as? UIButton
        genderButtons.append(unknownGenderButton!)
        unknownGenderButton?.addTarget(self, action: #selector(setParameters), for: .touchUpInside)
    }

    //MARK: По идее в модель вынести, но проблема в доступе Model к View
    @objc func setParameters(_ sender: UIButton) {
        print("tap")
        switch sender.tag {
        // Все случаи для STATUS параметров
        case 101, 102, 103:
            if selectedStatus.isEmpty {
                selectedStatus.append(sender)
                sender.shortChange(Colors.systemGreen)
                DataManager.shared().saveToDefaults(sender.currentTitle!, for: "statusParam")
            } else {
                selectedStatus.first?.titleLabel?.textColor = Colors.systemWhite
                selectedStatus.removeAll()
                selectedStatus.append(sender)
                sender.shortChange(Colors.systemGreen)
                DataManager.shared().saveToDefaults(sender.currentTitle!, for: "statusParam")
            }
        // Все случаи для GENDER параметров
        case 111, 112, 113, 114:
            if selectedGender.isEmpty {
                selectedGender.append(sender)
                sender.shortChange(Colors.systemGreen)
                DataManager.shared().saveToDefaults(sender.currentTitle!, for: "genderParam")
            } else {
                selectedGender.first?.titleLabel?.textColor = Colors.systemWhite
                selectedGender.removeAll()
                selectedGender.append(sender)
                sender.shortChange(Colors.systemGreen)
                DataManager.shared().saveToDefaults(sender.currentTitle!, for: "genderParam")
            }
        // RESET STATUS
        case 121:
            selectedStatus.first?.shortChange(Colors.systemWhite)
            selectedStatus.removeAll()
            sender.isHidden = true
        // RESET GENDER
        case 122:
            selectedGender.first?.shortChange(Colors.systemWhite)
            selectedGender.removeAll()
            sender.isHidden = true
        default:
            break
        }
    }
}

// MARK: Extension
// Маленький для изменения цвета текста кнопки
extension UIButton {
    func shortChange(_ color: UIColor) {
        self.setTitleColor(color, for: .normal)
    }
}
