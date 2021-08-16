//
//  SampleGithubListView.swift
//  Template
//
//  Created by doi on 2021/07/26.
//

import SwiftUI

struct SampleGithubListView: View {
    @ObservedObject var imageLoader = ImageLoader()

    var url: URL
    var login: String
    var action: () -> Void

    var body: some View {
        HStack {
            if imageLoader.image != nil {
                imageLoader.image?
                    .resizable()
                    .aspectRatio(1.0, contentMode: .fit)
                    .border(Color.gray, width: 0.5)
                    .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 8))
            }
            Text(login)
            Spacer()
            Button(action: action, label: {
                Text(R.string.sampleGithub.listDetailButtonTitle())
            })
            .buttonStyle(BorderlessButtonStyle())
        }
        .frame(height: 83)
        .onAppear {
            imageLoader.load(url.absoluteString)
        }
    }
}

#if DEBUG
struct SampleGithubListView_Previews: PreviewProvider {
    static let random: Int = Int.random(in: 0..<100)

    static var previews: some View {
        SampleGithubListView(
            url: URL(
                string: R.string.urLs.image()
                    .replacingOccurrences(of: "width", with: "\(random * 10)")
                    .replacingOccurrences(of: "height", with: "\(random * 10)")
            )!,
            login: "Mr. \(random)",
            action: {}
        )
    }
}
#endif
