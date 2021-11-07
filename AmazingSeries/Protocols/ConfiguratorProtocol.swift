//
//  ConfiguratorProtocol.swift
//  AmazingSeries
//
//  Created by Lucas Honorato Saldanha on 07/11/21.
//

import Foundation
import UIKit

protocol SceneFactory {
    func resolveViewController() -> UIViewController
}
