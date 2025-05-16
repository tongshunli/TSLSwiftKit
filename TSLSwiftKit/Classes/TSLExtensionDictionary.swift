//
//  TSLExtensionDictionary.swift
//  TSLSwiftKit
//
//  Created by 佟顺利 on 2025/5/15.
//

import Foundation

extension Dictionary {
    public func toJsonStr() -> String? {
        do {
            // 将字典转换为 JSON 数据
            let jsonData = try JSONSerialization.data(withJSONObject: self)
            // 将 JSON 数据转换为字符串
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                return jsonString
            }
        } catch {
        }
        return ""
    }
}
