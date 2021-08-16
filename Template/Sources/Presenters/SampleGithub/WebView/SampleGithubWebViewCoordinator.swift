//
//  SampleGithubWebViewCoordinator.swift
//  Template
//
//  Created by 土井大平 on 2021/08/10.
//

import Combine
import SwiftUI
import TemplateDomains
import UIKit

final class SampleGithubWebViewCoordinator: Coordinator {
    private let navigator: UINavigationController
    private let url: URL

    init(navigator: UINavigationController, url: URL) {
        self.navigator = navigator
        self.url = url
    }

    func start() {
        let viewModel = SampleGithubWebViewViewModel(extra: .init(url: url))
        let dismissObject = DismissableDelegateObject<SampleGithubWebViewView<SampleGithubWebViewViewModel>>()
        let view = SampleGithubWebViewView(viewModel: viewModel, dismissObject: dismissObject)
        let hostingController = UIHostingController(rootView: view)
        dismissObject.hostingController = hostingController
        navigator.pushViewController(hostingController, animated: true)
    }
}
