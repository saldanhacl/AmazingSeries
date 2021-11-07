//
//  UIImageView+Network.swift
//  AmazingSeries
//
//  Created by Lucas Honorato Saldanha on 07/11/21.
//

import UIKit

extension UIImageView {
    func fetchImage(
        with urlString: String,
        placeholder: UIImage? = nil,
        imageDownloader: ImageDownloaderProtocol
    ) {
        imageDownloader.fetchImage(on: self, urlString: urlString, placeholder: placeholder) { [weak self] data, error in
            if let data = data {
                self?.image = data
            }
        }
    }
}
