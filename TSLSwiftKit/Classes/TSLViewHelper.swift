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
    
    public class func getAttributedStringHeight(_ labelAttributedString: NSAttributedString, rectWidth rectWidth: CGFloat, contentFont font: UIFont) -> CGFloat {
                
        let rect = labelAttributedString.boundingRect(with: CGSize.init(width: rectWidth, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)

        //  增加一行高度,防止控件在文字不到边的时候换行,导致文字显示不全的问题
        let tmpStr = "一行"
        let oneLineHeight = tmpStr.boundingRect(with: CGSize.init(width: rectWidth, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil).size.height

        return rect.size.height + oneLineHeight + kQuarterMargin
    }
    
    
}
