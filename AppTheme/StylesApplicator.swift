//
//  Created by Charles Prado on 13/11/19.
//  Copyright © 2019 Charles Prado. All rights reserved.
//

import UIKit

public class StylesApplicator {

    public static let shared = StylesApplicator()

    private init() {}

    private func applyStyle(_ style: ViewStyle, toView view: UIView, forTheme theme: AppTheme = .base) {
        if let backgroundColor = style.backgroundColor(forTheme: theme) {
            view.backgroundColor = backgroundColor
        }

        if let cornerRadius = style.cornerRadius {
            view.clipsToBounds = true
            view.layer.cornerRadius = cornerRadius
        }
           
        if let borderWidth = style.borderWidth {
            view.layer.borderWidth = borderWidth
        }
           
        if let borderColor = style.borderColor(forTheme: theme) {
            view.layer.borderColor = borderColor.cgColor
        }
           
        if style.isCircular == true {
            view.clipsToBounds = true
            view.layer.cornerRadius = view.bounds.height / 2
        }
    }

    // MARK: - Apply style to an UILabel
    private func applyStyle(_ style: LabelStyle, toLabel label: UILabel, forTheme themeName: AppTheme = AppTheme.currentTheme) {
        if let stylable = label as? Stylable {
            stylable.stylesHandler.currentStyle = style
        }
          
        if let styleFontName = style.fontName, let styleFontSize = style.fontSize {
            label.font = UIFont(name: styleFontName, size: styleFontSize)
        }
          
        if let colorName = style.textColorStr,
            let theme = AppStyleSheet.shared.themes.filter({$0.themeName == themeName.rawValue }).first {
            label.textColor = theme.color(withName: colorName)?.uiColor
        }
          
        if let numberOfLines = style.numberOfLines {
            label.numberOfLines = numberOfLines
        }
          
        if style.uppercased == true {
            label.text = label.text?.uppercased()
        }
    }
    
    public func applyStyle(_ style: StyleGetter, toLabel label: UILabel, forTheme themeName: AppTheme = AppTheme.currentTheme) {
        guard let _style = style.getStyle() as? LabelStyle else { return }
        self.applyStyle(_style, toLabel: label, forTheme: themeName)
    }

    // MARK: - Apply style to an UITextField
    public func applyStyle(_ style: StyleGetter, toTextField textField: UITextField) {
        guard let _style = style.getStyle() as? LabelStyle else { return }

        if let styleFontName = _style.fontName, let styleFontSize = _style.fontSize {
            textField.font = UIFont(name: styleFontName, size: styleFontSize)
        }
    }

    public func applyStyle(_ style: StyleGetter, toTextView textView: UITextView) {
        guard let _style = style.getStyle() as? LabelStyle else { return }

        if let styleFontName = _style.fontName, let styleFontSize = _style.fontSize {
            textView.font = UIFont(name: styleFontName, size: styleFontSize)
        }
    }
    
    // MARK: - Apply style to an UIButton
    private func applyStyle(_ style: ButtonStyle, toButton button: UIButton, forTheme theme: AppTheme = AppTheme.base) {

        StylesApplicator.shared.applyStyle(style, toView: button)

        if let stylable = button as? Stylable {
            stylable.stylesHandler.currentStyle = style
        }
        
        if let backgroundColor = style.backgroundColor(forTheme: theme) {
            button.backgroundColor = backgroundColor
        }
        
        if let labelStyle = style.labelStyle {
            button.setTitleColor(labelStyle.textColor, for: .normal)
            button.tintColor = labelStyle.textColor
        }

        if let styleFontName = style.labelStyle?.fontName, let styleFontSize = style.labelStyle?.fontSize {
            button.titleLabel?.font = UIFont(name: styleFontName, size: styleFontSize)
    }

        button.contentHorizontalAlignment = style.contentHorizontalAlignment
    }

    public func applyStyle(_ style: StyleGetter, toButton button: UIButton, forTheme theme: AppTheme = AppTheme.base) {
        guard let _style = style.getStyle() as? ButtonStyle else { return }
        self.applyStyle(_style, toButton: button, forTheme: theme)
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


