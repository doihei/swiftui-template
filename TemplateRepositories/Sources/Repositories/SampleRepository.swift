//
//  SampleRepository.swift
//  iOSTemplate
//
//  Created by doi on 2021/07/26.
//  Copyright © 2021 andfactory. All rights reserved.
//

import Combine
import TemplateDataSources

public final class SampleRepositoryProvider {

    private init() {}
    
    static public func provide() -> SampleRepository {
        return SampleRepositoryImpl(api: SampleAPIGatewayProvider.provide())
    }
}

public protocol SampleRepository {
    func getSample() -> AnyPublisher<SampleEntity, Error>
}

final class SampleRepositoryImpl: SampleRepository {
    
    private let api: SampleAPIGateway

    public init(api: SampleAPIGateway) {
        self.api = api
    }
    
    public func getSample() -> AnyPublisher<SampleEntity, Error> {
        api.getSample()
    }
}
