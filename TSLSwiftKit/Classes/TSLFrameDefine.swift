//
//  TSL_FrameDefine.swift
//  TSLLibrary
//
//  Created by TSL on 2021/9/2.
//  尺寸配制

import UIKit

public let kScreenWidth = UIScreen.main.bounds.size.width

public let kScreenHeight = UIScreen.main.bounds.size.height

public func kStatusBarHeight() -> CGFloat {
    guard let topHeight = kWindow?.safeAreaInsets.top else {
        if kIsIphoneX == true {
            return 44.0
        } else {
            return 20.0
        }
    }
    if topHeight > 0 {
        return topHeight
    } else {
        if kIsIphoneX == true {
            return 44.0
        } else {
            return 20.0
        }
    }
}

public let kNavbarHeight = kStatusBarHeight() + 44.0

public func kTabBarOffsetHeight() -> CGFloat {
    guard let botHeight = kWindow?.safeAreaInsets.bottom else {
        if kIsIphoneX == true {
            return 34.0
        }
        return 0
    }
    if botHeight > 0 {
        return botHeight
    } else {
        if kIsIphoneX == true {
            return 34.0
        }
    }
    return 0
}

public let kTabBarHeight = kTabBarOffsetHeight() + 49

/// 线条高度
public let kLineHeight = kIsIphoneX ? 1.0 : 0.5

/// 动画时长
public let kAnimatedDuration = 0.4

/// 根据比例缩放
public func kGeometricHeight(_ width: CGFloat, proportionWidth: CGFloat, proportionHeight: CGFloat) -> CGFloat {
    return floor(width * proportionHeight / proportionWidth)
}

public func kGeometricWidth(_ height: CGFloat, proportionWidth: CGFloat, proportionHeight: CGFloat) -> CGFloat {
    return floor(height * proportionWidth / proportionHeight)
}

public func kFont(_ fontSize: CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: fontSize)
}

public func kBoldFont(_ fontSize: CGFloat) -> UIFont {
    return UIFont.boldSystemFont(ofSize: fontSize)
}
