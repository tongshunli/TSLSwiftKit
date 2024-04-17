//
//  TSLLocalizedManager.swift
//  TSLSwiftKit
//
//  Created by TSL on 2023/4/25.
//  翻译文案

import UIKit

//  支持语言类型
public enum LocalizedLanguage: Int {
    case defaultLanguage    = 0 //  跟随系统
    case simplifiedChinese  = 1 //  简体中文
    case traditionalChinese = 2 //  繁体中文
    case english            = 3 //  英文
    case tail               = 4 //  泰语
    case spanish            = 5 //  西班牙语
    case portugal           = 6 //  葡萄牙语
}

//  用户设置的语言
let TSLUserLanguage = "TSLUserLanguage"

public func TSLLocalizedString(_ key: String) -> String {
    return TSLLocalizedManager.stringWithKey(key)
}

public class TSLLocalizedManager: NSObject {

    //  语言库没有时的默认语言
    static var defaultLanguage = "en"
    
    public class func stringWithKey(_ key: String) -> String {
        return TSLLocalizedManager().languageBundle?.localizedString(forKey: key, value: nil, table: "InfoPlist") ?? key
    }
    
    lazy var languageBundle: Bundle? = {
        let path = Bundle.main.path(forResource: TSLLocalizedManager.getUserLanguageName(), ofType: "lproj")
        var languageBundle = Bundle(path: path ?? "")
        return languageBundle
    }()
    
    //  用户本地语言,如果语言包中没有,返回默认值
    public class func getUserLanguageName() -> String {
        let userLanguageName = UserDefaults.standard.string(forKey: TSLUserLanguage)
        
        return userLanguageName ?? TSLLocalizedManager.stringFromLocalizedLanguage(.defaultLanguage)
    }
    
    //  设置默认语言
    public class func setUpDefaultLanguage(_ language: String) {
        self.defaultLanguage = language
    }
    
    /// 获取当前语言
    public class func getUserLanguage() -> LocalizedLanguage {
        return self.localizedLanguageFromString(TSLLocalizedManager.getUserLanguageName())
    }
    
    public class func stringFromLocalizedLanguage(_ language: LocalizedLanguage) -> String {
        switch language {
        case .english:
            return "en"
        case .simplifiedChinese:
            return "zh-Hans"
        case .traditionalChinese:
            return "zh-Hant"
        case .tail:
            return "th"
        case .spanish:
            return "es"
        case .portugal:
            return "pt-PT"
        case .defaultLanguage:
            let languages = Locale.preferredLanguages
            let tmpLanguage = TSLLocalizedManager.localizedLanguageFromString(languages.first ?? "")
            if tmpLanguage == .defaultLanguage {
                return TSLLocalizedManager.defaultLanguage
            }
            return TSLLocalizedManager.stringFromLocalizedLanguage(tmpLanguage)
        }
    }
    
    public class func localizedLanguageFromString(_ language: String) -> LocalizedLanguage {
        switch language {
        case "en":
            return .english
        case "zh-Hans":
            return .simplifiedChinese
        case "zh-Hant":
            return .traditionalChinese
        case "th":
            return .tail
        case "es":
            return .spanish
        case "pt-PT":
            return .portugal
        default:
            return .defaultLanguage
        }
    }

    /// 设置APP语言
    public class func setLanguage(_ language: LocalizedLanguage) {
        UserDefaults.standard.setValue(stringFromLocalizedLanguage(language), forKey: TSLUserLanguage)
    }
    
}
