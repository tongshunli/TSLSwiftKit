//
//  TSLUtilsHelper.swift
//  TSLSwiftKit
//
//  Created by TSL on 2022/10/27.
//  方法封装

import UIKit
import Foundation
import CommonCrypto

public enum TSLValidateType: Int {
    case email = 0
    case phoneNum = 1
    case carNum = 2
    case username = 3
    case password = 4
    case nickname = 5
    case URL = 6
    case iPAddress = 7
}

public class TSLUtilsHelper: NSObject {
    
    // MARK: 获取当前时间(秒)
    public class func timestamp() -> Int {
        let date = NSDate()
        let seconds = date.timeIntervalSince1970
        return Int(seconds * 1000)
    }
    
    // MARK: 时间辍
    public class func getTimeStamp() -> String {
        let date = NSDate.init(timeIntervalSinceNow: 0)
        let interval = date.timeIntervalSince1970
        return "\(Int(interval))"
    }
    
    public class func md5(_ strs: String) -> String {
        let utf8 = strs.cString(using: .utf8)
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5(utf8, CC_LONG(utf8!.count - 1), &digest)
        return digest.reduce("") { $0 + String(format: "%02X", $1) }
    }
    
    public class func changeIntMethod(_ targetStr: String?) -> Int {
        let tmpStr = NSString(string: targetStr ?? "0")
        return tmpStr.integerValue
    }
    
    // MARK: 字典转字符串
    public class func dictionaryToJsonString(_ dict: NSDictionary?) -> String {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dict as Any)
                        
            return String.init(data: jsonData, encoding: .utf8) ?? ""

        } catch {
            
        }
        
        return ""
    }
    
    // MARK: 字符串转字典
    public class func jsonStringToDictionary(_ jsonString: String?) -> NSDictionary {
        if jsonString != nil {
            let jsonData = jsonString!.data(using: .utf8)
            
            do {
                let dic = try JSONSerialization.jsonObject(with: jsonData!)
                
                return dic as? NSDictionary ?? NSDictionary()
            } catch {
                
            }
        }
        
        return [:]
    }
    
    // MARK: 格式验证
    public class func formatValidation(_ verify: String, validateType: TSLValidateType) -> Bool {
        
        var predicateStr: String?
        
        switch validateType {
        case .email:
            predicateStr = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
        case .phoneNum:
            predicateStr = "^((13[0-9])|(15[^4,\\D]) |(17[0,0-9])|(18[0,0-9]))\\d{8}$"
        case .carNum:
            predicateStr = "^[A-Za-z]{1}[A-Za-z_0-9]{5}$"
        case .username:
            predicateStr = "^[A-Za-z0-9]{6,20}+$"
        case .password:
            predicateStr = "^[a-zA-Z0-9]{6,20}+$"
        case .nickname:
            predicateStr = "^[\\u4e00-\\u9fa5]{4,8}$"
        case .URL:
            predicateStr = "^(https?:\\/\\/)?([\\da-z\\.-]+)\\.([a-z\\.]{2,6})([\\/\\w \\.-]*)*\\/?$"
        case .iPAddress:
            predicateStr = "^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$"
        }
        
        let predicate =  NSPredicate(format: "SELF MATCHES %@", predicateStr!)
        return predicate.evaluate(with: verify)
    }
    
    public class func getCachesAddress() -> String {
        return NSHomeDirectory().appending("/Library/Caches")
    }
    
}
