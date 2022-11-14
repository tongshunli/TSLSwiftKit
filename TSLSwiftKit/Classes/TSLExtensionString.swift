//
//  TSLExtensionString.swift
//  TSLSwiftKit
//
//  Created by TSL on 2022/10/17.
//  NSRange与Range转换

import Foundation

extension String {
    
    public func toNSRange(from range: Range<String.Index>) -> NSRange {
       let from = range.lowerBound.samePosition(in: utf16)
       let to = range.upperBound.samePosition(in: utf16)
       
       return NSRange(location: utf16.distance(from: utf16.startIndex, to: from!), length: utf16.distance(from: from!, to: to!))
   }
   
   public func toRange(from nsRange: NSRange) -> Range<String.Index>? {
       guard
           let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location, limitedBy: utf16.endIndex),
           let to16 = utf16.index(from16, offsetBy: nsRange.length, limitedBy: utf16.endIndex),
           let from = String.Index(from16, within: self),
           let to = String.Index(to16, within: self)
       else { return nil }
       return from ..< to
   }
    
}
