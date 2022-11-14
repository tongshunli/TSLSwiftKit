//
//  TSLExtensionLabel.swift
//  TSLSwiftKit
//
//  Created by TSL on 2022/11/4.
//  Label宽高计算

import UIKit

extension UILabel {
    
    public func textWidth() -> CGFloat {
        return floor((self.text as! NSString).boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude), options: [.truncatesLastVisibleLine , .usesLineFragmentOrigin , .usesFontLeading], attributes: [.font: self.font], context: nil).width) + kQuarterMargin
    }
    
    public func textHeight() -> CGFloat {
        return floor((self.text as! NSString).boundingRect(with: CGSize(width: self.preferredMaxLayoutWidth, height: CGFloat.greatestFiniteMagnitude), options: [.truncatesLastVisibleLine , .usesLineFragmentOrigin , .usesFontLeading], attributes: [.font: self.font], context: nil).height) + kQuarterMargin
    }
    
    public func attributedTextWidth() -> CGFloat {
        let alternativeParagraphStyle = self.attributedText!.attributes(at: 0, effectiveRange: nil)

        if alternativeParagraphStyle != nil {
            return floor((self.attributedText?.string as! NSString).boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude), options: [.truncatesLastVisibleLine , .usesLineFragmentOrigin , .usesFontLeading], attributes: alternativeParagraphStyle, context: nil).width) + kQuarterMargin
        }
        return 0.0
    }
    
    public func attributedTextHeight() -> CGFloat {
        
        let alternativeParagraphStyle = self.attributedText!.attributes(at: 0, effectiveRange: nil)

        if alternativeParagraphStyle != nil {
            return floor((self.attributedText?.string as! NSString).boundingRect(with: CGSize(width: self.preferredMaxLayoutWidth, height: CGFloat.greatestFiniteMagnitude), options: [.truncatesLastVisibleLine , .usesLineFragmentOrigin , .usesFontLeading], attributes: alternativeParagraphStyle, context: nil).height) + kQuarterMargin
        }
        return 0.0
    }
    
}
