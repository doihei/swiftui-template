//
//  DataSourceError.swift
//  TemplateDataSources
//
//  Created by doi on 2021/07/26.
//  Copyright © 2021 andfactory. All rights reserved.
//

import Foundation

public enum DataSourceError: Error {
    case failGetSession
    case invalidErrorMessage
    case requestTimeout
}
