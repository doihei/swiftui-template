//
//  SampleGithubFollowingView.swift
//  Template
//
//  Created by ykkd on 2021/10/11.
//

import Combine
import SwiftUI

struct SampleGithubFollowingView<ViewModel: SampleGithubFollowingViewModel>: View {
    @ObservedObject var viewModel: ViewModel
    
    let presenter: SampleGithubFollowingPresenter
    let dismissObject: DismissableDelegateObject<Self>
    
    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.output.items) { item in
                    SampleGithubListView(
                        url: URL(string: item.avatarUrl)!,
                        login: item.login,
                        detailAction: {
                            dismissObject.dismiss {
                                presenter.input.didTapUserDetail.send(item.htmlUrl)
                            }
                        },
                        followingAction: nil
                    )
                }
            }
                .navigationTitle(R.string.sampleGithubFollowing.navigationTitle(viewModel.output.login))
        }
        .onReceive(viewModel.output.$networkState.receive(on: DispatchQueue.main)) {
            dismissObject.updateNetworkState($0)
        }
    }
}

#if DEBUG
struct SampleGithubFollowingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SampleGithubFollowingView(viewModel: SampleGithubFollowingViewModel.mock, presenter: .init(navigator: .init()), dismissObject: DismissableDelegateObject())
        }
    }
}
#endif
