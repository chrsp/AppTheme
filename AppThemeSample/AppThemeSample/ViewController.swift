//
//  Created by Charles Prado on 04/05/2020.
//  Copyright © 2020 Charles Prado. All rights reserved.
//

import UIKit
import AppTheme

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var bulbasaurThemeSwitch: UISwitch!
    @IBOutlet weak var charmanderThemeSwitch: UISwitch!
    @IBOutlet weak var squirtleThemeSwitch: UISwitch!
    @IBOutlet weak var pikachuThemeSwitch: UISwitch!
    
    @IBOutlet weak var bulbasaurThemeLabel: UILabel!
    @IBOutlet weak var charmanderThemeLabel: UILabel!
    @IBOutlet weak var squirtleThemeLabel: UILabel!
    @IBOutlet weak var pikachuThemeLabel: UILabel!
    @IBOutlet weak var randomButton: UIButton!
    
    private var selectedTheme: AppTheme = .base
    
    var themeSwitches: [UISwitch] {
        [bulbasaurThemeSwitch, charmanderThemeSwitch, squirtleThemeSwitch, pikachuThemeSwitch]
    }
    
    var themeLabels: [UILabel] {
        [bulbasaurThemeLabel, charmanderThemeLabel, squirtleThemeLabel, pikachuThemeLabel]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupColorsAndStyles()
        StylesApplicator.shared.applyStyle(ButtonStyleType.primaryButton, toButton: randomButton)
    }
    
    func setupColorsAndStyles(forTheme theme: AppTheme = .base) {
        selectedTheme = theme
        
        view.backgroundColor = ColorName.colorPrimary.uiColor(forTheme: theme)
        themeSwitches.forEach { themeSwitch in
            themeSwitch.onTintColor = ColorName.colorSurface.uiColor(forTheme: theme)
        }
        setupImageView()
        StylesApplicator.shared.applyStyle(ButtonStyleType.primaryButton, toButton: randomButton, forTheme: selectedTheme)
    }
    
    private func setupLabels(selectedLabel: UILabel) {
        themeLabels.forEach { label in
            if label == selectedLabel {
                label.textColor = ColorName.textColorPrimary.uiColor(forTheme: selectedTheme)
            } else {
                label.textColor = ColorName.textColorSecondary.uiColor(forTheme: selectedTheme)
            }
        }
        
        randomButton.titleLabel?.textColor = ColorName.textColorPrimary.uiColor(forTheme: selectedTheme)
    }
    
    private func disableAllSwitchs(except selectedSwitch: UISwitch) {
        for themeSwitch in themeSwitches where themeSwitch != selectedSwitch {
            themeSwitch.isOn = false
        }
    }
    
    private func setupImageView() {
        imageView.image = UIImage(named: selectedTheme.rawValue)
    }
    
    @IBAction func bulbasaurSwitchAction(_ sender: Any) {
        disableAllSwitchs(except: sender as! UISwitch)
        setupColorsAndStyles(forTheme: .bulbasaur)
        setupLabels(selectedLabel: bulbasaurThemeLabel)
    }
    
    @IBAction func charmanderSwitchAction(_ sender: Any) {
        disableAllSwitchs(except: sender as! UISwitch)
        setupColorsAndStyles(forTheme: .charmander)
        setupLabels(selectedLabel: charmanderThemeLabel)
    }
    
    @IBAction func squirtleSwitchAction(_ sender: Any) {
        disableAllSwitchs(except: sender as! UISwitch)
        setupColorsAndStyles(forTheme: .squirtle)
        setupLabels(selectedLabel: squirtleThemeLabel)
    }
    
    @IBAction func pikachuSwitchAction(_ sender: Any) {
        disableAllSwitchs(except: sender as! UISwitch)
        setupColorsAndStyles(forTheme: .pikachu)
        setupLabels(selectedLabel: pikachuThemeLabel)
    }
}


public enum ButtonStyleType: String, StyleGetter, CaseIterable {
    case primaryButton
}
