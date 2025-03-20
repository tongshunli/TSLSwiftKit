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
    if #available(iOS 15.0, *) {
        return UIApplication.shared.connectedScenes
            .map({ $0 as? UIWindowScene })
            .compactMap({ $0 })
            .first?.windows.first ?? UIWindow()
    } else {
        return UIApplication.shared.windows.first ?? UIWindow()
    }
}()

public let KAppDelegate = UIApplication.shared.delegate

public let kSceneDelegate = UIApplication.shared.connectedScenes.first?.delegate

// MARK: 获取当前版本号
public let kAppCurrentVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") ?? ""

// MARK: app名称
public let kAppName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") ?? ""

// MARK: app包名
public let kBundleIdentifier = Bundle.main.bundleIdentifier ?? ""

// MARK: 获取设备系统号
public let kSystemVersion = UIDevice.current.systemVersion

// MARK: UUID
public let kUUID = UIDevice.current.identifierForVendor?.uuidString

// MARK: 设备类型
public let kPhoneModel = UIDevice.current.model

// MARK: iphone设备
public let kIsIphone = UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone ? true : false

// MARK: ipad设备
public let kIsIpad = UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad ? true : false

public let kIsIphoneX = (abs(max(kScreenWidth, kScreenHeight) / min(kScreenWidth, kScreenHeight) - 896 / 414) < 0.01 || abs(max(kScreenWidth, kScreenHeight) / min(kScreenWidth, kScreenHeight) - 812 / 375) < 0.01)

// MARK: 当前暗黑模式状态
public let kIsDarkMode = UIScreen.main.traitCollection.userInterfaceStyle == .dark

