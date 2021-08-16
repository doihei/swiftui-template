//
//  Dictionary+.swift
//  iOSTemplate
//
//  Created by doi on 2021/07/26.
//  Copyright © 2021 andfactory. All rights reserved.
//

import Foundation

extension Dictionary where Key == String, Value == Any {
    
    /// 値を安全に追加
    ///
    /// - Parameters:
    ///   - key: 追加するkey
    ///   - value: 追加するvalue
    mutating func appendingQueryParameter(key: String, value: Any?) {
        if let value = value {
            self[key] = value
        }
    }
    
    /// 値を安全に追加
    ///
    /// - Parameters:
    ///   - key: 追加するkey
    ///   - value: 追加するvalue
    mutating func appendingQueryParameter<T: RawRepresentable>(key: String, value: T?) where T.RawValue == String {
        if let value = value {
            self[key] = value.rawValue
        }
    }
}
