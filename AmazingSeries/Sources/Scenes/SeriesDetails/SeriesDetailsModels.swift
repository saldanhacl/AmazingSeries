//
//  SeriesDetailsModels.swift
//  AmazingSeries
//
//  Created by Lucas Honorato Saldanha on 07/11/21.
//

import Foundation

enum SeriesDetails {
    struct Request {
        let id: Int
    }
    
    struct Response: Codable {
        let name: String
        let image: Image
        let schedule: Schedule
        let genres: [String]
        let summary: String
        
        struct Image: Codable {
            let original: String
        }
        
        struct Schedule: Codable {
            let time: String
            let days: [String]
        }
    }
    
    struct ViewModel {
        let name: String
        let posterURL: String
        let schedule: String
        let genres: [String]
        let summary: String
    }
}
