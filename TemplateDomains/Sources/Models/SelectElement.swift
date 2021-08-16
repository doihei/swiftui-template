//
//  SelectElement.swift
//  iOSTemplate
//
//  Created by doi on 2021/07/26.
//  Copyright © 2021 andfactory. All rights reserved.
//

import Foundation

public typealias SelectElements = [SelectElement]

public protocol SelectElement {
    var key: String { get }
    var value: Any { get }
}
