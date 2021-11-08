//
//  GetEpisodesWorker.swift
//  AmazingSeries
//
//  Created by Lucas Honorato Saldanha on 07/11/21.
//

import Foundation

protocol GetEpisodesWorkerProtocol {
    func getEpisodes(seriesId: Int, handle: @escaping (Result<[Episodes.Response], Error>
    ) -> Void)
}

final class GetEpisodesWorker: GetEpisodesWorkerProtocol {
    
    // MARK: Dependencies
    
    @Dependency private var networkManager: NetworkManagerProtocol
    
    // MARK: GetSeriesWorkerProtocol
    
    func getEpisodes(seriesId: Int, handle: @escaping (Result<[Episodes.Response], Error>
    ) -> Void) {
        let request = API.episodes(seriesId: String(seriesId))
        networkManager.fetch(of: [Episodes.Response].self, for: request) { result in
            switch result {
            case let .success(data):
                handle(.success(data))
            case let .failure(error):
                handle(.failure(error))
            }
        }
    }
}
