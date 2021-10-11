//
//  View+.swift
//  Template
//
//  Created by ykkd on 2021/10/11.
//

import SwiftUI

extension View {
    
    func clipAndOverlay(
        cornerRadius: CGFloat,
        borderColor: Color,
        borderWidth: CGFloat
    ) -> some View {
        self.modifier(
            ClipAndOverlay(
                cornerRadius: cornerRadius,
                borderColor: borderColor,
                borderWidth: borderWidth
            )
        )
    }
}
