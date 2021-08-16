//
//  SampleEntity.swift
//  TemplateDataSources
//
//  Created by doi on 2021/07/26.
//  Copyright © 2021 andfactory. All rights reserved.
//

import Foundation

public struct SampleEntity: Decodable {
    public let intValue: Int
    public let optionalInt: Int?
    public let nestValue: NestEntity
}
