//
//  SampleGithubViewModel.swift
//  iOSTemplate
//
//  Created by doi on 2021/07/26.
//  Copyright © 2021 andfactory. All rights reserved.
//

import Combine
import TemplateDomains

protocol SampleGithubViewModelType: ViewModelType
    where Input == SampleGithubViewModel.Input,
          Output == SampleGithubViewModel.Output {}

final class SampleGithubViewModel: ObservableObject, SampleGithubViewModelType {

    class Input {
        @Published var searchText = ""
    }

    class Output {
        @Published var items: [Item] = []
        @Published var networkState: NetworkState = .normal
    }

    class State {
        @Published var items: [Item] = []
        @Published var networkState: NetworkState = .normal
        @Published var searchText = ""
    }

    struct Extra {
        let useCase: SampleGithubUseCase
    }

    var input: Input
    var output: Output
    var state: State
    var extra: Extra?

    private var cancellables = Set<AnyCancellable>()

    init(extra: Extra? = nil) {
        self.input = Input()
        self.output = Output()
        self.state = State()
        self.extra = extra
        bind()
    }
}

extension SampleGithubViewModel {

    func bind() {
        guard let extra = extra else { return }
        
        input.$searchText
            .sink(receiveValue: { [weak self] in self?.state.searchText = $0 })
            .store(in: &cancellables)
        
        state.$searchText
            .filter { !$0.isEmpty }
            .throttle(for: 1.0, scheduler: DispatchQueue.main, latest: true)
            .flatMap {
                extra.useCase.getItems(q: $0)
            }
            .sink(
                receiveCompletion: { [weak self] completion in
                    switch completion {
                    case .failure(let error):
                        self?.state.networkState = .error(error)
                    case .finished:
                        break
                    }
                },
                receiveValue: { [weak self] items in
                    self?.state.items = items
                }
            )
            .store(in: &cancellables)
        
        state.$items
            .sink(receiveValue: { [weak self] in
                self?.output.items = $0
                self?.objectWillChange.send()
            })
            .store(in: &cancellables)

        state.$networkState
            .sink(receiveValue: { [weak self] in self?.output.networkState = $0 })
            .store(in: &cancellables)
    }
}

#if DEBUG
extension SampleGithubViewModel {
    static var mock: SampleGithubViewModel {
        SampleGithubViewModel()
    }
}
#endif
