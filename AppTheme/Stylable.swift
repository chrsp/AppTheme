//
//  Created by Charles Prado on 13/11/19.
//  Copyright © 2019 Charles Prado. All rights reserved.
//

import Foundation

public class StylesHandler {
    
    public init() {}
    
    // This callback must be called after setupColorsAndStyles,
    // so if you need to define some styles or dynamic colors inside
    // your views that you are not able to define inside
    // setupColorsAndStyles() you can set this callback with your
    // style definitions
    
    // Example:
    // myLabel.styleHandler.stylesToSetAfterSetupColorsAndStyles = {
    // myLabel.applyStyle(.someStyleImSettingOutsideSetupColorsAndStyles)
    // }
    
    public var stylesToSetAfterSetupColorsAndStyles: (() -> Void)? {
        didSet {
            stylesToSetAfterSetupColorsAndStyles?()
        }
    }
    
    // This holds a reference to the current style so if the style changes
    // and the superclass is already implementing a style, the newer style
    // will be keeped
    
    public var currentStyle: ViewStyle?
}

public protocol Stylable: class {
    
    // This object is used to apply any custom behavior associated with
    // an Stylable, so this way we'll not overload our Stylable components.
    
    var stylesHandler: StylesHandler { get set }

    // Every apply of colors and Styles that must be dynamic must be set
    // inside the implementation of this function. This gonna be called
    // on key places like `traitCollectionDidChange()` and also at the
    // init and draw methods so this way you just need to override it
    // and set your styles there.
    
    func setupColorsAndStyles()
}
