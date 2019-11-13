//
//  ButtonStyle.swift
//  AppTheme
//
//  Created by Charles Prado on 13/11/19.
//  Copyright © 2019 Charles Prado. All rights reserved.
//

import Foundation

public class ButtonStyle: ViewStyle {
    
    private let _labelStyleNormal: String?
    private let _labelStylePressed: String?
    private let _labelStyleDisabled: String?
    
    public var labelStyleNormal: LabelStyle? {
        guard let _labelStyleNormal = _labelStyleNormal else { return nil }
        return AppStyleSheet.shared.getStyle(withName: _labelStyleNormal)
    }
    
    public var labelStylePressed: LabelStyle? {
        guard let _labelStylePressed = _labelStylePressed else { return nil }
        return AppStyleSheet.shared.getStyle(withName: _labelStylePressed)
    }
    
    public var labelStyleDisabled: LabelStyle? {
        guard let _labelStyleDisabled = _labelStyleDisabled else { return nil }
        return AppStyleSheet.shared.getStyle(withName: _labelStyleDisabled)
    }
    
    private enum CodingKeys: String, CodingKey {
        case _labelStyleNormal = "labelStyleNormal"
        case _labelStylePressed = "labelStylePressed"
        case _labelStyleDisabled = "labelStyleDisabled"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        _labelStyleNormal = try container.decodeIfPresent(String.self, forKey: ._labelStyleNormal)
        _labelStylePressed = try container.decodeIfPresent(String.self, forKey: ._labelStylePressed)
        _labelStyleDisabled = try container.decodeIfPresent(String.self, forKey: ._labelStyleDisabled)
        
        try super.init(from: decoder)
    }
}
