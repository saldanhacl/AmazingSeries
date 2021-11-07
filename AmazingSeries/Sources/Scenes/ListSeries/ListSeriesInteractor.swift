//
//  ListSeriesInteractor.swift
//  AmazingSeries
//
//  Created by Lucas Honorato Saldanha on 07/11/21.
//

import Foundation

protocol ListSeriesBusinessLogic {
    func onViewDidLoad()
}

final class ListSeriesInteractor {
    
    // MARK: Dependencies
    
    private let presenter: ListSeriesPresentationLogic
    private let getSeriesWorker: GetSeriesWorkerProtocol
    
    // MARK: Initialization
    
    init(presenter: ListSeriesPresentationLogic, getSeriesWorker: GetSeriesWorkerProtocol) {
        self.presenter = presenter
        self.getSeriesWorker = getSeriesWorker
    }
}

// MARK: ListSeriesBusinessLogic

extension ListSeriesInteractor: ListSeriesBusinessLogic {
    func onViewDidLoad() {
        getSeries(page: 0)
    }
    
    // MARK: Private methods
    
    private func getSeries(page: Int) {
        getSeriesWorker.listShows(page: page) { result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case let .success(response):
                    self?.presenter.presentSeriesData(response)
                case .failure:
                    // TODO: add failure presentation
                    break
                }
            }
        }
    }
}
