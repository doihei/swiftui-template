//
//  SampleUseCase.swift
//  iOSTemplate
//
//  Created by doi on 2021/07/26.
//  Copyright © 2021 andfactory. All rights reserved.
//

import Combine
import TemplateRepositories

final public class SampleUseCaseProvider {

    private init() {}
    
    public static func provide() -> SampleUseCase {
        return SampleUseCaseImpl(sampleRepository: SampleRepositoryProvider.provide())
    }
}

public protocol SampleUseCase {
    func getSample() -> AnyPublisher<Sample, TemplateErrorType>
}

final class SampleUseCaseImpl: SampleUseCase {
    
    private let sampleRepository: SampleRepository
    
    public init(sampleRepository: SampleRepository) {
        self.sampleRepository = sampleRepository
    }
    
    func getSample() -> AnyPublisher<Sample, TemplateErrorType> {
        self.sampleRepository.getSample()
            .map(SampleTranslator.transrate)
            .mapError(ErrorTranslator.transrate)
            .eraseToAnyPublisher()
    }
}
