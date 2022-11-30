//
//  TSLExtensionLabel.swift
//  TSLSwiftKit
//
//  Created by TSL on 2022/11/4.
//  Label宽高计算

import UIKit

extension UILabel {
    
    public func textWidth() -> CGFloat {
        if self.text == nil {
            return 0
        }
        return floor(self.text!.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude), options: [.truncatesLastVisibleLine , .usesLineFragmentOrigin , .usesFontLeading], attributes: [.font: self.font], context: nil).width) + kQuarterMargin
    }
    
    public func textHeight() -> CGFloat {
        if self.text == nil {
            return 0
        }
        return floor(self.text!.boundingRect(with: CGSize(width: self.preferredMaxLayoutWidth, height: CGFloat.greatestFiniteMagnitude), options: [.truncatesLastVisibleLine , .usesLineFragmentOrigin , .usesFontLeading], attributes: [.font: self.font], context: nil).height) + kQuarterMargin
    }
    
    public func attributedTextWidth() -> CGFloat {
        if self.attributedText == nil {
            return 0
        }
        
        let alternativeParagraphStyle = self.attributedText!.attributes(at: 0, effectiveRange: nil)

        return floor((self.attributedText?.string.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude), options: [.truncatesLastVisibleLine , .usesLineFragmentOrigin , .usesFontLeading], attributes: alternativeParagraphStyle, context: nil).width)!) + kQuarterMargin
    }
    
    public func attributedTextHeight() -> CGFloat {
        if self.attributedText == nil {
            return 0
        }
        
        let alternativeParagraphStyle = self.attributedText!.attributes(at: 0, effectiveRange: nil)

        return floor((self.attributedText?.string.boundingRect(with: CGSize(width: self.preferredMaxLayoutWidth, height: CGFloat.greatestFiniteMagnitude), options: [.truncatesLastVisibleLine , .usesLineFragmentOrigin , .usesFontLeading], attributes: alternativeParagraphStyle, context: nil).height)!) + kQuarterMargin
    }
    
}
