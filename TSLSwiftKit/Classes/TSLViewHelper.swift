//
//  TSLViewHelper.swift
//  TSLSwiftKit
//
//  Created by TSL on 2022/10/18.
//  UI相关方法封装

import UIKit
import CoreGraphics

public class TSLViewHelper: NSObject {

    /// 获取RootController
    public class func getWindowRootController() -> UIViewController {
        var rootController = kWindow?.rootViewController
        while rootController?.presentedViewController != nil {
            rootController = rootController?.presentedViewController
        }
        return rootController ?? UIViewController()
    }

    /// 获取当前Controller
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
    
    ///  获取当前NavigationController
    public class func getCurrentNavigationController() -> UINavigationController? {
        guard let rootViewController = kWindow?.rootViewController else { return nil }
        
        if rootViewController.isKind(of: UINavigationController.self) {
            return rootViewController as? UINavigationController
        }
        if rootViewController.isKind(of: UITabBarController.self) {
            guard let tabBarController = rootViewController as? UITabBarController else { return nil }
            if tabBarController.selectedViewController?.isKind(of: UINavigationController.self) == true {
                return tabBarController.selectedViewController as? UINavigationController
            }
        }
        return nil
    }

    /// 计算字符串高度
    public class func getStringHeight(_ string: String, maxWidth: CGFloat, contentFont: UIFont, lineHeight: CGFloat) -> CGFloat {
        if string == "" {
            return 0.0
        }
        let paragraphStyle = NSMutableParagraphStyle.init()
        paragraphStyle.lineSpacing = lineHeight
        return floor(string.boundingRect(with: CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude), options: [.truncatesLastVisibleLine, .usesLineFragmentOrigin, .usesFontLeading], attributes: [.font: contentFont, .paragraphStyle: paragraphStyle], context: nil).height) + 1.0
    }

    /// 计算富文本高度
    public class func getAttributedStringHeight(_ attributedString: NSAttributedString?, maxWidth: CGFloat) -> CGFloat {
        guard let attributedString = attributedString else { return 0.0 }
        return floor(attributedString.boundingRect(with: CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude), options: [.truncatesLastVisibleLine, .usesLineFragmentOrigin, .usesFontLeading], context: nil).height) + 1.0
    }

    /// 计算字符串宽
    public class func getStringWidth(_ string: String, contentFont: UIFont) -> CGFloat {
        if string == "" {
            return 0.0
        }
        return floor(string.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude), options: [.truncatesLastVisibleLine, .usesLineFragmentOrigin, .usesFontLeading], attributes: [.font: contentFont], context: nil).width) + 1.0
    }

    /// 设置边角圆弧
    public class func setCornerWithCorner(_ rectCorner: UIRectCorner, view: UIView, size: CGSize, viewFrame: CGRect) {
        let maskPath = UIBezierPath(roundedRect: viewFrame, byRoundingCorners: [rectCorner], cornerRadii: size)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = viewFrame
        maskLayer.path = maskPath.cgPath
        view.layer.mask = maskLayer
    }

    /// 将图片转换成字符串
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

    /// 更正图片方向
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

    /// 绘制一张全新的图片
    class func imageWithImage(_ image: UIImage) -> UIImage {
        UIGraphicsBeginImageContext(CGSize.init(width: image.size.width, height: image.size.height))
        image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }

    /// 图片信息转字符串
    class func imageToString(_ image: UIImage) -> String {
        let imageData = image.jpegData(compressionQuality: 0.7)
        if imageData != nil {
            return "\(imageData!.base64EncodedString())"
        }
        return ""
    }

    /// 图片添加旋转动画
    public class func rotateView(_ animationView: UIView) {
        self.rotateView(animationView, duration: 1)
    }

    public class func rotateView(_ animationView: UIView, duration: CFTimeInterval) {
        self.rotateView(animationView, fromValue: 0, duration: duration)
    }

    public class func rotateView(_ animationView: UIView, fromValue: CGFloat, duration: CFTimeInterval) {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.fromValue = fromValue
        rotationAnimation.toValue = .pi * 2.0
        rotationAnimation.duration = duration
        rotationAnimation.repeatCount = Float.greatestFiniteMagnitude
        animationView.layer.add(rotationAnimation, forKey: "rotationAnimation")
    }
    
    /// 视图转换为图片
    public func viewToImage(view: UIView) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        defer { UIGraphicsEndImageContext() }
        if UIGraphicsGetCurrentContext() != nil {
            view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            return image
        }
        return nil
    }
}
