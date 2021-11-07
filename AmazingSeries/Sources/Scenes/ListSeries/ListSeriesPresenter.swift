//
//  ListSeriesPresenter.swift
//  AmazingSeries
//
//  Created by Lucas Honorato Saldanha on 07/11/21.
//

import Foundation

protocol ListSeriesPresentationLogic {
   func presentSeriesData(_ data: [ListSeries.Response])
}

final class ListSeriesPresenter {
    
    // MARK: Dependencies
    
    weak var viewController: ListSeriesDisplayLogic?
    
}

// MARK: ListSeriesPresentationLogic

extension ListSeriesPresenter: ListSeriesPresentationLogic {
    func presentSeriesData(_ data: [ListSeries.Response]) {
        let viewModels: [ListSeries.ViewModel] = data.map { .init(name: $0.name, posterURL: $0.url) }
        viewController?.displaySeriesList(viewModels)
    }
}