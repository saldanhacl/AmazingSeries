//
//  ImageDownloader.swift
//  AmazingSeries
//
//  Created by Lucas Honorato Saldanha on 07/11/21.
//

import Foundation
import UIKit

final class ImageDownloader: ImageDownloaderProtocol {
    private let cache = NSCache<NSString, UIImage>()
    
    func fetchImage(on imageView: UIImageView, urlString: String, placeholder: UIImage?, completion: @escaping (UIImage?, Error?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        if let cachedImage = cache.object(forKey: NSString(string: urlString)) {
            completion(cachedImage, nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, let image = UIImage(data: data), let self = self else { return }
            
            self.cache.setObject(image, forKey: NSString(string: urlString))
            completion(image, nil)
        }
        
        task.resume()
    }
}
