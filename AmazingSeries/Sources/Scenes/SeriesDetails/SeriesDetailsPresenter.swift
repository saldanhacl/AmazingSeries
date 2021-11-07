//
//  SeriesDetailsPresenter.swift
//  AmazingSeries
//
//  Created by Lucas Honorato Saldanha on 07/11/21.
//

import Foundation

protocol SeriesDetailsPresentationLogic {
    func presentData(_ data: SeriesDetails.Response)
}

final class SeriesDetailsPresenter {
    
    // MARK: Dependencies
    
    weak var viewController: SeriesDetailsDisplayLogic?
}

// MARK: SeriesDetailsPresentationLogic

extension SeriesDetailsPresenter: SeriesDetailsPresentationLogic {
    func presentData(_ data: SeriesDetails.Response) {
        let viewModel = SeriesDetails.ViewModel(
            name: data.name,
            posterURL: data.image.original,
            schedule: "Every \(data.schedule.days.joined(separator: ", ")) at \(data.schedule.time)",
            genres: data.genres.joined(separator: " - "),
            summary: data.summary
        )
        
        viewController?.displayData(viewModel)
    }
}
