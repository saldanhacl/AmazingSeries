//
//  GetSeriesRequest.swift
//  AmazingSeries
//
//  Created by Lucas Honorato Saldanha on 07/11/21.
//

import Foundation

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
}
