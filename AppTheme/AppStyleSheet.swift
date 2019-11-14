//
//  AppStyleSheet.swift
//  AppTheme
//
//  Created by Charles Prado on 13/11/19.
//  Copyright © 2019 Charles Prado. All rights reserved.
//

import Foundation

import UIKit

@available(iOS 13.0, *)
extension UIUserInterfaceStyle {
    var description: String {
        switch self {
        case .light:
            return "light"
        case .dark:
            return "dark"
        default:
            return "unspecified"
        }
    }
}

public class AppStyleSheet {
    
    private var viewStyles: [ViewStyle] = []
    private var labelStyles: [LabelStyle] = []
    private var buttonStyles: [ButtonStyle] = []
    private var lightColors: [Color] = []
    private var darkColors: [Color] = []
    
    public static let shared: AppStyleSheet = AppStyleSheet()
    
    private init() {
        loadAppStyleSheet()
    }
    
    public func loadAppStyleSheet() {
        loadStyleSheet(into: &viewStyles)
        loadStyleSheet(into: &labelStyles)
        loadStyleSheet(into: &buttonStyles)
        loadStyleSheet(forTheme: .light, into: &lightColors)
        loadStyleSheet(forTheme: .dark, into: &darkColors)
    }
    
    public func getStyle<Style>(withName styleName: String) -> Style? where Style: ViewStyle {
        let mirror = Mirror(reflecting: self)
        
        guard let styles = mirror.children.first(
            where: {($0.value as? [Style])?.first(
                where: {$0.styleName == styleName}) != nil})?
            .value as? [Style] else {
                
            return nil
        }
        
        return styles.first(where: {$0.styleName == styleName})
    }
    
    public func getColor(withName colorName: String) -> Color? {
        let theme = AppTheme.currentTheme
        let colors: [Color] = theme == .dark ? darkColors : lightColors
        return colors.first(where: {$0.name == colorName})
    }
    
    private func loadStyleSheet<Style>(forTheme theme: AppTheme? = nil, into styleSheetList: inout [Style]) where Style: Decodable & StyleSheetComponent {
        let stylesFileName = Style.stylesFilename(forTheme: theme)
        
        guard let _styleSheetList: [Style] = loadStylesFromPlist(withName: stylesFileName) else {
            fatalError("Invalid style sheet plist for theme: \(AppTheme.currentTheme) on file \(stylesFileName)")
        }
        
        styleSheetList = _styleSheetList
    }
    
    private func loadStylesFromPlist<Style>(withName name: String) -> [Style]? where Style: Decodable {
        if let path = Bundle.main.url(forResource: name, withExtension: "plist", subdirectory: "/Frameworks/AppTheme.framework"),
            let data = try? Data.init(contentsOf: path, options: .mappedIfSafe) {
            return try? PropertyListDecoder().decode([Style].self, from: data) as [Style]
        }
        return nil
    }
}
