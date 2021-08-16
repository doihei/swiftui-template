//
//  SelectCoordinator.swift
//  iOSTemplate
//
//  Created by doi on 2021/07/26.
//  Copyright © 2021 andfactory. All rights reserved.
//

import Combine
import SwiftUI
import UIKit

final class SelectCoordinator: Coordinator {
    private let navigator: UINavigationController
    private let output: SelectOutput

    private let selectElements: SelectElements
    private let selectedElements: SelectElements
    private let input: Inputable

    init(navigator: UINavigationController,
         output: SelectOutput,
         selectElements: SelectElements,
         selectedElements: SelectElements,
         input: Inputable) {
        self.navigator = navigator
        self.output = output
        self.selectElements = selectElements
        self.selectedElements = selectedElements
        self.input = input
    }

    func start() {
        let viewModel = SelectViewModel(selectElements: selectElements,
                                        selectedElements: selectedElements,
                                        input: input)
        let dismissObject = DismissableDelegateObject<SelectView<SelectViewModel>>()
        let selectView = SelectView(viewModel: viewModel, dismissObject: dismissObject, output: output)
        let hostingController = UIHostingController(rootView: selectView)
        dismissObject.hostingController = hostingController
        navigator.pushViewController(hostingController, animated: true)
    }
}
