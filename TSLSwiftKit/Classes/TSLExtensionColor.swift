//
//  TSLExtensionColor.swift
//  TSLSwiftKit
//
//  Created by TSL on 2022/10/18.
//  渐变色

import Foundation
import UIKit

public enum TSLGradientChangeDirection: Int {
    case level              = 0 // 水平方向上渐变
    case Vertical           = 1 // 竖直方向上渐变
    case UpwardDiagonalLine = 2 // 向下对角线渐变
    case DownDiagonalLine   = 3 // 向上对角线渐变
}

public extension UIColor {
    
    public class func colorGradientChangeWithSize(_ size: CGSize, direction: TSLGradientChangeDirection, startColor: UIColor, endColor: UIColor) -> UIColor {
        if CGSizeEqualToSize(size, CGSizeZero) || startColor == nil || endColor == nil {
            return UIColor.clear
        }
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
        var startPoint = CGPointZero
        
        if direction == .DownDiagonalLine {
            startPoint = CGPoint(x: 0.0, y: 1.0)
        }
        
        gradientLayer.startPoint = startPoint
        
        var endPoint = CGPointZero
        
        switch direction {
        case .level :
            endPoint = CGPoint(x: 1.0, y: 0.0)
        case .Vertical :
            endPoint = CGPoint(x: 0.0, y: 1.0)
        case .UpwardDiagonalLine :
            endPoint = CGPoint(x: 1.0, y: 1.0)
        case .DownDiagonalLine :
            endPoint = CGPoint(x: 1.0, y: 0.0)
        }
        
        gradientLayer.endPoint = endPoint
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        
        UIGraphicsBeginImageContext(size)
        
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return UIColor.init(patternImage: image!)
    }
    
}
