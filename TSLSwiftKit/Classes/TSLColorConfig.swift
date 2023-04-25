//
//  TSLColorConfig.swift
//  TSLLibrary
//
//  Created by TSL on 2021/9/18.
//  颜色配制

import UIKit

//  系统色值
public func kColorRGB(_ r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1)
}

public func kColorRGBAlpha(_ r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) -> UIColor {
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}

//  16进制色值
public func kColorWithRGB16(_ h: Int) -> UIColor {
    return kColorRGB(CGFloat(((h)>>16) & 0xFF), g: CGFloat(((h)>>8) & 0xFF), b: CGFloat((h) & 0xFF))
}

public func kColorWithRGB16(_ h: Int, a: CGFloat) -> UIColor {
    return kColorRGBAlpha(CGFloat(((h)>>16) & 0xFF), g: CGFloat(((h)>>8) & 0xFF), b: CGFloat((h) & 0xFF), a: a)
}

//  字符串色值
public func kColorWithHexString(_ color: String, a: CGFloat) -> UIColor {
    
    var cString = color.removeSpaces()
    
    if cString.count < 6 {
        return kClearColor
    }
    
    if cString.hasPrefix("0X") {
        let temStr: NSString = cString as NSString
        
        cString = temStr.substring(from: 2)
    }
    
    if cString.count != 6 {
        return kClearColor
    }
    
    var range = NSMakeRange(0, 2)
    
    let tmpStr2: NSString = cString as NSString
    
    let rString = tmpStr2.substring(with: range)
    
    range = NSMakeRange(2, 2)
    
    let gString = tmpStr2.substring(with: range)
    
    range = NSMakeRange(4, 2)
    
    let bString = tmpStr2.substring(with: range)
    
    var r: UInt64 = 0
    
    var g: UInt64 = 0
    
    var b: UInt64 = 0
    
    Scanner(string: rString).scanHexInt64(&r)
    
    Scanner(string: gString).scanHexInt64(&g)
    
    Scanner(string: bString).scanHexInt64(&b)
    
    return kColorRGBAlpha(CGFloat(r), g: CGFloat(g), b: CGFloat(b), a: a)
}

public func kColorWithHexString(_ color: String) -> UIColor {
    return kColorWithHexString(color, a: 1.0)
}

public let kClearColor = UIColor.clear

public let kWhiteColor = UIColor.white

