//
//  NetworkProtocols.swift
//  AmazingSeries
//
//  Created by Lucas Honorato Saldanha on 07/11/21.
//

import Foundation

enum HTTPMethod {
    case get
    case post
}

protocol NetworkRequest {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [String: String] { get }
}

protocol NetworkManagerProtocol {
    func fetch<T: Decodable>(of type: T.Type, for request: NetworkRequest, completion: @escaping (Result<T, Error>) -> Void)
}
