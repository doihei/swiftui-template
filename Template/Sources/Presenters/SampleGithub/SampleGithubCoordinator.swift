//
//  SampleGithubCoordinator.swift
//  iOSTemplate
//
//  Created by doi on 2021/07/26.
//  Copyright © 2021 andfactory. All rights reserved.
//

import Combine
import SwiftUI
import TemplateDomains
import UIKit

final class SampleGithubCoordinator: Coordinator {
    private let navigator: UINavigationController

    init(navigator: UINavigationController) {
        self.navigator = navigator
    }

    func start() {
        let useCase = SampleGithubUseCaseProvider.provide()
        let viewModel = SampleGithubViewModel(extra: .init(useCase: useCase))
        let presenter = SampleGithubPresenter(navigator: navigator)
        let dismissObject = DismissableDelegateObject<SampleGithubView<SampleGithubViewModel>>()
        let sampleView = SampleGithubView(viewModel: viewModel, presenter: presenter, dismissObject: dismissObject)
        let hostingController = UIHostingController(rootView: sampleView)
        dismissObject.hostingController = hostingController
        navigator.pushViewController(hostingController, animated: true)
    }
}
