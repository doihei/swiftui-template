//
//  SampleInputCoordinator.swift
//  iOSTemplate
//
//  Created by doi on 2021/07/26.
//  Copyright © 2021 andfactory. All rights reserved.
//

import Combine
import SwiftUI
import TemplateDomains
import UIKit

final class SampleInputCoordinator: Coordinator {
    private let root: UIViewController

    init(root: UIViewController) {
        self.root = root
    }

    func start() {
        let viewModel = SampleInputViewModel()
        let selectOutput = SelectOutput()
        let presenter = SampleInputPresenter(selectOutput: selectOutput)
        let dismissObject = DismissableDelegateObject<SampleInputView<SampleInputViewModel>>()
        let sampleInputView = SampleInputView(viewModel: viewModel, presenter: presenter, selectOutput: selectOutput, dismissObject: dismissObject)
        let hostingController = UIHostingController(rootView: sampleInputView)
        dismissObject.hostingController = hostingController
        let navigator = UINavigationController(rootViewController: hostingController)
        navigator.modalPresentationStyle = .fullScreen
        navigator.navigationBar.isHidden = true
        root.present(navigator, animated: true)
        presenter.navigator = navigator
    }
}
