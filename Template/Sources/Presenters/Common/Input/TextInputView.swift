//
//  TextInputView.swift
//  Template
//
//  Created by doi on 2021/07/26.
//  Copyright © 2021 andfactory. All rights reserved.
//

import Combine
import SwiftUI

struct TextInputView: View {
    @Binding var inputText: String

    var title: String = R.string.localizable.textInputViewDefaultTitle()
    var placeholder: String = R.string.localizable.textInputViewDefaultPlaceholder()
    var isSecureTextEntry: Bool = false

    var body: some View {
        VStack(spacing: 2) {
            Text(title)
                .font(.caption)
                .foregroundColor(Color(R.color.gray()!))
                .frame(maxWidth: .infinity, alignment: .leading)
            isSecureTextEntry
                ? AnyView(
                    SecureField(placeholder, text: $inputText)
                        .font(.system(size: 15.5))
                )
                : AnyView(
                    TextField(placeholder, text: $inputText)
                        .font(.system(size: 15.5))
                )
        }
        .padding(EdgeInsets(top: 11, leading: 16, bottom: 11, trailing: 24))
        .background(Color.white)
    }
}

#if DEBUG
struct TextInputView_Previews: PreviewProvider {
    @State static var inputText: String = ""

    static var previews: some View {
        TextInputView(inputText: $inputText, isSecureTextEntry: false)
            .previewLayout(.fixed(width: 375, height: 68))
    }
}
#endif
