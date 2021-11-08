//
//  SeriesDetailsInteractor.swift
//  AmazingSeries
//
//  Created by Lucas Honorato Saldanha on 07/11/21.
//

import Foundation

protocol SeriesDetailsBusinessLogic {
    func onViewDidLoad()
}

final class SeriesDetailsInteractor {
    
    // MARK: Dependencies
    
    private let seriesId: Int
    private let presenter: SeriesDetailsPresentationLogic
    private let getSeriesDetailsWorker: GetSeriesDetailsWorkerProtocol
    private let getEpisodesWorker: GetEpisodesWorkerProtocol

    // MARK: Initialization
    
    init(
        seriesId: Int,
        presenter: SeriesDetailsPresentationLogic,
        getSeriesDetailsWorker: GetSeriesDetailsWorkerProtocol,
        getEpisodesWorker: GetEpisodesWorkerProtocol
    ) {
        self.seriesId = seriesId
        self.presenter = presenter
        self.getSeriesDetailsWorker = getSeriesDetailsWorker
        self.getEpisodesWorker = getEpisodesWorker
    }
}

// MARK: ListSeriesBusinessLogic

extension SeriesDetailsInteractor: SeriesDetailsBusinessLogic {
    func onViewDidLoad() {
        loadSeriesDetails()
        loadEpisodes()
    }
    
    // MARK: Private methods
        
    private func loadSeriesDetails() {
        getSeriesDetailsWorker.getDetails(id: seriesId) { result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case let .success(response):
                    self?.presenter.presentData(response)
                case .failure:
                    // TODO: add failure presentation
                    break
                }
            }
        }
    }
    
    private func loadEpisodes() {
        getEpisodesWorker.getEpisodes(seriesId: seriesId) { result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case let .success(response):
                    self?.presenter.presentEpisodesData(response)
                case .failure:
                    // TODO: add failure presentation
                    break
                }
            }
        }
    }
}
