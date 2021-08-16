//
//  SampleGithubWebViewViewModel.swift
//  Template
//
//  Created by 土井大平 on 2021/08/10.
//

import Combine
import TemplateDomains

protocol SampleGithubWebViewViewModelType: ViewModelType
    where Input == SampleGithubWebViewViewModel.Input,
          Output == SampleGithubWebViewViewModel.Output {}

final class SampleGithubWebViewViewModel: ObservableObject, SampleGithubWebViewViewModelType {

    class Input {
    }

    class Output {
        @Published var url: URL? = nil
    }

    class State {
        @Published var url: URL? = nil
    }

    struct Extra {
        let url: URL
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

extension SampleGithubWebViewViewModel {

    func bind() {
        guard let extra = extra else { return }

        state.$url
            .sink(receiveValue: { [weak self] in self?.output.url = $0 })
            .store(in: &cancellables)
        
        state.url = extra.url
    }
}

#if DEBUG
extension SampleGithubWebViewViewModel {
    static var mock: SampleGithubWebViewViewModel {
        SampleGithubWebViewViewModel()
    }
}
#endif

