//
//  SelectRowView.swift
//  Template
//
//  Created by doi on 2021/07/26.
//  Copyright © 2021 andfactory. All rights reserved.
//

import Combine
import SwiftUI

struct SelectRowView: View {
    let title: String
    let isSelected: Bool

    var body: some View {
        HStack(spacing: 8) {
            Text(title)
                .font(.system(size: 15))
                .foregroundColor(Color(R.color.gray()!))
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 24)
            Image(uiImage: isSelected ? R.image.iconChecked()! : R.image.iconCheck()!)
                .frame(width: 24, height: 24, alignment: .center)
        }
        .padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
    }
}

#if DEBUG
struct SelectRowView_Previews: PreviewProvider {
    static var previews: some View {
        SelectRowView(title: "", isSelected: false)
    }
}
#endif
