//
//  SampleGithubWebViewView.swift
//  Template
//
//  Created by 土井大平 on 2021/08/10.
//

import Combine
import SwiftUI

struct SampleGithubWebViewView<ViewModel: SampleGithubWebViewViewModelType>: View {
    @ObservedObject var viewModel: ViewModel

    let dismissObject: DismissableDelegateObject<Self>

    var body: some View {
        if let url = viewModel.output.url {
            WebView(url: url)
        }
    }
}

#if DEBUG
struct SampleGithubWebViewView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SampleGithubView(viewModel: SampleGithubViewModel.mock, presenter: .init(navigator: .init()), dismissObject: DismissableDelegateObject())
        }
    }
}
#endif

