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
    case vertical           = 1 // 竖直方向上渐变
    case upwardDiagonalLine = 2 // 向下对角线渐变
    case downDiagonalLine   = 3 // 向上对角线渐变
}

extension UIColor {
    
    public class func colorGradientChangeWithSize(_ size: CGSize, direction: TSLGradientChangeDirection, startColor: UIColor, endColor: UIColor) -> UIColor {
        if CGSizeEqualToSize(size, CGSize.zero) {
            return UIColor.clear
        }
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
        var startPoint = CGPoint.zero
        
        if direction == .downDiagonalLine {
            startPoint = CGPoint(x: 0.0, y: 1.0)
        }
        
        gradientLayer.startPoint = startPoint
        
        var endPoint = CGPoint.zero
        
        switch direction {
        case .level:
            endPoint = CGPoint(x: 1.0, y: 0.0)
        case .vertical:
            endPoint = CGPoint(x: 0.0, y: 1.0)
        case .upwardDiagonalLine:
            endPoint = CGPoint(x: 1.0, y: 1.0)
        case .downDiagonalLine:
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
