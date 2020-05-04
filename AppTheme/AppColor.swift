//
//  Created by Charles Prado on 13/11/19.
//  Copyright © 2019 Charles Prado. All rights reserved.
//

import UIKit

public class AppColor: Identifiable, Codable, StyleSheetComponent {
    
    public var id: String = UUID().uuidString
    public var name: String
    public var hex: String
    public var alpha: CGFloat = 1.0
    
    public var uiColor: UIColor {
        return UIColor(hex: hex).withAlphaComponent(alpha)
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case hex
        case alpha
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        hex = try container.decode(String.self, forKey: .hex)
        alpha = try container.decodeIfPresent(CGFloat.self, forKey: .alpha) ?? 1.0
    }
}

extension UIColor {
    convenience public init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
