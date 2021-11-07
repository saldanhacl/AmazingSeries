//
//  ListSeriesWorker.swift
//  AmazingSeries
//
//  Created by Lucas Honorato Saldanha on 07/11/21.
//

import Foundation


protocol GetSeriesWorkerProtocol {
    func listShows(page: Int, handle: @escaping (Result<[ListSeries.Response], ListSeries.RequestError>
    ) -> Void)
}

final class GetSeriesWorker: GetSeriesWorkerProtocol {
    
    // MARK: Dependencies
    
    @Dependency private var networkManager: NetworkManagerProtocol
    
    // MARK: GetSeriesWorkerProtocol
    
    func listShows(page: Int, handle: @escaping (Result<[ListSeries.Response], ListSeries.RequestError>
    ) -> Void) {
        var request = ListSeries.GetSeriesRequest()
        request.queryItems = ["page": String(page)]
        
        networkManager.fetch(of: [ListSeries.Response].self, for: request) { result in
            switch result {
            case let .success(data):
                handle(.success(data))
            case .failure(_):
                handle(.failure(.failed))
            }
        }
    }
}
