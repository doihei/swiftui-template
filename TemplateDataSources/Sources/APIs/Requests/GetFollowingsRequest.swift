//
//  GetFollowingsRequest.swift
//  TemplateDataSources
//
//  Created by ykkd on 2021/10/11.
//

import Moya

/// - Seealso: https://docs.github.com/en/rest/reference/users#list-the-people-the-authenticated-user-follows
struct GetFollowingsRequest: RequestTargetType, AccessTokenAuthorizable {
    typealias Response = GetFollowingsResponse
    
    let user: String
    
    var path: String {
        return "/users/\(user)/following"
    }
    
    var method: Method {
        return .get
    }
    
    var task: Task {
        return .requestParameters(parameters: [:], encoding: URLEncoding.default)
    }
    
    var authorizationType: AuthorizationType? {
        return .basic
    }
}
