//
//  TSLExtensionAttributedString.swift
//  MyEngineeringCollection
//
//  Created by 佟顺利 on 2025/6/13.
//

import Foundation
import CoreText

extension NSAttributedString {
    // 根据指定的大小,对字符串进行分页,计算出每页显示的字符串区间(NSRange)
    public func pageRangeArrayWithConstrainedToSize(_ size: CGSize) -> [NSValue] {
        let attributedString = self
        var resultRange: [NSValue] = []
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        var rangeIndex = 0
        repeat {
            let length = attributedString.length - rangeIndex
            let childString = attributedString.attributedSubstring(from: Foundation.NSRange(location: rangeIndex, length: length))
            let childFramesetter = CTFramesetterCreateWithAttributedString(childString)
            let bezierPath = UIKit.UIBezierPath(rect: rect)
            let frame = CTFramesetterCreateFrame(childFramesetter, CoreFoundation.CFRange(location: 0, length: 0), bezierPath.cgPath, nil)
            let range = CTFrameGetVisibleStringRange(frame)
            let tmpRange = NSRange(location: rangeIndex, length: range.length)
            if tmpRange.length == 0 {
                rangeIndex += 1
            } else {
                resultRange.append(NSValue(range: tmpRange))
                rangeIndex += tmpRange.length
            }
        } while rangeIndex < attributedString.length && attributedString.length > 0
        return resultRange
    }
}
