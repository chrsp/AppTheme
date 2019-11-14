//
//  StyleSheetComponent.swift
//  AppTheme
//
//  Created by Charles Prado on 13/11/19.
//  Copyright © 2019 Charles Prado. All rights reserved.
//

import Foundation

protocol StyleSheetComponent {
    static func stylesFilename(forTheme theme: AppTheme?) -> String
}

extension StyleSheetComponent {
    
    static func stylesFilename(forTheme theme: AppTheme?) -> String {
        var basePath = "AppStyle-\(String(describing: self))"
        if let theme = theme { basePath += "-\(theme.rawValue.capitalized)" }
        return basePath
    }
}
