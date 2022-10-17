//
//  TSLSystemConfig.swift
//  TSLLibrary
//
//  Created by TSL on 2021/9/17.
//

import UIKit

public let kDocumentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)

public let kCachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)

public let keyWindow: UIWindow? = {
    var window: UIWindow?
    if #available(iOS 13.0, *) {
        for window in UIApplication.shared.windows {
            if window.isHidden == false {
                return window
            }
        }
    } else {
        window = UIApplication.shared.keyWindow
    }
    return window
}()

public let KAppDelegate = UIApplication.shared.delegate

public let kAppCurrentVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") // 获取当前版本号

public let kSystemVersion = UIDevice.current.systemVersion // 获取设备系统号

public let kIsIphone = UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone ? true : false // iphone设备

public let kIsIpad = UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad ? true : false // ipad设备

public let kIsIphoneX = (abs(max(kScreenWidth,  kScreenHeight) / min(kScreenWidth, kScreenHeight) - 896 / 414) < 0.01 || abs(max(kScreenWidth,  kScreenHeight) / min(kScreenWidth, kScreenHeight) - 812 / 375) < 0.01)

public let kIsDarkMode: Bool = {
    if #available(iOS 13.0, *) {
        return UITraitCollection.current.userInterfaceStyle == UIUserInterfaceStyle.dark
    }
    return false
}()

