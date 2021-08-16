//
//  String+.swift
//  iOSTemplate
//
//  Created by doi on 2021/07/26.
//  Copyright © 2021 andfactory. All rights reserved.
//

import Foundation

extension String {
    /// 正規表現判定
    ///
    /// - Parameters:
    ///   - regex: 正規表現パターン
    ///   - matchingOptions: マッチングオプション
    ///   - range: 正規表現範囲
    /// - Returns: 正規表現の判定
    func firstMatch(regex: NSRegularExpression,
                    matchingOptions: NSRegularExpression.MatchingOptions = NSRegularExpression.MatchingOptions(),
                    range: NSRange? = nil) -> Bool {
        let unwrappedRange: NSRange
        if let range = range {
            unwrappedRange = range
        } else {
            unwrappedRange = NSRange(location: 0, length: self.count)
        }
        return regex.firstMatch(in: self, options: matchingOptions, range: unwrappedRange) != nil
    }
}
