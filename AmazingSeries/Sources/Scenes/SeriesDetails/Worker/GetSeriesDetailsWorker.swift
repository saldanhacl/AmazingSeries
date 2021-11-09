//
//  GetSeriesDetailsWorker.swift
//  AmazingSeries
//
//  Created by Lucas Honorato Saldanha on 07/11/21.
//

import Foundation

protocol GetSeriesDetailsWorkerProtocol {
    func getDetails(id: Int, handle: @escaping (Result<SeriesDetails.Response, Error>
    ) -> Void)
}

final class GetSeriesDetailsWorker: GetSeriesDetailsWorkerProtocol {
    
    // MARK: Dependencies
    
    @Dependency private var networkManager: NetworkManagerProtocol
    
    // MARK: GetSeriesWorkerProtocol
    
    func getDetails(id: Int, handle: @escaping (Result<SeriesDetails.Response, Error>
    ) -> Void) {
        let request = API.seriesDetails(id: String(id))
        networkManager.fetch(of: SeriesDetails.Response.self, for: request) { result in
            switch result {
            case let .success(data):
                handle(.success(data))
            case let .failure(error):
                handle(.failure(error))
            }
        }
    }
}
