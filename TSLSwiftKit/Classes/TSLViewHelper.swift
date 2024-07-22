//
//  TSLViewHelper.swift
//  TSLSwiftKit
//
//  Created by TSL on 2022/10/18.
//  UI相关方法封装

import UIKit
import CoreGraphics

public class TSLViewHelper: NSObject {

    // MARK: 获取RootController
    public class func getWindowRootController() -> UIViewController {
        var rootController = kWindow?.rootViewController
        while rootController?.presentedViewController != nil {
            rootController = rootController?.presentedViewController
        }
        return rootController!
    }
    
    // MARK: 获取当前Controller
    public class func getCurrentViewController() -> UIViewController? {
        var result = kWindow?.rootViewController
        
        while result?.presentedViewController != nil {
            result = result?.presentedViewController
        }
        
        if result?.isKind(of: UITabBarController.self) != nil {
            result = (result as? UITabBarController)?.selectedViewController
        }
        
        if result?.isKind(of: UINavigationController.self) != nil {
            result = (result as? UINavigationController)?.visibleViewController
        }
        
        return result ?? nil
    }
    
    // MARK: 计算字符串高
    public class func getStringHeight(_ string: String, maxWidth: CGFloat, contentFont: UIFont, lineHeight: CGFloat) -> CGFloat {
                
        if string == "" {
            return 0.0
        }
        
        let paragraphStyle = NSMutableParagraphStyle.init()
        paragraphStyle.lineSpacing = lineHeight
        
        return floor(string.boundingRect(with: CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude), options: [.truncatesLastVisibleLine, .usesLineFragmentOrigin, .usesFontLeading], attributes: [.font: contentFont, .paragraphStyle: paragraphStyle], context: nil).height) + 1.0
    }
    
    // MARK: 计算字符串宽
    public class func getStringWidth(_ string: String, contentFont: UIFont) -> CGFloat {
                
        if string == "" {
            return 0.0
        }
        
        return floor(string.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude), options: [.truncatesLastVisibleLine, .usesLineFragmentOrigin, .usesFontLeading], attributes: [.font: contentFont], context: nil).width) + 1.0
    }
    
    // MARK: 设置边角圆弧
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
    
    // MARK: 将图片转换成字符串
    public class func getBase64StringWithImageData(_ imageData: Data?) -> String {
        if imageData == nil {
            return ""
        }
        
        let image = UIImage(data: imageData!)
        if image == nil {
            return ""
        }
        
        let fixImage = self.fixOrientation(image!)
        
        return self.imageToString(self.imageWithImage(fixImage))
    }
    
    // MARK: 更正图片方向
    class func fixOrientation(_ image: UIImage) -> UIImage {
        if image.imageOrientation == .up {
            return image
        }
        
        var transform = CGAffineTransform.identity
        
        switch image.imageOrientation {
        case .down:
            transform = CGAffineTransformTranslate(transform, image.size.width, image.size.height)
            transform = CGAffineTransformRotate(transform, .pi)
        case .downMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, image.size.height)
            transform = CGAffineTransformRotate(transform, .pi)
        case .left:
            transform = CGAffineTransformTranslate(transform, image.size.width, 0)
            transform = CGAffineTransformRotate(transform, .pi / 2)
        case .leftMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, 0)
            transform = CGAffineTransformRotate(transform, .pi / 2)
        case .right:
            transform = CGAffineTransformTranslate(transform, 0, image.size.height)
            transform = CGAffineTransformRotate(transform, -.pi / 2)
        case .rightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, image.size.height)
            transform = CGAffineTransformRotate(transform, -.pi / 2)
        default:
            break
        }
        
        switch image.imageOrientation {
        case .upMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, 0)
            transform = CGAffineTransformScale(transform, -1.0, -1.0)
        case .downMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, 0)
            transform = CGAffineTransformScale(transform, -1.0, -1.0)
        case .leftMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.height, 0)
            transform = CGAffineTransformScale(transform, -1.0, 1.0)
        case .rightMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.height, 0)
            transform = CGAffineTransformScale(transform, -1.0, 1.0)
        default:
            break
        }
        
        let textRef = CGContext(data: nil, width: Int(image.size.width), height: Int(image.size.height), bitsPerComponent: image.cgImage!.bitsPerComponent, bytesPerRow: 0, space: image.cgImage!.colorSpace!, bitmapInfo: image.cgImage!.bitmapInfo.rawValue)
        textRef?.concatenate(transform)
        
        switch image.imageOrientation {
        case .left:
            textRef?.draw(image.cgImage!, in: CGRect.init(x: 0, y: 0, width: image.size.height, height: image.size.width))
        case .leftMirrored:
            textRef?.draw(image.cgImage!, in: CGRect.init(x: 0, y: 0, width: image.size.height, height: image.size.width))
        case .right:
            textRef?.draw(image.cgImage!, in: CGRect.init(x: 0, y: 0, width: image.size.height, height: image.size.width))
        case .rightMirrored:
            textRef?.draw(image.cgImage!, in: CGRect.init(x: 0, y: 0, width: image.size.height, height: image.size.width))
        default:
            textRef?.draw(image.cgImage!, in: CGRect.init(x: 0, y: 0, width: image.size.width, height: image.size.height))
        }
        
        guard let cgimage = textRef?.makeImage() else {
            return image
        }

        return UIImage(cgImage: cgimage)
    }
    
    // MARK: 绘制一张全新的图片
    class func imageWithImage(_ image: UIImage) -> UIImage {
        UIGraphicsBeginImageContext(CGSize.init(width: image.size.width, height: image.size.height))
        image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    // MARK: 图片信息转字符串
    class func imageToString(_ image: UIImage) -> String {
        let imageData = image.jpegData(compressionQuality: 0.7)
        
        if imageData != nil {
            return "\(imageData!.base64EncodedString())"
        }
        
        return ""
    }

}
