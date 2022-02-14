//
//  SampleGithubFollowingUseCase.swift
//  TemplateDomains
//
//  Created by ykkd on 2021/10/11.
//

import Combine
import TemplateRepositories

public enum SampleGithubFollowingUseCaseProvider {
    
    public static func provide() -> SampleGithubFollowingUseCase {
        return SampleGithubFollowingUseCaseImpl(repository: SampleGithubRepositoryProvider.provide())
    }
}

public protocol SampleGithubFollowingUseCase {
    func getFollowings(of user: String) -> AnyPublisher<[Item], TemplateErrorType>
}

private final class SampleGithubFollowingUseCaseImpl: SampleGithubFollowingUseCase {
    
    private let repository: SampleGithubRepository
    
    public init(repository: SampleGithubRepository) {
        self.repository = repository
    }
    
    func getFollowings(of user: String) -> AnyPublisher<[Item], TemplateErrorType> {
        // TODO: fix
//        repository.getFollowings(of: user)
//            .map(SampleGithubFollowingTranslator.transrate)
//            .mapError(ErrorTranslator.transrate)
//            .eraseToAnyPublisher()
        return Future<[Item], TemplateErrorType> { promise in
            promise(
                .success(
                    [
                        Item(id: 0, login: "dhh", avatarUrl: "https://avatars.githubusercontent.com/u/2741", htmlUrl: "https://github.com/dhh"),
                        Item(id: 0, login: "dhh", avatarUrl: "https://avatars.githubusercontent.com/u/2741", htmlUrl: "https://github.com/dhh"),
                        Item(id: 0, login: "dhh", avatarUrl: "https://avatars.githubusercontent.com/u/2741", htmlUrl: "https://github.com/dhh"),
                        Item(id: 0, login: "dhh", avatarUrl: "https://avatars.githubusercontent.com/u/2741", htmlUrl: "https://github.com/dhh")
                    ]
                )
            )
        }.eraseToAnyPublisher()
    }
}
