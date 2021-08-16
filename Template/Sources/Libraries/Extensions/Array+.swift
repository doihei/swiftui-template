//
//  Array+.swift
//  iOSTemplate
//
//  Created by doi on 2021/07/26.
//  Copyright © 2021 andfactory. All rights reserved.
//

import Foundation

extension Array {
    
    /// 安全に値を取得する
    /// 要素がnilでも正常に動く場合のみ利用する
    ///
    /// - Parameter index: Index
    /// - Returns: 要素(Optional)
    func safeGet(at index: Int) -> Element? {
        let isSafe = index >= 0 && index < count
        return isSafe ? self[index] : nil
    }
}
