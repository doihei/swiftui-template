//
//  GetSearchUsersRequest.swift
//  TemplateDataSources
//
//  Created by 土井大平 on 2021/08/04.
//

import Moya

/// - Seealso: https://docs.github.com/en/rest/reference/search#search-users
struct GetSearchUsersRequest: RequestTargetType, AccessTokenAuthorizable {
    typealias Response = GetSearchUsersResponse
    
    let q: String?
    
    var path: String {
        return "/search/users"
    }
    
    var method: Method {
        return .get
    }
    
    var task: Task {
        var parameters: [String: Any] = [:]
        if let q = q {
            parameters.appendingQueryParameter(key: "q", value: q)
        }
        return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
    }
    
    var authorizationType: AuthorizationType? {
        return .none
    }
}
