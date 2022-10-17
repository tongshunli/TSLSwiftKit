//
//  TSLColorConfig.swift
//  TSLLibrary
//
//  Created by TSL on 2021/9/18.
//

import UIKit

public func kColorRGB(_ r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1)
}

public func kColorRGBAlpha(_ r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) -> UIColor {
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}

public func kColorWithRGB16(_ h: Int) ->UIColor {
    return kColorRGB(CGFloat(((h)>>16) & 0xFF), g: CGFloat(((h)>>8) & 0xFF), b: CGFloat((h) & 0xFF))
}

public func kColorWithRGB16(_ h: Int, a: CGFloat) ->UIColor {
    return kColorRGBAlpha(CGFloat(((h)>>16) & 0xFF), g: CGFloat(((h)>>8) & 0xFF), b: CGFloat((h) & 0xFF), a: a)
}

