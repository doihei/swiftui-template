//
//  SampleInputViewModel.swift
//  iOSTemplate
//
//  Created by doi on 2021/07/26.
//  Copyright © 2021 andfactory. All rights reserved.
//

import Combine
import Foundation

protocol SampleInputViewModelType: ViewModelType
    where Input == SampleInputViewModel.Input,
          Output == SampleInputViewModel.Output {}

final class SampleInputViewModel: ObservableObject, SampleInputViewModelType {
    class Input {
        @Published var input1 = R.string.sampleInput.defaultInput1()
        @Published var input2 = SampleSelectElement.element2.key
        @Published var input3 = R.string.sampleInput.defaultInput3()
        @Published var input4: Date? = Date()
        @Published var input5 = [SampleSelectElement.element2.key, SampleSelectElement.element3.key]
        @Published var input6 = "\(SampleSelectElement.element2.key)\(Const.delimiter)\(SampleSelectElement.element3.key)"
    }

    class Output {
        @Published var master2: [[String]] = []

        @Published var input5: [String] = []
        @Published var displayInput5 = ""
        @Published var master5: [SampleSelectElement] = []

        @Published var master6: [[String]] = []
    }

    class State {
        @Published var input1 = ""
        @Published var input2 = ""
        @Published var input3 = ""
        @Published var input4: Date?
        @Published var input5: [String] = []
        @Published var input6 = ""
    }

    var input: Input
    var output: Output
    var state: State

    private var cancellables = Set<AnyCancellable>()

    init() {
        self.input = Input()
        self.output = Output()
        self.state = State()
        bind()
    }
}

extension SampleInputViewModel {
    enum Row: Inputable, CaseIterable {
        case input1
        case input2
        case input3
        case input4
        case input5
        case input6

        var title: String {
            switch self {
            case .input1:
                return R.string.sampleInput.input1Title()
            case .input2:
                return R.string.sampleInput.input2Title()
            case .input3:
                return R.string.sampleInput.input3Title()
            case .input4:
                return R.string.sampleInput.input4Title()
            case .input5:
                return R.string.sampleInput.input5Title()
            case .input6:
                return R.string.sampleInput.input6Title()
            }
        }
    }
}

extension SampleInputViewModel {
    private enum Const {
        static let delimiter: String = ","
    }

    func bind() {
        output.master2 = [SampleSelectElement.allCases.map { $0.key }]
        output.master5 = SampleSelectElement.allCases
        output.master6 = [SampleSelectElement.allCases.map { $0.key }, SampleSelectElement.allCases.map { $0.key }]

        input.$input1
            .sink(receiveValue: { [weak self] in self?.state.input1 = $0 })
            .store(in: &cancellables)

        input.$input2
            .sink(receiveValue: { [weak self] in self?.state.input2 = $0 })
            .store(in: &cancellables)

        input.$input3
            .sink(receiveValue: { [weak self] in self?.state.input3 = $0 })
            .store(in: &cancellables)

        input.$input4
            .sink(receiveValue: { [weak self] in self?.state.input4 = $0 })
            .store(in: &cancellables)

        input.$input5
            .sink(receiveValue: { [weak self] in self?.state.input5 = $0 })
            .store(in: &cancellables)

        input.$input6
            .sink(receiveValue: { [weak self] in self?.state.input6 = $0 })
            .store(in: &cancellables)

        state.$input5
            .map { $0.joined(separator: Const.delimiter) }
            .sink(receiveValue: { [weak self] in self?.output.displayInput5 = $0 })
            .store(in: &cancellables)

        state.$input5
            .sink(receiveValue: { [weak self] in self?.output.input5 = $0 })
            .store(in: &cancellables)
    }
}

#if DEBUG
extension SampleInputViewModel {
    static var mock: SampleInputViewModel {
        SampleInputViewModel()
    }
}
#endif
