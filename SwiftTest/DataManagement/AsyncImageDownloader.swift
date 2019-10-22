//
//  AsyncImageDownloader.swift
//  SwiftTest
//
//  Created by Zeljko Ilic on 10/22/19.
//  Copyright © 2019 Test. All rights reserved.
//

import Foundation
import UIKit

typealias ImageDownloadCompletonHandler = (Result<UIImage, Error>) -> Void

enum ImageDownloadError: Error {
    case invalidURL
    case invalidData
}

// Limits simultaneous image download to at most 10 at a time.
class AsyncImageDownloader {
    // MARK: - Singleton
    static let shared = AsyncImageDownloader()
    private init() {}

    // MARK: - Constants
    private let maxDownloadedImages = 10
    private var currentlyDownloadedImages = 0

    // MARK: - API
    func downloadImage(from urlString: String, onCompletion: @escaping ImageDownloadCompletonHandler) {
        guard currentlyDownloadedImages < maxDownloadedImages else {
            DispatchQueue.global().asyncAfter(deadline: .now() + 0.1) {
                self.downloadImage(from: urlString, onCompletion: onCompletion)
            }
            return
        }
        performDownload(from: urlString, onCompletion: onCompletion)
    }

    // MARK: - Utils
    private func performDownload(from urlString: String, onCompletion: @escaping ImageDownloadCompletonHandler) {
        guard let url = URL(string: urlString) else {
            onCompletion(.failure(ImageDownloadError.invalidURL))
            return
        }
        currentlyDownloadedImages += 1
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            self.currentlyDownloadedImages -= 1
            if let error = error {
                onCompletion(.failure(error))
                return
            }
            DispatchQueue.main.async {
                guard let data = data, let image = UIImage(data: data) else {
                    onCompletion(.failure(ImageDownloadError.invalidData))
                    return
                }
                onCompletion(.success(image))
            }
        }).resume()
    }
}
