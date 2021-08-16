//
//  TemplateErrorType.swift
//  iOSTemplate
//
//  Created by doi on 2021/07/26.
//  Copyright © 2021 andfactory. All rights reserved.
//

import TemplateRepositories

public enum TemplateErrorType: Error {
    case apiError(APIError)
    case dataSourceError(DataSourceError)
    case unknownError(Error)
}
