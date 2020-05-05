//
//  Created by Charles Prado on 05/05/2020.
//  Copyright © 2020 Charles Prado. All rights reserved.
//

import AppTheme
import UIKit

class InfoViewController: UIViewController {
    
    @IBOutlet weak var infoLabel: UILabel!
    var selectedTheme: AppTheme = .base
    
    override func viewWillAppear(_ animated: Bool) {
        setupColorsAndStyles()
    }
    
    func setupColorsAndStyles() {
        view.backgroundColor = ColorName.colorPrimary.uiColor(forTheme: selectedTheme)
        StylesApplicator.shared.applyStyle(LabelStyleType.infoText,
                                           toLabel: infoLabel,
                                           forTheme: selectedTheme)
    }
}

public enum LabelStyleType: String, StyleGetter, CaseIterable {
    case infoText
}
