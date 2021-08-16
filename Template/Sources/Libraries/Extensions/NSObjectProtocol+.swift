//
//  NSObjectProtocol+.swift
//  iOSTemplate
//
//  Created by doi on 2021/07/26.
//  Copyright © 2021 andfactory. All rights reserved.
//

import Foundation

extension NSObjectProtocol {
    /// クラス名
    static var className: String {
        return String(describing: self)
    }
}
