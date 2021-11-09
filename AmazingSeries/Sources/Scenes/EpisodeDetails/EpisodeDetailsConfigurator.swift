//
//  EpisodeDetailsConfigurator.swift
//  AmazingSeries
//
//  Created by Lucas Honorato Saldanha on 08/11/21.
//

import UIKit

struct EpisodeDetailsParameters {
    let name: String
    let number: String
    let season: String
    let summary: String?
    let image: String?
}

protocol EpisodeDetailsConfiguratorProtocol {
    func resolveViewController(parameters: EpisodeDetailsParameters) -> UIViewController
}

final class EpisodeDetailsConfigurator: EpisodeDetailsConfiguratorProtocol {
    
    func resolveViewController(parameters: EpisodeDetailsParameters) -> UIViewController {
        let presenter = EpisodeDetailsPresenter()
        let interactor = EpisodeDetailsInteractor(presenter: presenter, episode: .init(
            name: parameters.name,
            number: parameters.number,
            season: parameters.season,
            summary: parameters.summary,
            cover: parameters.image)
        )
        
        let viewController = EpisodeDetailsViewController(interactor: interactor)
    
        presenter.viewController = viewController
        return viewController
    }
}
