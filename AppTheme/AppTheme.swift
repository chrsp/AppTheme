//
//  Created by Charles Prado on 13/11/19.
//  Copyright © 2019 Charles Prado. All rights reserved.
//

import UIKit

public enum AppTheme: String {
    
    case light
    case dark
    case base
    case bulbasaur
    case squirtle
    case charmander
    case pikachu

    //public static var shouldUseThemeDefinedByTheUserHasChanged = Variable<Bool>(shouldUseThemeDefinedByTheUser)
    
    @UserDefaultsStorage(key: "themeDefinedByTheUser", defaultValue: "")
    static var themeDefinedByTheUser: String
    
    @UserDefaultsStorage(key: "shouldUseThemeDefinedByTheUser", defaultValue: false)
    static var shouldUseThemeDefinedByTheUser: Bool
    
    public static var currentTheme: AppTheme {
        if let themeDefinedByTheUser = AppTheme(rawValue: themeDefinedByTheUser) {
            return themeDefinedByTheUser
        } else {
            return themeDefinedByTheOS
        }
    }
    
    public static var isThemeDefinedByTheUser: Bool {
        return shouldUseThemeDefinedByTheUser
    }
    
    public static func changeTheme(to theme: AppTheme) {
        themeDefinedByTheUser = theme.rawValue
    }
    
    public static func shouldUseThemeDefinedByTheUser(_ flag: Bool) {
        shouldUseThemeDefinedByTheUser = flag
        //shouldUseThemeDefinedByTheUserHasChanged.value = flag
        
        if !flag { themeDefinedByTheUser = "" }
    }
    
    private static var themeDefinedByTheOS: AppTheme {
        if #available(iOS 13.0, *, *) {
            switch UITraitCollection.current.userInterfaceStyle {
            case .dark: return .dark
            default: return .light
            }
        } else {
            return .light
        }
    }
    
    @available(iOS 12.0, *)
    public var uiUserInterfaceStyle: UIUserInterfaceStyle {
        switch self {
        case .dark: return .dark
        default: return .light
        }
    }
}

