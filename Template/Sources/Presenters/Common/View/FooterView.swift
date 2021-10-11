//
//  FooterView.swift
//  Template
//
//  Created by doi on 2021/07/26.
//  Copyright © 2021 andfactory. All rights reserved.
//

import SwiftUI

struct FooterView: View {
    let title: String
    let action: () -> Void

    @State var isEnabled: Bool = true

    init(_ title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            Text(title)
                .foregroundColor(.white)
                .font(.custom("Hiragino Sans W6", size: 15))
                .frame(maxWidth: .infinity)
                .frame(height: 46)
                .background(isEnabled ? Color(R.color.red()!) : .gray)
                .cornerRadius(23)
        }
        .disabled(!isEnabled)
        .padding(EdgeInsets(top: 16, leading: 58, bottom: 16, trailing: 58))
        .frame(maxWidth: .infinity, minHeight: 78, alignment: .top)
    }
}

#if DEBUG
struct FooterView_Previews: PreviewProvider {
    @State static var count: Int = 0

    static var previews: some View {
        FooterView("変更を保存 (\(count)") { count += 1 }
    }
}
#endif
