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
        let viewModels: [Episodes.ViewModel.Season] = seasons.map {
            let seasonString = "Season \($0.key)"
            return Episodes.ViewModel.Season(name: seasonString, episodes: $0.value.map { [seasonString] (episode: Episodes.Response) in
                Episodes.ViewModel.Episode(
                    name: episode.name,
                    season: seasonString,
                    number: String(episode.number),
                    summary: episode.summary,
                    coverImage: episode.image.medium,
                    originalImage: episode.image.original
                )
            })
        }
        
        viewController?.displaySeasonsData(viewModels)
    }
}
