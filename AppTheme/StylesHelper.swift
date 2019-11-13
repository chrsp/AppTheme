//
//  StylesHelper.swift
//  AppTheme
//
//  Created by Charles Prado on 13/11/19.
//  Copyright © 2019 Charles Prado. All rights reserved.
//

import UIKit

class StylesHelper {
    
    // Apply style to an UIView
    static func applyStyle(_ style: ViewStyle, toView view: UIView) {
        if let backgroundColor = style.backgroundColor {
            view.backgroundColor = backgroundColor
        }
        
        if let cornerRadius = style.cornerRadius {
            view.clipsToBounds = true
            view.layer.cornerRadius = cornerRadius
        }
           
        if let borderWidth = style.borderWidth {
            view.layer.borderWidth = borderWidth
        }
           
        if let borderColor = style.borderColor {
            view.layer.borderColor = borderColor.cgColor
        }
           
        if style.isCircular == true {
            view.clipsToBounds = true
            view.layer.cornerRadius = view.bounds.height / 2
        }
    }
    
    // Apply style to an UILabel
    static func applyStyle(_ style: LabelStyle, toLabel label: UILabel) {
        if let stylable = label as? Stylable {
            stylable.stylesHandler.currentStyle = style
        }
          
        if let styleFontName = style.fontName, let styleFontSize = style.fontSize {
            label.font = UIFont(name: styleFontName, size: styleFontSize)
        }
          
        if let styleTextColor = style.textColor {
            label.textColor = styleTextColor
        }
          
        if let numberOfLines = style.numberOfLines {
            label.numberOfLines = numberOfLines
        }
          
        if style.uppercased == true {
            label.text = label.text?.uppercased()
        }
    }
    
    // Apply style to an UIButton
    static func applyStyle(_ style: ButtonStyle, toButton button: UIButton) {
        
        StylesHelper.applyStyle(style, toView: button)
        
        if let stylable = button as? Stylable {
            stylable.stylesHandler.currentStyle = style
        }
        
        if let backgroundColor = style.backgroundColor {
            button.backgroundColor = backgroundColor
        }
        
        if let labelStyleColor = style.labelStyleNormal?.textColor {
            button.setTitleColor(labelStyleColor, for: .normal)
            button.changeImageColor(to: labelStyleColor, forState: .normal)
        }
        
        if let labelStyleColor = style.labelStylePressed?.textColor {
            button.setTitleColor(labelStyleColor.withAlphaComponent(0.5), for: .highlighted)
            button.changeImageColor(to: labelStyleColor, forState: .highlighted)
        }
        
        if let labelStyleColor = style.labelStyleDisabled?.textColor {
            button.setTitleColor(labelStyleColor.withAlphaComponent(0.5), for: .disabled)
            button.changeImageColor(to: labelStyleColor, forState: .disabled)
        }
        
        if let styleFontName = style.labelStyleNormal?.fontName, let styleFontSize = style.labelStyleNormal?.fontSize {
            button.titleLabel?.font = UIFont(name: styleFontName, size: styleFontSize)
        }
    }
}

extension UIButton {
    public func changeImageColor(to newColor: UIColor, forState state: UIControl.State) {
        guard let origImage = self.image(for: state) else { return }
        let tintedImage = origImage.withRenderingMode(.alwaysTemplate)
        setImage(tintedImage, for: state)
        tintColor = newColor
    }
}


