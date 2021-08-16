//
//  SampleInputPresenter.swift
//  Template
//
//  Created by doi on 2021/07/26.
//

import Combine
import UIKit

final class SampleInputPresenter {
    class Input {
        let didTapMultiSelectCell = PassthroughSubject<(selectElements: SelectElements,
                                                        selectedElements: SelectElements,
                                                        input: Inputable), Never>()
    }

    var input: Input
    weak var navigator: UINavigationController?

    private let selectOutput: SelectOutput
    private var cancellables = Set<AnyCancellable>()

    init(selectOutput: SelectOutput) {
        self.input = Input()
        self.selectOutput = selectOutput
        bind()
    }

    func bind() {
        input.didTapMultiSelectCell
            .sink { [weak self] in
                guard let self = self, let navigator = self.navigator else { return }
                let selectCoordinator = SelectCoordinator(
                    navigator: navigator,
                    output: self.selectOutput,
                    selectElements: $0.selectElements,
                    selectedElements: $0.selectedElements,
                    input: $0.input
                )
                selectCoordinator.start()
            }
            .store(in: &cancellables)
    }
}
