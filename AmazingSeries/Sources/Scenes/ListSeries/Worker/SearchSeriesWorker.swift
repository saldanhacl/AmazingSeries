//
//  SearchSeriesWorker.swift
//  AmazingSeries
//
//  Created by Lucas Honorato Saldanha on 08/11/21.
//

import Foundation

protocol SearchSeriesWorkerProtocol {
    func search(by query: String, handle: @escaping (Result<[SearchSeries.Response], SearchSeries.RequestError>
    ) -> Void)
}

final class SearchSeriesWorker: SearchSeriesWorkerProtocol {
    
    // MARK: Dependencies
    
    @Dependency private var networkManager: NetworkManagerProtocol
    
    // MARK: GetSeriesWorkerProtocol
    
    func search(by query: String, handle: @escaping (Result<[SearchSeries.Response], SearchSeries.RequestError>
    ) -> Void) {
        let request = API.searchSeries(queryParams: ["q": String(query).lowercased()])
        networkManager.fetch(of: [SearchSeries.Response].self, for: request) { result in
            switch result {
            case let .success(data):
                handle(.success(data))
            case .failure(_):
                handle(.failure(.failed))
            }
        }
    }
}
