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
}

final class ListSeriesInteractor {
    
    // MARK: Dependencies
    
    private let presenter: ListSeriesPresentationLogic
    private let getSeriesWorker: GetSeriesWorkerProtocol
    
    // MARK: Private properties
    
    private var currentPage: Int = .zero
    
    // MARK: Initialization
    
    init(presenter: ListSeriesPresentationLogic, getSeriesWorker: GetSeriesWorkerProtocol) {
        self.presenter = presenter
        self.getSeriesWorker = getSeriesWorker
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
    
    // MARK: Private methods
    
    private func getSeries(page: Int, append: Bool = false) {
        getSeriesWorker.listShows(page: page) { result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case let .success(response):
                    self?.presenter.presentSeriesData(response, append: append)
                case .failure:
                    // TODO: add failure presentation
                    self?.currentPage -= 1
                    break
                }
            }
        }
    }
}
