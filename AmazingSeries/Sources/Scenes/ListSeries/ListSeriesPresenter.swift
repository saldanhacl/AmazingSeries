//
//  ListSeriesPresenter.swift
//  AmazingSeries
//
//  Created by Lucas Honorato Saldanha on 07/11/21.
//

import Foundation

protocol ListSeriesPresentationLogic {
    func presentSeriesData(_ data: [ListSeries.Response])
    func presentError()
}

final class ListSeriesPresenter {
    
    // MARK: Dependencies
    
    weak var viewController: ListSeriesDisplayLogic?
}

// MARK: ListSeriesPresentationLogic

extension ListSeriesPresenter: ListSeriesPresentationLogic {
    func presentSeriesData(_ data: [ListSeries.Response]) {
        let viewModels: [ListSeries.ViewModel] = data.map {
            .init(
                id: $0.id,
                title: getFormattedTitle(name: $0.name, premiered: $0.premiered),
                rating: getRatingString($0.rating?.average),
                genres: $0.genres?.joined(separator: ", ") ?? "",
                posterURL: $0.image?.medium
            )
            
        }
        viewController?.displaySeriesList(viewModels)
    }
    
    func presentError() {
        viewController?.displayErrorState()
    }
    
    // MARK: Private methods
    
    private func getFormattedTitle(name: String, premiered: String?) -> String {
        guard let premieredString = getYearFromDateString(premiered) else { return name }
        return "\(name) (\(premieredString))"
    }
    
    private func getRatingString(_ rating: Double?) -> String {
        guard let rating = rating else { return "" }
        return "\(String(rating))/10"
    }
    
    private func getYearFromDateString(_ dateString: String?) -> String? {
        guard let dateString = dateString, let year = dateString.toDate(dateFormatter: .init(format: "YYYY-MM-dd"))?.get(.year) else { return nil }
        return String(year)
    }
}
