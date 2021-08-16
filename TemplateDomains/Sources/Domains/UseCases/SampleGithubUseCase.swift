//
//  SampleGithubUseCase.swift
//  TemplateDomains
//
//  Created by 土井大平 on 2021/08/10.
//

import Combine
import TemplateRepositories

final public class SampleGithubUseCaseProvider {

    private init() {}
    
    public static func provide() -> SampleGithubUseCase {
        return SampleGithubUseCaseImpl(repository: SampleGithubRepositoryProvider.provide())
    }
}

public protocol SampleGithubUseCase {
    func getItems(q: String?) -> AnyPublisher<[Item], TemplateErrorType>
}

final class SampleGithubUseCaseImpl: SampleGithubUseCase {
    
    private let repository: SampleGithubRepository
    
    public init(repository: SampleGithubRepository) {
        self.repository = repository
    }
    
    func getItems(q: String?) -> AnyPublisher<[Item], TemplateErrorType> {
        repository.getUsers(q)
            .map(SampleGithubTranslator.transrate)
            .mapError(ErrorTranslator.transrate)
            .eraseToAnyPublisher()
    }
}

