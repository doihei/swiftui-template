//
//  SampleGithubRepository.swift
//  TemplateRepositories
//
//  Created by 土井大平 on 2021/08/10.
//

import Combine
import TemplateDataSources

public final class SampleGithubRepositoryProvider {

    private init() {}
    
    static public func provide() -> SampleGithubRepository {
        return SampleGithubRepositoryImpl(api: SampleGithubAPIGatewayProvider.provide())
    }
}

public protocol SampleGithubRepository {
    func getUsers(_ q: String?) -> AnyPublisher<GetSearchUsersResponse, Error>
    func getFollowings(of user: String) -> AnyPublisher<GetFollowingsResponse, Error>
}

final class SampleGithubRepositoryImpl: SampleGithubRepository {
    
    private let api: SampleGithubAPIGateway

    public init(api: SampleGithubAPIGateway) {
        self.api = api
    }
    
    public func getUsers(_ q: String?) -> AnyPublisher<GetSearchUsersResponse, Error> {
        api.getUsers(q)
    }
    
    func getFollowings(of user: String) -> AnyPublisher<GetFollowingsResponse, Error> {
        api.getFollowings(of: user)
    }
}
