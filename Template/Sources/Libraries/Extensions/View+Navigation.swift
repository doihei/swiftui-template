//
//  View+Navigation.swift
//  Template
//
//  Created by doi on 2021/07/26.
//  Copyright © 2021 andfactory. All rights reserved.
//

import SwiftUI

extension View {
    @inlinable public func navigation<LeftItem, RightItem>(
        _ title: String,
        @ViewBuilder leftItem: () -> LeftItem,
        @ViewBuilder rightItem: () -> RightItem
    ) -> NavigationView<AnyView> where LeftItem: View,
                                       RightItem: View {
        NavigationView {
            AnyView(
                self
                    .navigationTitle(title)
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading, content: leftItem)
                        ToolbarItem(placement: .navigationBarTrailing, content: rightItem)
                    }
            )
        }
    }

    @inlinable public func navigation<LeftItem>(
        _ title: String,
        @ViewBuilder leftItem: () -> LeftItem
    ) -> NavigationView<AnyView> where LeftItem: View {
        NavigationView {
            AnyView(
                self
                    .navigationTitle(title)
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading, content: leftItem)
                    }
            )
        }
    }
}

#if DEBUG
struct NavigationView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello, world!!")
            .navigation(
                "Navigation",
                leftItem: {
                    Button(action: {}) {
                        Text("Left")
                    }
                },
                rightItem: {
                    Button(action: {}) {
                        Text("Right")
                    }
                })
    }
}
#endif
