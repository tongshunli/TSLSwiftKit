//
//  TSLViewHelper.swift
//  TSLSwiftKit
//
//  Created by TSL on 2022/10/18.
//

import UIKit

public class TSLViewHelper: NSObject {

    public class func getWindowRootController() -> UIViewController {
        var rootController = kWindow?.rootViewController
        while rootController?.presentedViewController != nil {
            rootController = rootController?.presentedViewController
        }
        return rootController!
    }
    
    public class func getCurrentViewController() -> UIViewController? {
        var result = kWindow?.rootViewController
        
        while result?.presentedViewController != nil {
            result = result?.presentedViewController
        }
        
        if (result?.isKind(of: UITabBarController.self) != nil)  {
            result = (result as! UITabBarController).selectedViewController
        }
        
        if (result?.isKind(of: UINavigationController.self) != nil)  {
            result = (result as! UINavigationController).visibleViewController
        }
        
        return result ?? nil
    }
    
    public class func getStringHeight(_ string: String, maxWidth: CGFloat, contentFont: UIFont, lineHeight: CGFloat) -> CGFloat {
                
        if string == "" {
            return 0.0
        }
        
        let paragraphStyle = NSMutableParagraphStyle.init()
        paragraphStyle.lineSpacing = lineHeight
        
        let attributedString = NSMutableAttributedString.init(string: string)
        
        return floor((string as! NSString).boundingRect(with: CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude), options: [.truncatesLastVisibleLine , .usesLineFragmentOrigin , .usesFontLeading], attributes: [.font: contentFont, .paragraphStyle: paragraphStyle], context: nil).height) + kQuarterMargin
    }
    
    public class func getStringWidth(_ string: String, contentFont: UIFont, lineHeight: CGFloat) -> CGFloat {
                
        if string == "" {
            return 0.0
        }
        
        let paragraphStyle = NSMutableParagraphStyle.init()
        paragraphStyle.lineSpacing = lineHeight
        
        let attributedString = NSMutableAttributedString.init(string: string)
        
        return floor((string as! NSString).boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude), options: [.truncatesLastVisibleLine , .usesLineFragmentOrigin , .usesFontLeading], attributes: [.font: contentFont, .paragraphStyle: paragraphStyle], context: nil).width) + kQuarterMargin
    }
    
    
    public class func setStateBarLightStyle() {
        UIApplication.shared.isStatusBarHidden = false
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    public class func setStateBarDefaultStyle() {
        UIApplication.shared.isStatusBarHidden = false
        if #available(iOS 13.0, *) {
            UIApplication.shared.statusBarStyle = .darkContent
        } else {
            UIApplication.shared.statusBarStyle = .default
        }
    }
    
    //  设置边角圆弧
    public class func setCornerWithLeftTopCorner(_ leftTop: CGFloat, rightTop: CGFloat, bottemLeft: CGFloat, bottemRight: CGFloat, view: UIView, frame: CGRect) {
     
        let width = frame.size.width
        let height = frame.size.height
        
        let maskPath = UIBezierPath()
        maskPath.lineWidth = 1.0
        maskPath.lineCapStyle = .round
        maskPath.lineJoinStyle = .round
        maskPath.move(to: CGPoint(x: bottemRight, y: height)) // 左下角
        maskPath.addLine(to: CGPoint(x: width - bottemRight, y: height))
        
        maskPath.addQuadCurve(to: CGPoint(x: width, y: height - bottemRight), controlPoint: CGPoint(x: width, y: height)) // 右下角的圆弧
        maskPath.addLine(to: CGPoint(x: width, y: height)) // 右边直线
        
        maskPath.addQuadCurve(to: CGPoint(x: width - rightTop, y: 0), controlPoint: CGPoint.init(x: width, y: 0)) // 右上角圆弧
        maskPath.addLine(to: CGPoint.init(x: leftTop, y: 0)) // 顶部直线
        
        maskPath.addQuadCurve(to: CGPoint(x: 0, y: leftTop), controlPoint: CGPoint(x: 0, y: 0)) // 左上角圆弧
        maskPath.addLine(to: CGPoint(x: 0, y: height - bottemLeft)) // 左边直线
        maskPath.addQuadCurve(to: CGPoint(x: bottemLeft, y: height), controlPoint: CGPoint(x: 0, y: height))
        
        let maskLayer = CAShapeLayer()
        maskLayer.frame = frame
        maskLayer.path = maskPath.cgPath
        view.layer.mask = maskLayer
    }
    
}
