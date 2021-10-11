//
//  SampleGithubFollowingViewPresenter.swift
//  Template
//
//  Created by ykkd on 2021/10/11.
//

import Combine
import UIKit

final class SampleGithubFollowingPresenter {
    
    class Input {
        let didTapUserDetail = PassthroughSubject<String, Never>()
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
        input.didTapUserDetail
            .sink { [weak self] urlString in
                guard let self = self, let url = URL(string: urlString) else { return }
                let coordinator = SampleGithubWebViewCoordinator(navigator: self.navigator, url: url)
                coordinator.start()
            }
            .store(in: &cancellables)
    }
}

