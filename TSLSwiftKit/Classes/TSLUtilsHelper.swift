//
//  TSLUtilsHelper.swift
//  TSLSwiftKit
//
//  Created by TSL on 2022/10/27.
//
import UIKit
import Foundation
import CommonCrypto

public class TSLUtilsHelper: NSObject {
    
    public class func getTimeStamp() -> String {
        let date = NSDate.init(timeIntervalSinceNow: 0)
        let interval = date.timeIntervalSince1970
        return "%.\(interval)f"
    }
    
    public class func md5(_ strs: String) -> String {
        let utf8 = strs.cString(using: .utf8)
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5(utf8, CC_LONG(utf8!.count - 1), &digest)
        return digest.reduce("") { $0 + String(format:"%02X", $1) }
    }
    
}
