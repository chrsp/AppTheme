//
//  StyleGetter.swift
//  AppTheme
//
//  Created by Charles Prado on 13/11/19.
//  Copyright © 2019 Charles Prado. All rights reserved.
//

import Foundation

public protocol StyleGetter {
    func getStyle<Style>() -> Style where Style: ViewStyle
}

extension StyleGetter where Self: RawRepresentable, Self.RawValue == String  {
    public func getStyle<Style>() -> Style where Style: ViewStyle {
        return AppStyleSheet.shared.getStyle(withName: self.rawValue)!
    }
}
