//
//  AppTheme.swift
//  koolicar
//
//  Created by Werck Ayrton on 04/11/2017.
//  Copyright © 2017 Ayrton. All rights reserved.
//

import Foundation
import UIKit

// Could be optimized by loading a file / calling a WS with associated colors / font ...
struct Theme {
    enum Color: String {
        case primaryColor
        case darkPrimaryColor
        case backgroundColor
        case disabledColor
        case lightBlueColor
        case darkBlueColor
        case navigationBarColor
        var color: UIColor! {
            return UIColor(named: self.rawValue)
        }
    }

    enum Font {
        case title, body, subTitle

        var font: UIFont {
            switch self {
            case .title:
                return UIFont.systemFont(ofSize: 20, weight: .bold)
            case .body:
                return UIFont.systemFont(ofSize: 16)
            case .subTitle:
                return UIFont.systemFont(ofSize: 12, weight: .light)
            }
        }
    }

    static func set(themeFont: Font, for labels: [UILabel]) {
        labels.forEach { (label) in
            label.font = themeFont.font
        }
    }

    static func set(textThemeColor: Color, for labels: [UILabel]) {
        labels.forEach { (label) in
            label.textColor = textThemeColor.color
        }
    }

    static func configureAppearance() {
        UINavigationBar.appearance().barTintColor = Theme.Color.navigationBarColor.color
        UINavigationBar.appearance().tintColor = Theme.Color.primaryColor.color
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: Theme.Color.primaryColor.color]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: Theme.Color.primaryColor.color]
    }
}
