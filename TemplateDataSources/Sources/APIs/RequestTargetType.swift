//
//  RequestTargetType.swift
//  TemplateDataSources
//
//  Created by doi on 2021/07/26.
//

import Moya
import Device

public protocol RequestTargetType: TargetType {
    associatedtype Response: Decodable
}

extension RequestTargetType {
    
    var requestDomain: RequestDomain {
        return .sampleGithub
    }
    
    var baseURL: URL {
        return requestDomain.url
    }
    
    var headers: [String: String]? {
        return ["Content-type": "application/json", "Accept": "application/vnd.github.v3+json"]
    }
    
    // 単体テストのためのものなので、今は必要なし
    public var sampleData: Data {
        return Data()
    }
}

enum RequestDomain {
    case sampleGithub
    
    var url: URL {
        switch self {
        case .sampleGithub:
            return URL(string: "https://api.github.com")!
        }
    }
}
