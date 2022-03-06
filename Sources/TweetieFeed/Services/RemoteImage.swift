//
//  RemoteImage.swift
//  
//
//  Created by Galina on 26/02/2022.
//

import SwiftUI

struct RemoteImage: View {
    private enum LoadState {
        case loading, success, failure
    }

    private class Loader: ObservableObject {
        var state = LoadState.loading
        var image: UIImage?
        
        private var cache = ImageCache()
        private let url: URL
        
        init(url: String) {
            guard let parsedURL = URL(string: url) else {
                fatalError("Invalid URL: \(url)")
            }
            self.url = parsedURL
        }
        
        func load() {
            if let image = self.cache.get(forKey: self.url.absoluteString) {
                self.image = image
                self.state = .success
            } else {
                URLSession.shared.dataTask(with: url) { [self] data, _, _ in
                    if let data = data, data.count > 0, let image = UIImage(data: data) {
                        self.image = image
                        self.cache.set(forKey: self.url.absoluteString, image: image)
                        self.state = .success
                    } else {
                        self.state = .failure
                    }
                    
                    DispatchQueue.main.async {
                        self.objectWillChange.send()
                    }
                }.resume()
            }
        }
        
    }

    @StateObject private var loader: Loader
    var loading: Image
    var failure: Image

    var body: some View {
        selectImage()
            .resizable()
            .onAppear(perform: loader.load)
    }

    init(url: String, loading: Image = Image(systemName: "photo"), failure: Image = Image(systemName: "multiply.circle")) {
        _loader = StateObject(wrappedValue: Loader(url: url))
        self.loading = loading
        self.failure = failure
    }

    private func selectImage() -> Image {
        switch loader.state {
        case .loading:
            return loading
        case .failure:
            return failure
        default:
            if let image = loader.image {
                return Image(uiImage: image)
            } else {
                return failure
            }
        }
    }
}

#if DEBUG
struct RemoteImage_Previews: PreviewProvider {
    static var previews: some View {
        RemoteImage(url: "https://dummyimage.com/squarepopup")
            .previewLayout(.fixed(width: 100, height: 100))
    }
}
#endif

