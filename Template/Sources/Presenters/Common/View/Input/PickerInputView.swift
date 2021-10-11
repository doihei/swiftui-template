//
//  PickerInputView.swift
//  Template
//
//  Created by doi on 2021/07/26.
//  Copyright © 2021 andfactory. All rights reserved.
//

import Combine
import SwiftUI

struct PickerInputView: View {
    @Binding var inputText: String
    @Binding var contents: [[String]]

    var title: String = R.string.localizable.textInputViewDefaultTitle()
    var placeholder: String = R.string.localizable.textInputViewDefaultPickerFieldPlaceholder()

    var body: some View {
        VStack(spacing: 2) {
            Text(title)
                .font(.caption)
                .foregroundColor(Color(R.color.gray()!))
                .frame(maxWidth: .infinity, alignment: .leading)
            PickerField(
                inputText: $inputText,
                contents: $contents,
                placeholder: placeholder
            )
        }
        .padding(EdgeInsets(top: 11, leading: 16, bottom: 11, trailing: 24))
        .background(Color.white)
    }
}

#if DEBUG
struct PickerInputView_Previews: PreviewProvider {
    @State static var inputText: String = ""

    static let contentTexts: [[String]] = [[1...5].map { "Content \($0)" }, [1...5].map { "Content \($0)" }]

    static var previews: some View {
        PickerInputView(inputText: $inputText,
                        contents: .constant(contentTexts))
            .previewLayout(.fixed(width: 375, height: 68))
    }
}
#endif
