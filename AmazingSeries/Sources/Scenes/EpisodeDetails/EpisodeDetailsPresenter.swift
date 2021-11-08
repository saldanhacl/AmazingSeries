//
//  EpisodeDetailsPresenter.swift
//  AmazingSeries
//
//  Created by Lucas Honorato Saldanha on 08/11/21.
//

import UIKit

protocol EpisodeDetailsPresentationLogic {
    func presentViewData(_ data: EpisodeDetails.ViewModel)
}

class EpisodeDetailsPresenter: EpisodeDetailsPresentationLogic {
    
    // MARK: Dependencies
    
    weak var viewController: EpisodeDetailsDisplayLogic?
    
    func presentViewData(_ data: EpisodeDetails.ViewModel) {
        viewController?.displayViewData(data)
    }
}
