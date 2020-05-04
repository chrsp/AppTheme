//
//  Created by Charles Prado on 13/11/19.
//  Copyright © 2019 Charles Prado. All rights reserved.
//

import UIKit

public class ViewStyle: Decodable, StyleSheetComponent {
    
    private let backgroundColorStr: String?
    private let borderColorStr: String?
    
    public let styleName: String?
    public let cornerRadius: CGFloat?
    public let borderWidth: CGFloat?
    public let isCircular: Bool?
    private let _tintColor: String?
    
    public func backgroundColor(forTheme theme: AppTheme = AppTheme.base) -> UIColor? {
        guard let backgroundColorStr = backgroundColorStr else { return nil }
        return AppStyleSheet.shared.color(withName: backgroundColorStr, forTheme: theme)?.uiColor
    }
    
    public func borderColor(forTheme theme: AppTheme = AppTheme.base) -> UIColor? {
        guard let borderColorStr = borderColorStr else { return nil }
        return AppStyleSheet.shared.color(withName: borderColorStr, forTheme: theme)?.uiColor
    }
    
    public func tintColor(forTheme theme: AppTheme = AppTheme.base) -> UIColor? {
        guard let _tintColor = _tintColor else { return nil }
        return AppStyleSheet.shared.color(withName: _tintColor, forTheme: theme)?.uiColor
    }
   
    private enum CodingKeys: String, CodingKey {
        case styleName
        case cornerRadius
        case borderWidth
        case backgroundColorStr = "backgroundColor"
        case borderColorStr = "borderColor"
        case isCircular
        case _tintColor = "tintColor"
    }
   
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        styleName = try container.decodeIfPresent(String.self, forKey: .styleName)
        backgroundColorStr = try container.decodeIfPresent(String.self, forKey: .backgroundColorStr)
        cornerRadius = try container.decodeIfPresent(CGFloat.self, forKey: .cornerRadius)
        borderWidth = try container.decodeIfPresent(CGFloat.self, forKey: .borderWidth)
        borderColorStr = try container.decodeIfPresent(String.self, forKey: .borderColorStr)
        isCircular = try container.decodeIfPresent(Bool.self, forKey: .isCircular)
        _tintColor = try container.decodeIfPresent(String.self, forKey: ._tintColor)
    }
}

