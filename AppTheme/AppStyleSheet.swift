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

    private (set) var themes = [Theme]()
    private var labelStyles = [LabelStyle]()
    private var buttonStyles = [ButtonStyle]()

    public var appColors: [AppColor] {
        themes.first?.colors ?? []
    }

    public static let shared: AppStyleSheet = AppStyleSheet()
    
    private init() {
        loadAppStyleSheet()
    }
    
    public func loadAppStyleSheet() {
        loadStyleSheet(into: &labelStyles)
        loadStyleSheet(into: &buttonStyles)
        loadThemes()
    }

    private func loadThemes() {
        guard let path = Bundle.main.url(forResource: "Themes", withExtension: "json", subdirectory: nil),
           let data = try? Data.init(contentsOf: path, options: .mappedIfSafe) else {
            fatalError("Failed to load Application Themes")
        }
        self.themes = try! JSONDecoder().decode([Theme].self, from: data)
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

    public func color(withName colorName: String,
                      forTheme themeName: AppTheme = AppTheme.currentTheme) -> AppColor? {
        guard let theme = themes.filter({ $0.themeName == themeName.rawValue }).first else { return nil }
        return theme.color(withName: colorName)
    }

    private func loadStyleSheet<Style>(forTheme theme: AppTheme? = nil,
                                       into styleSheetList: inout [Style])
            where Style: Decodable & StyleSheetComponent {

        let stylesFileName = Style.stylesFilename(forTheme: theme)
        
        guard let _styleSheetList: [Style] = loadStylesFromStylesFile(withName: stylesFileName) else {
            fatalError("Invalid style sheet plist for theme: \(AppTheme.currentTheme) on file \(stylesFileName)")
        }
        
        styleSheetList = _styleSheetList
    }
    
    private func loadStylesFromStylesFile<Style>(withName name: String) -> [Style]? where Style: Decodable {
        if let path = Bundle.main.url(forResource: name, withExtension: "json", subdirectory: nil),
           let data = try? Data.init(contentsOf: path, options: .mappedIfSafe) {
            return try? JSONDecoder().decode([Style].self, from: data) as [Style]
        }
        return nil
    }
}
