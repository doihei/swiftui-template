//
//  WebView.swift
//  Template
//
//  Created by 土井大平 on 2021/08/10.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    var url: URL

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(URLRequest(url: url))
    }
}

#if DEBUG
struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WebView(url: URL(string: "https://google.com")!)
        }
    }
}
#endif
