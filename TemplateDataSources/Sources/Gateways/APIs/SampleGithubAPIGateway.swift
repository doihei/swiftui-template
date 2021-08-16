//
//  SampleGithubAPIGateway.swift
//  TemplateDataSources
//
//  Created by 土井大平 on 2021/08/10.
//

import Combine

final public class SampleGithubAPIGatewayProvider {
    
    private init() {}
    
    static public func provide() -> SampleGithubAPIGateway {
        return SampleGithubAPIGatewayImpl()
    }
}

public protocol SampleGithubAPIGateway {
    func getUsers(_ q: String?) -> AnyPublisher<GetSearchUsersResponse, Error>
}

final class SampleGithubAPIGatewayImpl: SampleGithubAPIGateway {
    private let manager: RequestManagerType

    public init(manager: RequestManagerType = RequestManager.shared) {
        self.manager = manager
    }

    public func getUsers(_ q: String?) -> AnyPublisher<GetSearchUsersResponse, Error> {
        return manager.requestPublisher(GetSearchUsersRequest(q: q))
    }
}

