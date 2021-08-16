//
//  SampleCoordinator.swift
//  iOSTemplate
//
//  Created by doi on 2021/07/26.
//  Copyright © 2021 andfactory. All rights reserved.
//

import Combine
import SwiftUI
import TemplateDomains
import UIKit

final class SampleCoordinator: Coordinator {
    private let navigator: UINavigationController

    init(navigator: UINavigationController) {
        self.navigator = navigator
    }

    func start() {
        let useCase = SampleUseCaseProvider.provide()
        let viewModel = SampleViewModel(extra: .init(useCase: useCase))
        let presenter = SamplePresenter(navigator: navigator)
        let dismissObject = DismissableDelegateObject<SampleView<SampleViewModel>>()
        let sampleView = SampleView(viewModel: viewModel, presenter: presenter, dismissObject: dismissObject)
        let hostingController = UIHostingController(rootView: sampleView)
        dismissObject.hostingController = hostingController
        navigator.pushViewController(hostingController, animated: true)
    }
}
