//
//  NetworkState.swift
//  iOSTemplate
//
//  Created by doi on 2021/07/26.
//  Copyright © 2021 andfactory. All rights reserved.
//

import Foundation

/// ViewModelの通信状態
enum NetworkState {
    case loading
    case normal
    case error(TemplateErrorType)
}
