//
//  EpisodeDetailsInteractor.swift
//  AmazingSeries
//
//  Created by Lucas Honorato Saldanha on 08/11/21.
//

import UIKit

protocol EpisodeDetailsBusinessLogic {
    func onViewDidLoad()
}

class EpisodeDetailsInteractor {
    
    // MARK: Dependencies
    
    private let presenter: EpisodeDetailsPresentationLogic
    private let episode: EpisodeDetails.ViewModel
    
    // MARK: Initialization
    
    init(presenter: EpisodeDetailsPresentationLogic, episode: EpisodeDetails.ViewModel) {
        self.presenter = presenter
        self.episode = episode
    }
}

// MARK: EpisodeDetailsBusinessLogic

extension EpisodeDetailsInteractor: EpisodeDetailsBusinessLogic {
    func onViewDidLoad() {
        presenter.presentViewData(episode)
    }
}
