//
//  ErrorTranslator.swift
//  TemplateDomains
//
//  Created by 土井大平 on 2021/08/04.
//

import TemplateRepositories

final class ErrorTranslator {
    static func transrate(error: Error) -> TemplateErrorType {
        switch error {
        case let errorResponse as ErrorResponse:
            let error = APIError(message: errorResponse.message,
                                 type: transrate(type: errorResponse.type),
                                 statusCode: errorResponse.statusCode)
            return .apiError(error)
        case let dataSourceError as DataSourceError:
            return .dataSourceError(dataSourceError)
        default:
            return .unknownError(error)
        }
    }
    
    static private func transrate(type: ErrorType?) -> APIError.ErrorType? {
        guard let type = type else { return nil }
        switch type {
        case .failVersionIncompatible:
            return .failVersionIncompatible
        }
    }
}
