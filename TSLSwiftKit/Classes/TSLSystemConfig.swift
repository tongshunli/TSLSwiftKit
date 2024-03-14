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
    var originalKeyWindow: UIWindow?

    #if swift(>=5.1)
    if #available(iOS 13, *) {
        originalKeyWindow = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first(where: { $0.isKeyWindow })
    } else {
        originalKeyWindow = UIApplication.shared.keyWindow
    }
    #else
    originalKeyWindow = UIApplication.shared.keyWindow
    #endif
    return originalKeyWindow
}()

public let KAppDelegate = UIApplication.shared.delegate

/// 获取当前版本号
public let kAppCurrentVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString")

/// app名称
public let kAppName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") ?? ""

/// app包名
public let kBundleIdentifier = Bundle.main.bundleIdentifier

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

public let kIsDarkMode: Bool = {
    if #available(iOS 13.0, *) {
        return UITraitCollection.current.userInterfaceStyle == UIUserInterfaceStyle.dark
    }
    return false
}()
