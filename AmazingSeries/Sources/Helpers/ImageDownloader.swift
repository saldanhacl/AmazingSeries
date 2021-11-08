//
//  ImageDownloader.swift
//  AmazingSeries
//
//  Created by Lucas Honorato Saldanha on 07/11/21.
//

import Foundation
import Kingfisher

final class ImageDownloader: ImageDownloaderProtocol {
    func fetchImage(on imageView: UIImageView, urlString: String, placeholder: UIImage?, completion: @escaping (UIImage?, Error?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        imageView.kf.setImage(with: url, placeholder: placeholder) { result in
            switch result {
            case let .success(result):
                completion(result.image, nil)
            case let .failure(error):
                completion(nil, error)
            }
        }
    }
}
