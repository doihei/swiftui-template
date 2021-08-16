//
//  SelectOutput.swift
//  Template
//
//  Created by doi on 2021/07/26.
//  Copyright © 2021 andfactory. All rights reserved.
//

import Combine

final class SelectOutput {
    let didSelect = PassthroughSubject<(selectedElements: SelectElements, row: Inputable), Never>()
}
