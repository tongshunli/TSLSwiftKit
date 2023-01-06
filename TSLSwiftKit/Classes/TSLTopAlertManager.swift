//
//  WX_TopAlertManager.swift
//  TSLSwiftKit
//
//  Created by TSL on 2022/11/11.
//  顶部弹框提示

import UIKit

public class TSLTopAlertManager: NSObject {

    static var topAlertView: TSLTopAlertView?
    
    public class func showAlertWithType(_ type: TSLAlertType, alertTitle: String) {
     
        if alertTitle.count == 0 {
            return
        }
        
        if self.topAlertView?.alertTitle == alertTitle { // 该文案已经提示
            return
        }
        
        self.topAlertView?.hiddenAlertView()
        
        DispatchQueue.main.async {
            self.topAlertView = TSLTopAlertView.init()
            self.topAlertView?.alertTitle = alertTitle
            self.topAlertView?.alertType = type
            self.topAlertView?.showAlertView()
        }
    }
    
}
