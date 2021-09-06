//
//  FilterViewController.swift
//  AndersenRickAndMorty
//
//  Created by Илья Москалев on 31.08.2021.
//

import UIKit

final class FilterViewController: UIViewController {
    
    var previousStatus: String?
    var previousGender: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Filter"
        view.backgroundColor = Colors.systemBack
        
        setupContainerView()
        setupActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        previousStatus = DataManager.shared().loadStringFromDefaults(from: "status")
        previousGender = DataManager.shared().loadStringFromDefaults(from: "gender")
    }
    
    // Инициализируем стеквью, в котором весь UI
    private let container = ContainerFilterView.shared.createContainerStack()
    
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
        // Kогика reset
        didSet {
        // Здесь происходит инициализация кнопки reset
            let resetStatusButton = self.view.viewWithTag(121) as? UIButton
            resetStatusButton?.addTarget(self, action: #selector(setParameters), for: .touchUpInside)
            resetStatusButton?.isHidden = false
    }}
    // По аналогии, только gender
    private var genderButtons = [UIButton]()
    private var selectedGender = [UIButton]() {
        didSet {
            let resetGenderButton = self.view.viewWithTag(122) as? UIButton
            resetGenderButton?.addTarget(self, action: #selector(setParameters), for: .touchUpInside)
            resetGenderButton?.isHidden = false
    }}
    
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
        
        // Предзагрузка данных о Status для отображения выбранных настроек фильтрации
        if let status = DataManager.shared().loadStringFromDefaults(from: "status") {
            switch status {
            case "alive":
                selectedStatus.append(aliveButton!)
                aliveButton?.shortChange(Colors.systemGreen)
            case "dead":
                selectedStatus.append(deadButton!)
                deadButton?.shortChange(Colors.systemGreen)
            case "unknown":
                selectedStatus.append(unknownButton!)
                unknownButton?.shortChange(Colors.systemGreen)
            default:
                print("Unknown status from defaults in setupActions")
                break
            }
        }
        // Предзагрузка данных о Gender для отображения выбранных настроек фильтрации
        if let gender = DataManager.shared().loadStringFromDefaults(from: "gender") {
            switch gender {
            case "female":
                selectedGender.append(femaleButton!)
                femaleButton?.shortChange(Colors.systemGreen)
            case "male":
                selectedGender.append(maleButton!)
                maleButton?.shortChange(Colors.systemGreen)
            case "genderless":
                selectedGender.append(genderLess!)
                genderLess?.shortChange(Colors.systemGreen)
            case "unknown":
                selectedGender.append(unknownGenderButton!)
                unknownGenderButton?.shortChange(Colors.systemGreen)
            default:
                break
            }
        }
    }

    //MARK: Вопрос
    // Вынести в модель, но конфликт Model видит View
    @objc func setParameters(_ sender: UIButton) {
        var title: String = ""
        if sender.currentTitle?.lowercased() != "reset" {
            title = sender.currentTitle!.suffix(sender.currentTitle!.count - 6).lowercased()
        }
        
        switch sender.tag {
        // Все случаи для STATUS параметров
        case 101, 102, 103:
            if selectedStatus.isEmpty {
                selectedStatus.append(sender)
                sender.shortChange(Colors.systemGreen)
                DataManager.shared().saveToDefaults(title, for: "status")
            } else {
                selectedStatus.first?.titleLabel?.textColor = Colors.systemWhite
                selectedStatus.removeAll()
                selectedStatus.append(sender)
                sender.shortChange(Colors.systemGreen)
                DataManager.shared().saveToDefaults(title, for: "status")
            }
        // Все случаи для GENDER параметров
        case 111, 112, 113, 114:
            if selectedGender.isEmpty {
                selectedGender.append(sender)
                sender.shortChange(Colors.systemGreen)
                DataManager.shared().saveToDefaults(title, for: "gender")
            } else {
                selectedGender.first?.titleLabel?.textColor = Colors.systemWhite
                selectedGender.removeAll()
                selectedGender.append(sender)
                sender.shortChange(Colors.systemGreen)
                DataManager.shared().saveToDefaults(title, for: "gender")
            }
        // RESET STATUS
        case 121:
            DataManager.shared().deleteFromDefaults(from: "status")
            selectedStatus.first?.shortChange(Colors.systemWhite)
            selectedStatus.removeAll()
            sender.isHidden = true
        // RESET GENDER
        case 122:
            DataManager.shared().deleteFromDefaults(from: "gender")
            selectedGender.first?.shortChange(Colors.systemWhite)
            selectedGender.removeAll()
            sender.isHidden = true
        default:
            break
    }}}

// MARK: Extension
// Маленький для изменения цвета текста кнопки
extension UIButton {
    func shortChange(_ color: UIColor) {
        self.setTitleColor(color, for: .normal)
}}
