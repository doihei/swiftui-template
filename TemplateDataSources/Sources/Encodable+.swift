//
//  Encodable+.swift
//  TemplateDataSources
//
//  Created by doi on 2021/07/26.
//  Copyright © 2021 andfactory. All rights reserved.
//

import Foundation

extension Encodable {
    /// EncodableをDictionaryに変換
    ///
    /// - Returns: Dictionary
    func toDictionary() -> [String: Any] {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        let jsonObject = try? JSONSerialization.jsonObject(with: encoder.encode(self))
        let dict = jsonObject as? [String: Any] ?? [:]
        return dict
    }
}
