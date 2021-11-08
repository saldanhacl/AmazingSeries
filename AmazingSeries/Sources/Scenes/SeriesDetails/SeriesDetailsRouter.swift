//
//  SeriesDetailsRouter.swift
//  AmazingSeries
//
//  Created by Lucas Honorato Saldanha on 07/11/21.
//

import UIKit

protocol SeriesDetailsRoutingLogic {
    func goToEpisode(_ data: Episodes.ViewModel.Episode)
}

final class SeriesDetailsRouter {
    
    // MARK: Depdendencies
    
    weak var viewController: UIViewController?
    
    // MARK: Private properties
    
    private let sceneFactory: EpisodeDetailsConfiguratorProtocol
    
    // MARK: Initialization
    
    init(sceneFactory: EpisodeDetailsConfiguratorProtocol) {
        self.sceneFactory = sceneFactory
    }
}

// MARK: SeriesDetailsRoutingLogic

extension SeriesDetailsRouter: SeriesDetailsRoutingLogic {
    func goToEpisode(_ data: Episodes.ViewModel.Episode) {
        let destination = sceneFactory.resolveViewController(parameters: .init(
            name: data.name,
            number: data.number,
            season: data.season,
            summary: data.summary,
            image: data.cover)
        )
        
        viewController?.present(destination, animated: true)
    }
}
