//
//  Theme.swift
//  RxThemeTutorial
//
//  Created by Alex Nagy on 03/04/2019.
//  Copyright © 2019 Alex Nagy. All rights reserved.
//

import RxSwift
import RxTheme

typealias Color = UIColor
typealias Attributes = [NSAttributedString.Key: Any]

protocol Theme {
    var backgroundColor: Color { get }
    
    var navigationBarBarTintColor: Color { get }
    var navigationBarTintColor: Color { get }
    var navigationBarTitleTextAttributes: Attributes { get }
    
    var buttonBackgroundColor: Color { get }
    var buttonTitleColor: Color { get }
    var buttonBorderColor: CGColor { get }
}

struct LightTheme: Theme {
    let backgroundColor: Color = #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)
    
    let navigationBarBarTintColor: Color = #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)
    let navigationBarTintColor: Color = #colorLiteral(red: 0.1529411765, green: 0.1529411765, blue: 0.1529411765, alpha: 1)
    let navigationBarTitleTextAttributes: Attributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.1529411765, green: 0.1529411765, blue: 0.1529411765, alpha: 1)]
    
    let buttonBackgroundColor: Color = #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)
    let buttonTitleColor: Color = #colorLiteral(red: 0.1529411765, green: 0.1529411765, blue: 0.1529411765, alpha: 1)
    let buttonBorderColor: CGColor = #colorLiteral(red: 0.1529411765, green: 0.1529411765, blue: 0.1529411765, alpha: 1).cgColor
}

struct DarkTheme: Theme {
    let backgroundColor: Color = #colorLiteral(red: 0.1529411765, green: 0.1529411765, blue: 0.1529411765, alpha: 1)
    
    let navigationBarBarTintColor: Color = #colorLiteral(red: 0.1529411765, green: 0.1529411765, blue: 0.1529411765, alpha: 1)
    let navigationBarTintColor: Color = #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)
    let navigationBarTitleTextAttributes: Attributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)]
    
    let buttonBackgroundColor: Color = #colorLiteral(red: 0.1529411765, green: 0.1529411765, blue: 0.1529411765, alpha: 1)
    let buttonTitleColor: Color = #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)
    let buttonBorderColor: CGColor = #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1).cgColor
}

enum ThemeType: ThemeProvider {
    case light, dark
    var associatedObject: Theme {
        switch self {
        case .light: return LightTheme()
        case .dark: return DarkTheme()
        }
    }
}

let themeService = ThemeType.service(initial: .light)
func themed<T>(_ mapper: @escaping ((Theme) -> T)) -> Observable<T> {
    return themeService.attrStream(mapper)
}

