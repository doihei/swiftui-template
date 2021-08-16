//
//  DateFormatter+.swift
//  Template
//
//  Created by doi on 2021/07/26.
//

import Foundation

extension DateFormatter {
    
    private struct CacheFormatter {
        static let `default` = DateFormatter()
    }
    
    static func makeAppDefault() -> DateFormatter {
        let formatter = CacheFormatter.default
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXXXX"
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.calendar = Calendar(identifier: .gregorian)
        return formatter
    }
    
    static func makeDatingFormatter() -> DateFormatter {
        let formatter = CacheFormatter.default
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.calendar = Calendar(identifier: .gregorian)
        return formatter
    }
}
