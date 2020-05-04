//
//  Created by Charles Prado on 11/03/20.
//  Copyright © 2020 Charles Prado. All rights reserved.
//

import UIKit

public enum ColorName: String {
    case colorStatusBar
    case colorPrimary
    case colorSecondary
    case colorSurface
    case colorOnSurface
    case colorOnSecondary
    case textColorPrimary
    case textColorSecondary
    case textColorSecondaryVariant
    case colorError
    case colorOnError
    case rippleOnSecondaryColor
    case separatorColor
    case infoColorVariant
    case clear
    case colorOnPrimary
    case navigationBar

    public var uiColor: UIColor {
        UIColor.color(self)
    }
    
    public func uiColor(forTheme themeName: AppTheme) -> UIColor {
        UIColor.color(self, themeName: themeName)
    }
}

fileprivate extension UIColor {
    static func color(_ colorName: ColorName, themeName: AppTheme = AppTheme.currentTheme) -> UIColor {
        var color: UIColor {
            guard let _color = AppStyleSheet.shared.color(withName: colorName.rawValue, forTheme: themeName) else {
                fatalError("Invalid ColorName: \(colorName) for Style \(AppTheme.currentTheme)")
            }
            return UIColor(hex: _color.hex).withAlphaComponent(_color.alpha)
        }

        if #available(iOS 13.0, *) {
            return UIColor { traitCollection in color }
        } else {
            return color
        }
    }
}
