//
//  TSLColorConfig.swift
//  TSLLibrary
//
//  Created by TSL on 2021/9/18.
//  颜色配制

import UIKit

//  系统色值
public func kColorRGB(_ red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
    return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1)
}

public func kColorRGBAlpha(_ red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
    return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
}

//  16进制色值
public func kColorWithRGB16(_ rgb: Int) -> UIColor {
    return kColorRGB(CGFloat(((rgb)>>16) & 0xFF), green: CGFloat(((rgb)>>8) & 0xFF), blue: CGFloat((rgb) & 0xFF))
}

public func kColorWithRGB16(_ rgb: Int, alpha: CGFloat) -> UIColor {
    return kColorRGBAlpha(CGFloat(((rgb)>>16) & 0xFF), green: CGFloat(((rgb)>>8) & 0xFF), blue: CGFloat((rgb) & 0xFF), alpha: alpha)
}

//  字符串色值
public func kColorWithHexString(_ color: String, alpha: CGFloat) -> UIColor {
    
    var cString = color.removeSpaces()
    
    if cString.count < 6 {
        return kClearColor
    }
    
    if cString.hasPrefix("#") {
        let temStr: NSString = cString as NSString
        
        cString = temStr.substring(from: 1)
    } else if cString.hasPrefix("0X") {
        let temStr: NSString = cString as NSString
        
        cString = temStr.substring(from: 2)
    }
    
    if cString.count != 6 {
        return kClearColor
    }
    
    var range = NSRange(location: 0, length: 2)
    
    let tmpStr2: NSString = cString as NSString
    
    let rString = tmpStr2.substring(with: range)
    
    range = NSRange(location: 2, length: 2)
    
    let gString = tmpStr2.substring(with: range)
    
    range = NSRange(location: 4, length: 2)
    
    let bString = tmpStr2.substring(with: range)
    
    var red: UInt64 = 0
    
    var green: UInt64 = 0
    
    var blue: UInt64 = 0
    
    Scanner(string: rString).scanHexInt64(&red)
    
    Scanner(string: gString).scanHexInt64(&green)
    
    Scanner(string: bString).scanHexInt64(&blue)
    
    return kColorRGBAlpha(CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: alpha)
}

public func kColorWithHexString(_ color: String) -> UIColor {
    return kColorWithHexString(color, alpha: 1.0)
}

public let kClearColor = UIColor.clear

