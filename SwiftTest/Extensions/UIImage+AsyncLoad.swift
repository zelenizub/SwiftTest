//
//  UIImage+AsyncLoad.swift
//  SwiftTest
//
//  Created by Zeljko Ilic on 10/21/19.
//  Copyright © 2019 Test. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Image cache
let imageCache = NSCache<NSString, UIImage>()

// MARK: - UIImageView extension
extension UIImageView {
    func loadImage(from urlString : String, placeholder: UIImage? = nil, usingCache: Bool = true) {
        self.image = placeholder
        if usingCache, let cachedImage = imageCache.object(forKey: urlString as NSString) {
            self.image = cachedImage
            return
        }
        downloadImage(from: urlString)
    }

    private func downloadImage(from urlString: String) {
        AsyncImageDownloader.shared.downloadImage(from: urlString) { result in
            switch result {
            case let .success(image):
                imageCache.setObject(image, forKey: urlString as NSString)
                self.image = image
            case let .failure(error):
                print("🔴 Error downloading image: \(error.localizedDescription)!")
            }
        }
    }
}
