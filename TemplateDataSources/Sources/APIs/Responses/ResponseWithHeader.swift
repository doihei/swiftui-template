//
//  ResponseWithHeader.swift
//  iOSTemplate
//
//  Created by doi on 2021/07/26.
//  Copyright © 2021 andfactory. All rights reserved.
//

import Foundation

/// Headerと一緒に Responseを返す用
public struct ResponseWithHeader<T> {
    public let header: [AnyHashable: Any]
    public let body: T
}
