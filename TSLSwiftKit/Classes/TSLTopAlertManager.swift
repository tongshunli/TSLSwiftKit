//
//  WX_TopAlertManager.swift
//  TSLSwiftKit
//
//  Created by TSL on 2022/11/11.
//  顶部弹框提示

import UIKit

public enum TSLTopAlertMaskType: Int {
    /// 默认类型，Alert显示时可以响应用户交互事件。
    case maskNone
    /// 不响应用户交互事件，背景透明。
    case maskClear
    /// 不响应用户交互事件，背景调暗。
    case maskBlack
}

public enum TSLTopAlertStyle: Int {
    // 默认样式，白色的转圈动画。
    case light
    // 灰色的转圈动画。
    case dark
}

public class TSLTopAlertManager: NSObject {

    static var topAlertView: TSLTopAlertView?
    
    static var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    
    static var maskBackView: UIView = TSLUIFactory.view()
    
    public class func showAlertWithType(_ type: TSLAlertType, alertTitle: String) {
        if alertTitle.count == 0 {
            return
        }
        if self.topAlertView?.alertTitle == alertTitle { // 该文案已经提示
            return
        }
        if self.topAlertView != nil {
            self.topAlertView?.hiddenAlertView()
        }
        var duration = 1.0
        if type == .loading {
            duration = 30.0
        }
        DispatchQueue.main.async {
            self.topAlertView = TSLTopAlertView.init()
            self.topAlertView?.alertTitle = alertTitle
            self.topAlertView?.alertType = type
            self.topAlertView?.alertDuration = duration
            self.topAlertView?.showAlertView()
        }
    }

    public class func hiddenAlertView() {
        if self.topAlertView != nil {
            self.topAlertView?.hiddenAlertView()
        }
    }
    
    public class func hideLoading() {
        self.activityIndicator.stopAnimating()
        if self.maskBackView.superview != nil {
            self.maskBackView.removeFromSuperview()
        }
    }
    
    public class func showAlertWithLoading(_ type: TSLTopAlertMaskType, style: TSLTopAlertStyle) {
        guard let window = kWindow else { return }
        
        self.activityIndicator.center = window.center
        
        // 设置动画颜色
        if style == .light {
            self.activityIndicator.color = UIColor.white
        }
        if style == .dark {
            self.activityIndicator.color = .darkGray
        }
        
        // 设置动画的蒙层
        if type == .maskNone {
            window.addSubview(self.activityIndicator)
        }
        if type == .maskClear {
            self.maskBackView.frame = UIScreen.main.bounds
            if type == .maskBlack {
                self.maskBackView.backgroundColor = kColorRGBAlpha(0, green: 0, blue: 0, alpha: 0.5)
            } else {
                self.maskBackView.backgroundColor = UIColor.clear
            }
            window.addSubview(self.maskBackView)
            window.addSubview(self.activityIndicator)
        }
        self.activityIndicator.startAnimating()
    }
}
