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
        let name: String
        let url: String
    }
    
    struct ViewModel {
        let name: String
        let posterURL: String
    }
    
    enum RequestError: Error {
        case failed
    }
}
