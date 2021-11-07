//
//  ListSeriesModels.swift
//  AmazingSeries
//
//  Created by Lucas Honorato Saldanha on 07/11/21.
//

import Foundation

enum ListSeries {
    struct Request {
        let page: Int
    }
    
    struct Response: Codable {
        let id: Int
        let name: String
        let image: Image
        
        struct Image: Codable {
            let original: String
            let medium: String
        }
    }
    
    struct ViewModel {
        let id: Int
        let name: String
        let posterURL: String
    }
    
    enum RequestError: Error {
        case failed
    }
    
    struct GetSeriesRequest: NetworkRequest {
        var baseURL: String {
            Config.seriesAPIUrl
        }
        
        var path: String {
            "/shows"
        }
        
        var method: HTTPMethod {
            .get
        }
        
        var queryItems: [String: String]?
    }
}
