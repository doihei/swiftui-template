//
//  SampleSelectElement.swift
//  iOSTemplate
//
//  Created by doi on 2021/07/26.
//  Copyright © 2021 andfactory. All rights reserved.
//

import Foundation

enum SampleSelectElement: Int, SelectElement, CaseIterable {
    case element1
    case element2
    case element3
    
    var value: Any {
        return rawValue
    }
    
    var key: String {
        switch self {
        case .element1:
            return "エレメント1"
        case .element2:
            return "エレメント2"
        case .element3:
            return "エレメント3"
        }
    }
}
