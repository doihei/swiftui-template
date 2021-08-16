//
//  SampleViewModel.swift
//  iOSTemplate
//
//  Created by doi on 2021/07/26.
//  Copyright © 2021 andfactory. All rights reserved.
//

import Combine
import TemplateDomains

protocol SampleViewModelType: ViewModelType
    where Input == SampleViewModel.Input,
          Output == SampleViewModel.Output {}

final class SampleViewModel: ObservableObject, SampleViewModelType {

    class Input {
        let getSample = PassthroughSubject<Void, Never>()
    }

    class Output {
        @Published var sample: Sample?
        @Published var networkState: NetworkState = .normal
    }

    class State {
        @Published var sample: Sample?
        @Published var networkState: NetworkState = .normal
    }

    struct Extra {
        let useCase: SampleUseCase
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

extension SampleViewModel {

    func bind() {
        guard let extra = extra else { return }

        input.getSample
            .flatMap {
                extra.useCase.getSample()
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
                receiveValue: { [weak self] sample in
                    self?.state.sample = sample
                }
            )
            .store(in: &cancellables)

        state.$sample
            .sink(receiveValue: { [weak self] in self?.output.sample = $0 })
            .store(in: &cancellables)

        state.$networkState
            .sink(receiveValue: { [weak self] in self?.output.networkState = $0 })
            .store(in: &cancellables)
    }
}

#if DEBUG
extension SampleViewModel {
    static var mock: SampleViewModel {
        SampleViewModel()
    }
}
#endif
