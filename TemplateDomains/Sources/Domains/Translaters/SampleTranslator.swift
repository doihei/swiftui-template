//
//  SampleTranslator.swift
//  iOSTemplate
//
//  Created by doi on 2021/07/26.
//  Copyright © 2021 andfactory. All rights reserved.
//

import TemplateRepositories

final class SampleTranslator {
    static func transrate(entity: SampleEntity) -> Sample {
        let nest = Sample.Nest(value: entity.nestValue.value)
        return Sample(intValue: entity.intValue,
                      optionalInt: entity.optionalInt,
                      nestValue: nest)
    }
}
