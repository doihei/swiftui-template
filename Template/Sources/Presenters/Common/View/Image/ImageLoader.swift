//
//  ImageLoader.swift
//  Template
//
//  Created by 土井大平 on 2021/08/10.
//

import Combine
import Nuke
import SwiftUI

class ImageLoader: ObservableObject {
    let objectWillChange = PassthroughSubject<Void, Never>()

    var image: SwiftUI.Image? {
        willSet {
            objectWillChange.send()
        }
    }

    func load(_ url: String) {
        guard let url = URL(string: url) else { return }
        ImagePipeline.shared.loadImage(with: url, completion: { [weak self] in
            guard let self = self, let image = try? $0.get().image else { return }
            self.image = Image(uiImage: image)
        })
    }
}

#if DEBUG
struct ImageLoader_Previews: PreviewProvider {
    @ObservedObject static var imageLoader = ImageLoader()

    static var previews: some View {
        imageLoader.image
            .onAppear {
                imageLoader.load(
                    R.string.urLs.image()
                        .replacingOccurrences(of: "width", with: "10")
                        .replacingOccurrences(of: "height", with: "10")
                )
            }
    }
}
#endif
