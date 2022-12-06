//
//  TSL_FrameDefine.swift
//  TSLLibrary
//
//  Created by TSL on 2021/9/2.
//  尺寸配制

import UIKit
    
public let kScreenWidth = UIScreen.main.bounds.size.width

public let kScreenHeight = UIScreen.main.bounds.size.height

public let kMargin = 20.0

public let kMoreHalfMargin = 15.0

public let kHalfMargin = 10.0

public let kQuarterMargin = 5.0

public let kLineHeight = 0.5

public let kStatusBarHeight = kIsIphoneX ? 44.0 : 20.0

public let kNavbarHeight = kIsIphoneX ? 88.0 : 64.0

public let kTabbarHeight = kIsIphoneX ? 83.0 : 49.0

public let kAnimatedDuration = 0.4 // 动画时长

//  根据比例缩放
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

