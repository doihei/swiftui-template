//
//  SampleGithubFollowingViewCoordinator.swift
//  Template
//
//  Created by ykkd on 2021/10/11.
//

import Combine
import SwiftUI
import TemplateDomains
import UIKit

final class SampleGithubFollowingCoordinator: Coordinator {
    private let navigator: UINavigationController
    
    private let navigationDelegate: UINavigationController?
    
    private let login: String
    
    init(_ navigator: UINavigationController, login: String, navigationDelegate: UINavigationController?) {
        self.navigator = navigator
        self.login = login
        self.navigationDelegate = navigationDelegate
    }
    
    func start() {
        let useCase = SampleGithubFollowingUseCaseProvider.provide()
        let viewModel = SampleGithubFollowingViewModel(extra: .init(useCase: useCase, login: login))
        let presenter = SampleGithubFollowingPresenter(navigator: navigator)
        let dismissObject = DismissableDelegateObject<SampleGithubFollowingView<SampleGithubFollowingViewModel>>()
        let view = SampleGithubFollowingView(viewModel: viewModel, presenter: presenter, dismissObject: dismissObject)
        let hostingController = UIHostingController(rootView: view)
        dismissObject.hostingController = hostingController
        navigator.present(hostingController, animated: true, completion: nil)
    }
}
