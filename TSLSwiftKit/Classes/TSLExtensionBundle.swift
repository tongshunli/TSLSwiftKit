//
//  TSLExtensionBundle.swift
//  Alamofire
//
//  Created by TSL on 2022/11/23.
//  获取SDK内的图片

import UIKit

extension Bundle {
    
    class func getBundleImageWithName(_ name: String) -> UIImage? {
    
        let currentBundle = Bundle.main
        
        let bundlePath = currentBundle.path(forResource: "TSLSwiftKit", ofType: "bundle") ?? ""
        
        let resource_bundle = Bundle(path: bundlePath)
        
        if resource_bundle == nil {
            return nil
        }
        return UIImage(named: name, in: resource_bundle, compatibleWith: nil)!
    }
    
}
