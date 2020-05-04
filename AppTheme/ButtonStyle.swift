//
//  Created by Charles Prado on 13/11/19.
//  Copyright © 2019 Charles Prado. All rights reserved.
//

import Foundation
import UIKit

public class ButtonStyle: ViewStyle {
    
    private let _labelStyle: String?
    private let _horizontalAlignment: String?
    public let contentHorizontalAlignment: UIControl.ContentHorizontalAlignment

    public var labelStyle: LabelStyle? {
        guard let _labelStyle = _labelStyle else { return nil }
        return AppStyleSheet.shared.getStyle(withName: _labelStyle)
    }

    private enum CodingKeys: String, CodingKey {
        case _labelStyle = "labelStyle"
        case horizontalAlignment
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        _labelStyle = try container.decodeIfPresent(String.self, forKey: ._labelStyle)
        _horizontalAlignment = try container.decodeIfPresent(String.self, forKey: .horizontalAlignment)

        let _horizontalAlignmentUpper = _horizontalAlignment?.uppercased() ?? ""

        if _horizontalAlignmentUpper == "LEFT" {
            contentHorizontalAlignment = .left
        } else if _horizontalAlignmentUpper == "RIGHT" {
            contentHorizontalAlignment = .right
        } else {
            contentHorizontalAlignment = .center
        }
        try super.init(from: decoder)
    }
}
