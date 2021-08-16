//
//  SampleGithubPresenter.swift
//  Template
//
//  Created by doi on 2021/07/26.
//

import Combine
import UIKit

final class SampleGithubPresenter {
    class Input {
        let didTapUser = PassthroughSubject<String, Never>()
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
        input.didTapUser
            .sink { [weak self] urlString in
                guard let self = self, let url = URL(string: urlString) else { return }
                let coordinator = SampleGithubWebViewCoordinator(navigator: self.navigator, url: url)
                coordinator.start()
            }
            .store(in: &cancellables)
    }
}
