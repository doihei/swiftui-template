//
//  SampleInputView.swift
//  Template
//
//  Created by doi on 2021/07/26.
//

import Combine
import SwiftUI

struct SampleInputView<ViewModel: SampleInputViewModelType>: View {
    @ObservedObject var viewModel: ViewModel

    let presenter: SampleInputPresenter
    let selectOutput: SelectOutput
    let dismissObject: DismissableDelegateObject<Self>

    var body: some View {
        List {
            Section(
                header: HeaderView("Label Header"),
                footer: HStack {
                    Spacer()
                    Text("footer")
                    Spacer()
                }
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0))
            ) {
                TextInputView(inputText: $viewModel.input.input1, title: SampleInputViewModel.Row.input1.title)
                PickerInputView(inputText: $viewModel.input.input2, contents: $viewModel.output.master2, title: SampleInputViewModel.Row.input2.title)
                DateInputView(inputDate: viewModel.input.$input4, title: SampleInputViewModel.Row.input4.title, format: "yyyy/MM/dd", datePickerMode: .date)
                Button(action: {
                    let selectedElements = viewModel.output.input5
                        .compactMap { key -> SelectElement? in
                            viewModel.output.master5
                                .filter { $0.key == key }
                                .first
                        }
                    presenter.input.didTapMultiSelectCell.send(
                        (
                            selectElements: viewModel.output.master5,
                            selectedElements: selectedElements,
                            input: SampleInputViewModel.Row.input5
                        )
                    )
                }, label: {
                    MultiSelectInputView(text: viewModel.output.$displayInput5, title: SampleInputViewModel.Row.input5.title)
                })
                PickerInputView(inputText: $viewModel.input.input6, contents: $viewModel.output.master6, title: SampleInputViewModel.Row.input6.title)
            }
        }
        .padding(EdgeInsets(top: 0, leading: -16, bottom: 0, trailing: 0)) // 区切り線の左側の余白をなくすため
        .navigation(
            "",
            leftItem: {
                Button(action: {
                    dismissObject.dismiss()
                }) {
                    Text(R.string.localizable.commonNavigationCloseTitle())
                }
            },
            rightItem: {}
        )
        .listStyle(GroupedListStyle())
        .onReceive(selectOutput.didSelect.receive(on: DispatchQueue.main)) { selectedElements, row in
            guard let row =  row as? SampleInputViewModel.Row else { return }
            switch row {
            case .input5:
                viewModel.input.input5 = selectedElements.map { $0.key }
            case .input1, .input2, .input3, .input4, .input6:
                break
            }
        }
    }
}

#if DEBUG
struct SampleInputView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SampleInputView(viewModel: SampleInputViewModel.mock, presenter: .init(selectOutput: .init()), selectOutput: .init(), dismissObject: .init())
        }
    }
}
#endif
