//
//  SelectView.swift
//  Template
//
//  Created by doi on 2021/07/26.
//  Copyright © 2021 andfactory. All rights reserved.
//

import Combine
import SwiftUI

struct SelectView<ViewModel: SelectViewModelType>: View {
    @ObservedObject var viewModel: ViewModel

    let dismissObject: DismissableDelegateObject<Self>
    let output: SelectOutput

    var body: some View {
        List {
            Section(
                header: HeaderView(viewModel.output.headerTitle),
                footer: FooterView(viewModel.output.footerButtonTitle) {
                    viewModel.input.save.send()
                }
            ) {
                ForEach(viewModel.output.elements) { element in
                    Button(action: {
                        viewModel.input.toggleSelectElement.send(element.item)
                    }, label: {
                        SelectRowView(title: element.item.key, isSelected: element.isSelected)
                    })
                }
            }
        }
        .padding(EdgeInsets(top: 0, leading: -16, bottom: 0, trailing: -16)) // 区切り線の左右の余白をなくすため
        .listStyle(GroupedListStyle())
        .navigationTitle(viewModel.output.navigationTitle)
        .onReceive(viewModel.output.didSelect.receive(on: DispatchQueue.main)) {
            output.didSelect.send($0)
            dismissObject.popViewController()
        }
    }
}

#if DEBUG
struct SelectView_Previews: PreviewProvider {
    static var previews: some View {
        SelectView(viewModel: SelectViewModel.mock, dismissObject: DismissableDelegateObject(), output: .init())
    }
}
#endif
