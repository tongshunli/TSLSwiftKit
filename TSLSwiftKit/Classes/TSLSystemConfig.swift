//
//  TSLSystemConfig.swift
//  TSLLibrary
//
//  Created by TSL on 2021/9/17.
//  系统信息

import UIKit

public let kDocumentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)

public let kCachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)

public let kWindow: UIWindow? = {
    var window: UIWindow?
    if #available(iOS 15.0, *) {
        guard let windows = UIApplication.shared.connectedScenes.map({ $0 as? UIWindowScene }).compactMap({ $0 }).first?.windows else { return UIWindow() }
        for tmpWindow in windows where tmpWindow.isHidden == false {
            window = tmpWindow
        }
    } else {
        window = UIApplication.shared.windows.first
    }
    return window
}()

public let KAppDelegate = UIApplication.shared.delegate

public let kSceneDelegate = UIApplication.shared.connectedScenes.first?.delegate

/// 获取当前版本号
public let kAppCurrentVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") ?? ""

/// app Logo
public func kAppLogo() -> String {
    guard let logos = Bundle.main.object(forInfoDictionaryKey: "CFBundleIconFiles") as? [String] else { return "" }
    return logos.last ?? ""
}

/// app名称
public let kAppName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") ?? ""

/// app包名
public let kBundleIdentifier = Bundle.main.bundleIdentifier ?? ""

/// 获取设备系统号
public let kSystemVersion = UIDevice.current.systemVersion

/// UUID
public let kUUID = UIDevice.current.identifierForVendor?.uuidString

/// 设备类型
public let kPhoneModel = UIDevice.current.model

/// iphone设备
public let kIsIphone = UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone ? true : false

/// ipad设备
public let kIsIpad = UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad ? true : false

public let kIsIphoneX = (abs(max(kScreenWidth, kScreenHeight) / min(kScreenWidth, kScreenHeight) - 896 / 414) < 0.01 || abs(max(kScreenWidth, kScreenHeight) / min(kScreenWidth, kScreenHeight) - 812 / 375) < 0.01)

/// 当前暗黑模式状态
public let kIsDarkMode = UIScreen.main.traitCollection.userInterfaceStyle == .dark
