//
//  Config.swift
//  AmazingSeries
//
//  Created by Lucas Honorato Saldanha on 07/11/21.
//

import Foundation

class Config {
    private static func valueDictionary(key: String) -> String {
        if let path = Bundle.main.path(forResource: "Info", ofType: "plist") {
            if let dic = NSDictionary(contentsOfFile: path) {
                return dic[key] as? String ?? ""
            }
        }
        
        return ""
    }
    
    static var seriesAPIUrl: String {
        get {
            return valueDictionary(key: "SERIES_API_URL")
        }
    }
}
