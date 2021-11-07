//
//  ListSeriesRouter.swift
//  AmazingSeries
//
//  Created by Lucas Honorato Saldanha on 07/11/21.
//

import Foundation
import UIKit

protocol ListSeriesRoutingLogic {
    
}

final class ListSeriesRouter {
    
    // MARK: Depdendencies
    
    weak var viewController: UIViewController?
    
    // MARK: Private properties
    
    private let sceneFactory: SceneFactory
    
    // MARK: Initialization
    
    init(sceneFactory: SceneFactory) {
        self.sceneFactory = sceneFactory
    }
}

// MARK: ListSeriesRoutingLogic

extension ListSeriesRouter: ListSeriesRoutingLogic {
    
}
