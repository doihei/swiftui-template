//
//  Sample.swift
//  iOSTemplate
//
//  Created by doi on 2021/07/26.
//  Copyright © 2021 andfactory. All rights reserved.
//

import Foundation

public struct Sample {
    public struct Nest {
        public let value: String
    }
    public let intValue: Int
    public let optionalInt: Int?
    public let nestValue: Nest
}
