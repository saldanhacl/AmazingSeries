//
//  ImageDownloaderProtocol.swift
//  AmazingSeries
//
//  Created by Lucas Honorato Saldanha on 07/11/21.
//

import Foundation
import UIKit

protocol ImageDownloaderProtocol {
    func fetchImage(on imageView: UIImageView, urlString: String, placeholder: UIImage?, completion: @escaping (UIImage?, Error?) -> Void)
}
