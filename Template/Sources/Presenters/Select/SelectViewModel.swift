//
//  SelectViewModel.swift
//  iOSTemplate
//
//  Created by doi on 2021/07/26.
//  Copyright © 2021 andfactory. All rights reserved.
//

import Combine

protocol SelectViewModelType: ViewModelType
    where Input == SelectViewModel.Input,
          Output == SelectViewModel.Output {}

final class SelectViewModel: ObservableObject, SelectViewModelType {
    var input: Input
    var output: Output
    var state: State

    private var cancellables = Set<AnyCancellable>()

    init(navigationTitle: String? = nil,
         headerTitle: String? = nil,
         footerButtonTitle: String? = nil,
         selectElements: SelectElements,
         selectedElements: SelectElements = [],
         input: Inputable) {
        self.input = Input()
        self.output = Output()
        self.state = State(
            navigationTitle: navigationTitle ?? R.string.selectView.navigationDefaultTitle(),
            headerTitle: headerTitle ?? R.string.selectView.headerDefaultTitle(),
            footerButtonTitle: footerButtonTitle ?? R.string.selectView.footerButtonDefaultTitle(),
            selectElements: selectElements,
            selectedElements: selectedElements,
            input: input
        )
        bind()
    }
}

extension SelectViewModel {
    class Input {
        let toggleSelectElement = PassthroughSubject<SelectElement, Never>()
        let save = PassthroughSubject<Void, Never>()
    }

    class Output {
        @Published var navigationTitle = ""
        @Published var headerTitle = ""
        @Published var footerButtonTitle = ""
        @Published var elements: [Element] = []
        let didSelect = PassthroughSubject<(selectedElements: SelectElements, row: Inputable), Never>()
    }

    class State {
        @Published var navigationTitle = ""
        @Published var headerTitle = ""
        @Published var footerButtonTitle = ""
        @Published var selectElements = SelectElements()
        @Published var selectedElements = SelectElements()
        @Published var input: Inputable

        init(navigationTitle: String,
             headerTitle: String,
             footerButtonTitle: String,
             selectElements: SelectElements,
             selectedElements: SelectElements,
             input: Inputable) {
            self.navigationTitle = navigationTitle
            self.headerTitle = headerTitle
            self.footerButtonTitle = footerButtonTitle
            self.selectElements = selectElements
            self.selectedElements = selectedElements
            self.input = input
        }
    }

    struct Element: Identifiable {
        let item: SelectElement
        let isSelected: Bool

        var id: String {
            item.key
        }
    }
}

extension SelectViewModel {
    func bind() {
        input.toggleSelectElement
            .sink(receiveValue: { [weak self] selectedRow in
                guard let self = self else { return }
                var selectedRows = self.state.selectedElements
                if selectedRows.contains(where: { $0.key == selectedRow.key }) {
                    selectedRows.removeAll(where: { $0.key == selectedRow.key })
                } else {
                    selectedRows.append(selectedRow)
                }
                self.state.selectedElements = selectedRows
            })
            .store(in: &cancellables)

        input.save
            .combineLatest(
                state.$input, state.$selectedElements
            )
            .map {
                (selectedElements: $0.2, row: $0.1)
            }
            .sink(receiveValue: { [weak self] in self?.output.didSelect.send($0) })
            .store(in: &cancellables)

        state.$navigationTitle
            .sink(receiveValue: { [weak self] in self?.output.navigationTitle = $0 })
            .store(in: &cancellables)

        state.$headerTitle
            .sink(receiveValue: { [weak self] in self?.output.headerTitle = $0 })
            .store(in: &cancellables)

        state.$footerButtonTitle
            .sink(receiveValue: { [weak self] in self?.output.footerButtonTitle = $0 })
            .store(in: &cancellables)

        Publishers.CombineLatest(state.$selectElements, state.$selectedElements)
            .map { selectElements, selectedElements in
                selectElements.map { selectElement in
                    Element(item: selectElement, isSelected: selectedElements.contains(where: { $0.key == selectElement.key }))
                }
            }
            .sink(receiveValue: { [weak self] in
                self?.output.elements = $0
                // ArrayをView側で監視できるようにするために通知する
                self?.objectWillChange.send()
            })
            .store(in: &cancellables)
    }
}

#if DEBUG
extension SelectViewModel {
    enum Row: Inputable {
        case test
    }

    static var mock: SelectViewModel {
        SelectViewModel(selectElements: .init(), input: Row.test)
    }
}
#endif
