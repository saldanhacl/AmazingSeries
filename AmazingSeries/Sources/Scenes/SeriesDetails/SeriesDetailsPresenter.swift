//
//  SeriesDetailsPresenter.swift
//  AmazingSeries
//
//  Created by Lucas Honorato Saldanha on 07/11/21.
//

import Foundation

protocol SeriesDetailsPresentationLogic {
    func presentData(_ data: SeriesDetails.Response)
    func presentEpisodesData(_ data: [Episodes.Response])
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
    
    func presentEpisodesData(_ data: [Episodes.Response]) {
        let seasons = Dictionary(grouping: data, by: \.season).sorted { $0.key < $1.key }
        let viewModels = seasons.map {
            Episodes.ViewModel.Season(name: "Season \($0.key)", episodes: $0.value.map { (episode: Episodes.Response) in
                Episodes.ViewModel.Episode(
                    name: episode.name,
                    number: String(episode.number),
                    summary: episode.summary,
                    cover: episode.image.medium
                )
            })
        }
        
        viewController?.displaySeasonsData(viewModels)
    }
}
