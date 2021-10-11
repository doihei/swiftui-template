//
//  SampleGithubFollowingViewModel.swift
//  Template
//
//  Created by ykkd on 2021/10/11.
//

import Combine
import TemplateDomains

protocol SampleGithubFollowingViewModelType: ViewModelType where Input == SampleGithubFollowingViewModel.Input,          Output == SampleGithubFollowingViewModel.Output {}

final class SampleGithubFollowingViewModel: ObservableObject, SampleGithubFollowingViewModelType {
    
    class Input {
    }
    
    class Output {
        @Published var login: String = ""
        @Published var items: [Item] = []
        @Published var networkState: NetworkState = .normal
    }
    
    class State {
        @Published var login: String = ""
        @Published var items: [Item] = []
        @Published var networkState: NetworkState = .normal
    }
    
    struct Extra {
        let useCase: SampleGithubFollowingUseCase
        let login: String
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

extension SampleGithubFollowingViewModel {
    
    func bind() {
        guard let extra = extra else { return }
        
        extra.useCase.getFollowings(of: extra.login)
            .throttle(for: 1.0, scheduler: DispatchQueue.main, latest: true)
            .sink(
                receiveCompletion: { [weak self] completion in
                    switch completion {
                    case .failure(let error):
                        self?.state.networkState = .error(error)
                    break
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
            .sink { [weak self] items in
                self?.output.items = items
                self?.objectWillChange.send()
            }
            .store(in: &cancellables)
        
        state.$networkState
            .sink(receiveValue: { [weak self] in self?.output.networkState = $0 })
            .store(in: &cancellables)
        
        state.$login
            .filter { !$0.isEmpty }
            .sink { [weak self] login in
                self?.output.login = login
                self?.objectWillChange.send()
            }
            .store(in: &cancellables)
        
        state.login = extra.login
    }
}

#if DEBUG
extension SampleGithubFollowingViewModel {
    static var mock: SampleGithubFollowingViewModel {
        SampleGithubFollowingViewModel()
    }
}
#endif
