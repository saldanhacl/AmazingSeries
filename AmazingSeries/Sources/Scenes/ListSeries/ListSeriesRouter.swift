//
//  ListSeriesRouter.swift
//  AmazingSeries
//
//  Created by Lucas Honorato Saldanha on 07/11/21.
//

import Foundation
import UIKit

protocol ListSeriesRoutingLogic {
    func goToSeriesDetails(id: Int)
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
    func goToSeriesDetails(id: Int) {
        let destination = sceneFactory.resolveViewController()
        viewController?.navigationController?.pushViewController(destination, animated: true)
    }
}
