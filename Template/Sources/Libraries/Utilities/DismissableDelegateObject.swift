//
//  DismissableDelegateObject.swift
//  Template
//
//  Created by doi on 2021/07/26.
//

import SwiftUI

/// SwiftUIからUIHostingControllerを閉じられるようにする
final class DismissableDelegateObject<Content> where Content: View {
    weak var hostingController: UIHostingController<Content>?

    func dismiss() {
        hostingController?.dismiss(animated: true)
    }

    func updateNetworkState(_ networkState: NetworkState) {
        hostingController?.updateNetworkState(networkState)
    }

    func popViewController() {
        hostingController?.navigationController?.popViewController(animated: true)
    }
}
