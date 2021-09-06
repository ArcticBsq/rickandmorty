//
//  Constants.swift
//  AndersenRickAndMorty
//
//  Created by Илья Москалев on 09.08.2021.
//

import UIKit

enum ViewMetrics {
    static let MainScreenButtonFontSize: CGFloat = 25.0
    static let spacing: CGFloat = 20.0
    static let corner: CGFloat = 15.0
    static let detailObjectFontSize: CGFloat = 20.0
    static let detailObjectStackSpacing: CGFloat = 20.0
}

enum Fonts {
    static let filterScreen: UIFont = UIFont.systemFont(ofSize: 18)
    static let detailObjectScreenLeft: UIFont = UIFont.boldSystemFont(ofSize: 20)
    static let detailObjectScreenRight: UIFont = UIFont.systemFont(ofSize: 20)
}

enum APIconstants {
    static let characters: String = "https://rickandmortyapi.com/api/character/?page="
    static let locations: String = "https://rickandmortyapi.com/api/location/?page="
    static let episodes: String = "https://rickandmortyapi.com/api/episode/?page="
    static let charactersFilterName: String = "https://rickandmortyapi.com/api/character/?name="
    static let locationsFilterName: String = "https://rickandmortyapi.com/api/location/?name="
    static let episodesFilterName: String = "https://rickandmortyapi.com/api/episode/?name="
}

enum Colors {
    static let systemGreen: UIColor = #colorLiteral(red: 0.7111499906, green: 0.84983325, blue: 0.2519544065, alpha: 1)
    static let systemBack: UIColor = #colorLiteral(red: 0.1365897357, green: 0.1572630107, blue: 0.1870015562, alpha: 1)
    static let systemWhite: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    static let systemBlack: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    static let systemRedActiv: UIColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
    static let systemRedNotActiv: UIColor = #colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 1)
}
