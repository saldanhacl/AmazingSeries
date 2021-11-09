//
//  ListSeriesInteractor.swift
//  AmazingSeries
//
//  Created by Lucas Honorato Saldanha on 07/11/21.
//

import Foundation

protocol ListSeriesBusinessLogic {
    func onViewDidLoad()
    func loadMoreData()
    func searchSeries(query: String)
}

final class ListSeriesInteractor {
    
    // MARK: Dependencies
    
    private let presenter: ListSeriesPresentationLogic
    private let getSeriesWorker: GetSeriesWorkerProtocol
    private let searchSeriesWorker: SearchSeriesWorkerProtocol
    private let dispatchQueue: DispatchQueueProtocol
    
    // MARK: Private properties
    
    private var currentPage: Int = .zero
    
    // MARK: Internal properties
    
    var seriesList: [ListSeries.Response] = []
    
    // MARK: Initialization
    
    init(
        presenter: ListSeriesPresentationLogic,
        getSeriesWorker: GetSeriesWorkerProtocol,
        searchSeriesWorker: SearchSeriesWorkerProtocol,
        dispatchQueue: DispatchQueueProtocol
    ) {
        self.presenter = presenter
        self.getSeriesWorker = getSeriesWorker
        self.searchSeriesWorker = searchSeriesWorker
        self.dispatchQueue = dispatchQueue
    }
}

// MARK: ListSeriesBusinessLogic

extension ListSeriesInteractor: ListSeriesBusinessLogic {
    func onViewDidLoad() {
        getSeries(page: currentPage)
    }
    
    func loadMoreData() {
        currentPage += 1
        getSeries(page: currentPage, append: true)
    }
    
    func searchSeries(query: String) {
        if query.isEmpty {
            presenter.presentSeriesData(seriesList)
        } else {
            loadSeries(by: query)
        }
    }
    
    // MARK: Private methods
    
    private func getSeries(page: Int, append: Bool = false) {
        getSeriesWorker.listShows(page: page) { [weak self] result in
            self?.dispatchQueue.async {
                switch result {
                case let .success(response):
                    guard var seriesList = self?.seriesList, append else {
                        self?.seriesList = response
                        self?.presenter.presentSeriesData(response)
                        return
                    }
                    
                    seriesList.append(contentsOf: response)
                    self?.seriesList = seriesList
                    self?.presenter.presentSeriesData(seriesList)
                case .failure:
                    self?.presenter.presentError()
                    self?.currentPage -= 1
                    break
                }
            }
        }
    }
    
    private func loadSeries(by query: String) {
        searchSeriesWorker.search(by: query) { [weak self] result in
            self?.dispatchQueue.async {
                switch result {
                case let .success(response):
                    let series: [ListSeries.Response] = response.map { $0.show }
                    self?.presenter.presentSeriesData(series)
                case .failure:
                    self?.presenter.presentError()
                    break
                }
            }
        }
    }

}
