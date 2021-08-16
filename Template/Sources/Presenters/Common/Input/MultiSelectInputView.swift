//
//  MultiSelectInputView.swift
//  Template
//
//  Created by doi on 2021/07/26.
//  Copyright © 2021 andfactory. All rights reserved.
//

import Combine
import SwiftUI

struct MultiSelectInputView: View {
    var text: Published<String>.Publisher
    var title = R.string.localizable.multiSelectInputViewDefaultTitle()
    var placeholder = R.string.localizable.multiSelectInputViewDefaultPlaceholder()
    var delimiter = ","

    @State private var displayText: String = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(title)
                .font(.caption)
                .foregroundColor(Color(R.color.gray()!))
                .frame(maxWidth: .infinity, alignment: .leading)
            if displayText.isEmpty {
                Text(placeholder)
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 15.5))
                    .foregroundColor(Color(R.color.placeholder()!))
            } else {
                Text(displayText)
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 15.5))
                    .foregroundColor(.black)
            }
        }
        .padding(EdgeInsets(top: 11, leading: 16, bottom: 11, trailing: 16))
        .onReceive(text) { text in
            displayText = text
        }
    }
}
