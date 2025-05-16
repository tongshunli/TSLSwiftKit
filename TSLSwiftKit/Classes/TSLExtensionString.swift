//
//  TSLExtensionString.swift
//  TSLSwiftKit
//
//  Created by TSL on 2022/10/17.
//

import Foundation

extension String {
    
    public func toNSRange(from range: Range<String.Index>?) -> NSRange {
        if range == nil {
            return NSRange.init(location: 0, length: 0)
        }
        let from = range?.lowerBound.samePosition(in: utf16)
        let toRange = range?.upperBound.samePosition(in: utf16)
       
        return NSRange(location: utf16.distance(from: utf16.startIndex, to: from!), length: utf16.distance(from: from!, to: toRange!))
    }
   
    public func toRange(from nsRange: NSRange) -> Range<String.Index>? {
        guard
            let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location, limitedBy: utf16.endIndex),
            let to16 = utf16.index(from16, offsetBy: nsRange.length, limitedBy: utf16.endIndex),
            let from = String.Index(from16, within: self),
            let toEnd = String.Index(to16, within: self)
        else { return nil }
        return from ..< toEnd
    }
   
    // MARK: 删除字符串中的空格
    public func removeSpaces() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    }
    
    // MARK: 拼接URL
    public func splicingURL(_ dict: [String: Any]) -> String {
        var tmpStr = self.chineseUrl()
        
        if dict.count > 0 {
            tmpStr += "?"
            
            for key in dict.keys {
                tmpStr = "\(tmpStr)&\(key)=\(dict[key] ?? "")"
            }
            
            return tmpStr.replacingOccurrences(of: "?&", with: "?")
        }
        return self
    }
    
    // MARK: 链接拼接
    public func urlWithString(_ urlStr: String) -> String {
        if self.contains("?") {
            if self.hasSuffix("?") {
                return self + urlStr
            } else {
                if self.hasSuffix("&") {
                    return self + urlStr
                } else {
                    return self + "&\(urlStr)"
                }
            }
        }
        return self + "?\(urlStr)"
    }
    
    // MARK: 处理中文链接
    public func chineseUrl() -> String {
        
        if containChinese() {
            return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? self
        }
        return self
    }
    
    // MARK: 包含中文信息
    public func containChinese() -> Bool {
        return self.range(of: "\\p{Han}", options: .regularExpression) != nil
    }
    
    // MARK: 返回一个处理好的URL
    public func getUrl() -> URL? {
        return URL(string: self.chineseUrl())
    }
    
    // MARK: 字符串转字典
    public func toDictionary() -> [String: Any] {
        guard let jsonData = self.data(using: .utf8) else { return [:] }
        
        guard let dictionary = try? JSONSerialization.jsonObject(with: jsonData) as? [String: Any] else { return [:] }
        return dictionary
    }
}
