//
//  TSLExtensionView.swift
//  MyEngineeringCollection
//
//  Created by 佟顺利 on 2025/5/28.
//

import Foundation
import UIKit

public enum UIBorderSideType: Int {
    /// 全边框
    case all
    /// 上侧边框
    case top
    /// 下侧边框
    case bottom
    /// 左侧边框
    case left
    /// 右侧边框
    case right
}

extension UIView {
    public func addBorderLineWithBorderWidth(_ borderWidth: CGFloat, borderColor: UIColor, cornerRadius: CGFloat, borderType: UIBorderSideType) {
        let space = borderWidth / 2
        switch borderType {
        case .all:
            let lineBorder = CAShapeLayer()
            lineBorder.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
            lineBorder.lineWidth = borderWidth
            lineBorder.strokeColor = borderColor.cgColor
            lineBorder.fillColor = kClearColor.cgColor

            let path = UIBezierPath(roundedRect: lineBorder.frame, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
            lineBorder.path = path.cgPath
            self.layer.addSublayer(lineBorder)
        case .left:
            self.layer.addSublayer(self.addLineOriginPoint(CGPoint(x: 0, y: space), toPoint: CGPoint(x: 0, y: self.frame.size.height - space), color: borderColor, borderWidth: borderWidth))
        case .right:
            self.layer.addSublayer(self.addLineOriginPoint(CGPoint(x: self.frame.size.width, y: space), toPoint: CGPoint(x: self.frame.size.width, y: self.frame.size.height - space), color: borderColor, borderWidth: borderWidth))
        case .top:
            self.layer.addSublayer(self.addLineOriginPoint(CGPoint(x: space, y: 0.0), toPoint: CGPoint(x: self.frame.size.width - space, y: 0.0), color: borderColor, borderWidth: borderWidth))
        case .bottom:
            self.layer.addSublayer(self.addLineOriginPoint(CGPoint(x: space, y: self.frame.size.height), toPoint: CGPoint(x: self.frame.size.width - space, y: self.frame.size.height), color: borderColor, borderWidth: borderWidth))
        }
    }

    func addLineOriginPoint(_ originPoint: CGPoint, toPoint: CGPoint, color: UIColor, borderWidth: CGFloat) -> CAShapeLayer {
        /// 线的路径
        let bezierPath = UIBezierPath()
        bezierPath.move(to: originPoint)
        bezierPath.addLine(to: toPoint)

        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.fillColor = kClearColor.cgColor
        shapeLayer.path = bezierPath.cgPath /// 添加路径
        shapeLayer.lineWidth = borderWidth /// 线宽度
        return shapeLayer
    }
    
    /// 设置部分圆角
    public func addRoundCorners(_ corners: UIRectCorner, radii: CGFloat) {
        let bezierpath:UIBezierPath = UIBezierPath.init(roundedRect: (self.bounds), byRoundingCorners: corners, cornerRadii: CGSize(width: radii, height: radii))
        let shape:CAShapeLayer = CAShapeLayer.init()
        shape.path = bezierpath.cgPath
        self.layer.mask = shape
    }
}
