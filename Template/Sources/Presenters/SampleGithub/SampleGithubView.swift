//
//  SampleGithubView.swift
//  Template
//
//  Created by doi on 2021/07/26.
//

import Combine
import SwiftUI

struct SampleGithubView<ViewModel: SampleGithubViewModelType>: View {
    @ObservedObject var viewModel: ViewModel
    
    let presenter: SampleGithubPresenter
    let dismissObject: DismissableDelegateObject<Self>

    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $viewModel.input.searchText, placeholder: R.string.sampleGithub.searchPlaceholder())
                List(viewModel.output.items) { item in
                    SampleGithubListView(
                        url: URL(string: item.avatarUrl)!,
                        login: item.login,
                        detailAction: {
                            presenter.input.didTapUser.send(item.htmlUrl)
                        },
                        followingAction: {
                            // TODO: implement
                        }
                    )
                }
            }
            .navigationTitle(R.string.sampleGithub.navitionTitle())
        }
        .onAppear {
            UIScrollView.appearance().keyboardDismissMode = .onDrag
        }
        .onReceive(viewModel.output.$networkState.receive(on: DispatchQueue.main)) {
            dismissObject.updateNetworkState($0)
        }
    }
}

#if DEBUG
struct SampleGithubView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SampleGithubView(viewModel: SampleGithubViewModel.mock, presenter: .init(navigator: .init()), dismissObject: DismissableDelegateObject())
        }
    }
}
#endif
