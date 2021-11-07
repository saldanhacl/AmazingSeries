//
//  APIService.swift
//  AmazingSeries
//
//  Created by Lucas Honorato Saldanha on 07/11/21.
//

import Foundation

enum API {
    case listSeries(queryParams: [String: String])
    case seriesDetails(id: String)
}

extension API: NetworkRequest {
    var baseURL: String {
        Config.seriesAPIUrl
    }
    
    var path: String {
        switch self {
        case .listSeries:
            return "/shows"
        case let .seriesDetails(id):
            return "/shows/\(id)"
        }
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var queryItems: [String: String] {
        switch self {
        case let .listSeries(queryParams):
            return queryParams
        case .seriesDetails(_):
            return [:]
        }
    }
}
