//
//  GetSampleRequest.swift
//  TemplateDataSources
//
//  Created by doi on 2021/07/26.
//

import Moya

/// Sample
/// - Seealso: 仕様書のリンク
struct GetSampleRequest: RequestTargetType, AccessTokenAuthorizable {
    typealias Response = SampleEntity
    
    var path: String {
        return "/sample"
    }
    
    var method: Method {
        return .get
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var authorizationType: AuthorizationType? {
        return .none
    }
}
