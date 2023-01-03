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

public let kAppCurrentVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") // 获取当前版本号

public let kAppName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") ?? "" // app名称

public let kBundleIdentifier = Bundle.main.bundleIdentifier // app包名

public let kSystemVersion = UIDevice.current.systemVersion // 获取设备系统号

public let kUUID = UIDevice.current.identifierForVendor?.uuidString // UUID

public let kPhoneModel = UIDevice.current.model // 设备类型

public let kIsIphone = UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone ? true : false // iphone设备

public let kIsIpad = UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad ? true : false // ipad设备

public let kIsIphoneX = (abs(max(kScreenWidth,  kScreenHeight) / min(kScreenWidth, kScreenHeight) - 896.0 / 414.0) < 0.01 || abs(max(kScreenWidth,  kScreenHeight) / min(kScreenWidth, kScreenHeight) - 812.0 / 375.0) < 0.01)

public let kIsDarkMode: Bool = {
    if #available(iOS 13.0, *) {
        return UITraitCollection.current.userInterfaceStyle == UIUserInterfaceStyle.dark
    }
    return false
}()

