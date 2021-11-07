//
//  SeriesDetailsRouter.swift
//  AmazingSeries
//
//  Created by Lucas Honorato Saldanha on 07/11/21.
//

import UIKit

protocol SeriesDetailsRoutingLogic {
    func goToEpisode(id: Int)
}

final class SeriesDetailsRouter {
    
    // MARK: Depdendencies
    
    weak var viewController: UIViewController?
}

// MARK: SeriesDetailsRoutingLogic

extension SeriesDetailsRouter: SeriesDetailsRoutingLogic {
    func goToEpisode(id: Int) {
        // TODO: Route when ready
    }
}
