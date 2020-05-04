//
//  Created by Charles Prado on 13/11/19.
//  Copyright © 2019 Charles Prado. All rights reserved.
//

import UIKit

public class LabelStyle: ViewStyle {

    public let fontName: String?
    public let fontSize: CGFloat?
    public let textColorStr: String?
    public let uppercased: Bool?
    
    public var textColor: UIColor? {
        guard let textColorStr = textColorStr else { return nil }
        return AppStyleSheet.shared.color(withName: textColorStr)?.uiColor
    }
    
    public let numberOfLines: Int?
    
    private enum CodingKeys: String, CodingKey {
        case fontName
        case fontSize
        case textColorStr = "textColor"
        case numberOfLines
        case uppercased
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        fontName = try container.decodeIfPresent(String.self, forKey: .fontName)
        fontSize = try container.decodeIfPresent(CGFloat.self, forKey: .fontSize)
        textColorStr = try container.decodeIfPresent(String.self, forKey: .textColorStr)
        numberOfLines = try container.decodeIfPresent(Int.self, forKey: .numberOfLines)
        uppercased = try container.decodeIfPresent(Bool.self, forKey: .uppercased)
        try super.init(from: decoder)
    }
}
