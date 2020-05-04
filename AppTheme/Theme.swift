//
//  Created by Charles Prado on 11/03/20.
//  Copyright © 2020 Charles Prado. All rights reserved.
//

import Foundation

public class Theme: Codable {
    let themeName: String
    let colors: [AppColor]
    var parent: String?
    
    func color(withName colorName: String) -> AppColor? {
        if let color = colors.first(where: {$0.name == colorName}) {
            return color
        } else {
            guard let parentTheme = AppStyleSheet.shared.themes.filter({$0.themeName == parent}).first else { return nil }
            return parentTheme.color(withName: colorName)
        }
    }
}
