//
//  ErrorResponse.swift
//  TemplateDataSources
//
//  Created by doi on 2021/07/26.
//  Copyright © 2021 andfactory. All rights reserved.
//

import Foundation

public struct ErrorResponse: Error {
    public let message: String
    public let type: ErrorType?
    public let statusCode: Int
}
