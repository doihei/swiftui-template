//
//  HeaderView.swift
//  Template
//
//  Created by doi on 2021/07/26.
//  Copyright © 2021 andfactory. All rights reserved.
//

import SwiftUI

struct HeaderView: View {
    var text: String

    init(_ text: String) {
        self.text = text
    }

    var body: some View {
        Text(text)
            .font(.custom("Avenir-Book", size: 13))
            .padding(EdgeInsets(top: 22, leading: 16, bottom: 8, trailing: 16))
            .frame(maxWidth: .infinity, minHeight: 48, alignment: .bottomLeading)
    }
}

#if DEBUG
struct HeaderView_Previews: PreviewProvider {
    private struct HeaderText: Identifiable {
        let id = UUID()
        var text: String
    }

    static let headerTexts: [String] = [1...5].map { "Text \($0)" }

    static var previews: some View {
        List(headerTexts.map { HeaderText(text: $0) }) {
            HeaderView($0.text)
        }
    }
}
#endif
