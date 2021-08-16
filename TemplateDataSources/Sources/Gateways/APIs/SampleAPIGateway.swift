//
//  SampleAPIGateway.swift
//  iOSTemplate
//
//  Created by doi on 2021/07/26.
//  Copyright © 2021 andfactory. All rights reserved.
//

import Combine

final public class SampleAPIGatewayProvider {
    
    private init() {}
    
    static public func provide() -> SampleAPIGateway {
        return SampleAPIGatewayImpl()
    }
}

public protocol SampleAPIGateway {
    func getSample() -> AnyPublisher<SampleEntity, Error>
}

final class SampleAPIGatewayImpl: SampleAPIGateway {
    
    private let manager: RequestManagerType

    public init(manager: RequestManagerType = RequestManager.shared) {
        self.manager = manager
    }

    /// サンプル取得
    public func getSample() -> AnyPublisher<SampleEntity, Error> {
        return manager.requestPublisher(GetSampleRequest())
    }
}
