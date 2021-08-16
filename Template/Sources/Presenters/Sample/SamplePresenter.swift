//
//  SamplePresenter.swift
//  Template
//
//  Created by doi on 2021/07/26.
//

import Combine
import UIKit

final class SamplePresenter {
    class Input {
        let didTapInputButton = PassthroughSubject<Void, Never>()
    }

    var input: Input

    private let navigator: UINavigationController
    private var cancellables = Set<AnyCancellable>()

    init(navigator: UINavigationController) {
        self.input = Input()
        self.navigator = navigator
        bind()
    }

    func bind() {
        input.didTapInputButton
            .sink { [weak self] in
                guard let self = self else { return }
                let sampleInputCoordinator = SampleInputCoordinator(root: self.navigator)
                sampleInputCoordinator.start()
            }
            .store(in: &cancellables)
    }
}
