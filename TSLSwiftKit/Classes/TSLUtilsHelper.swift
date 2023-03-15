//
//  TSLUtilsHelper.swift
//  TSLSwiftKit
//
//  Created by TSL on 2022/10/27.
//  方法封装

import UIKit
import Foundation
import CommonCrypto

public class TSLUtilsHelper: NSObject {
    
    public class func getTimeStamp() -> String {
        let date = NSDate.init(timeIntervalSinceNow: 0)
        let interval = date.timeIntervalSince1970
        return "\(Int(interval))"
    }
    
    public class func md5(_ strs: String) -> String {
        let utf8 = strs.cString(using: .utf8)
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5(utf8, CC_LONG(utf8!.count - 1), &digest)
        return digest.reduce("") { $0 + String(format:"%02X", $1) }
    }
    
    public class func changeIntMethod(_ targetStr: String?) -> Int {
        let tmpStr = NSString(string: targetStr ?? "0")
        return tmpStr.integerValue
    }
    
    //  判断字符串是否为空
    public class func stringIsReBlank(_ str: String?) -> Bool {
        let chare = str?.trimmingCharacters(in: .whitespacesAndNewlines)
        return chare?.isEmpty ?? true
    }
    
    //  字典转字符串
    public class func dictionaryToJsonString(_ dict: NSDictionary?) -> String {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dict)
            
            if jsonData != nil {
                return String.init(data: jsonData, encoding: .utf8) ?? ""
            }
        } catch {
            
        }
        
        return ""
    }
    
    //  字符串转字典
    public class func jsonStringToDictionary(_ jsonString: String?) -> NSDictionary {
        if jsonString != nil {
            let jsonData = jsonString!.data(using: .utf8)
            
            do {
                let dic = try JSONSerialization.jsonObject(with: jsonData!)
                
                return dic as! NSDictionary
            } catch {
                
            }
        }
        
        return [:]
    }
    
}
