//
//  ClipAndOverlay.swift
//  Template
//
//  Created by ykkd on 2021/10/11.
//

import Foundation
import SwiftUI

struct ClipAndOverlay: ViewModifier {
    
    var cornerRadius: CGFloat
    var borderColor: Color
    var borderWidth: CGFloat
    
    func body(content: Content) -> some View {
        content
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(lineWidth: borderWidth)
                    .foregroundColor(borderColor)
            )
    }
}
