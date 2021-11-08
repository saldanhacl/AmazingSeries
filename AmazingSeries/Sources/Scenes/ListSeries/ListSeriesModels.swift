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
        let rating: Rating?
        let genres: [String]?
        let premiered: String?
        let image: Image?
        
        struct Rating: Codable {
            let average: Double?
        }
        
        struct Image: Codable {
            let medium: String
        }
    }
    
    struct ViewModel {
        let id: Int
        let title: String
        let rating: String
        let genres: String
        let posterURL: String?
    }
    
    enum RequestError: Error {
        case failed
    }
}

enum SearchSeries {
    struct Request {
        let query: String
    }
    
    struct Response: Codable {
        let score: Double
        let show: ListSeries.Response
    }
    
    enum RequestError: Error {
        case failed
    }
}
