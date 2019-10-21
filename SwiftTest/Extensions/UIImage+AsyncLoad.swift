//
//  UIImage+AsyncLoad.swift
//  SwiftTest
//
//  Created by Zeljko Ilic on 10/21/19.
//  Copyright © 2019 Test. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()

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
        guard let url = URL(string: urlString) else {
            print("🔴 Invalid image url: \(urlString)!")
            return
        }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            DispatchQueue.main.async {
                if let image = UIImage(data: data!) {
                    imageCache.setObject(image, forKey: urlString as NSString)
                    self.image = image
                }
            }
        }).resume()
    }
}
