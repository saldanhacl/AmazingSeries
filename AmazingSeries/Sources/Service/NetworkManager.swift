//
//  APIService.swift
//  AmazingSeries
//
//  Created by Lucas Honorato Saldanha on 07/11/21.
//

import Foundation

class NetworkManager: NetworkManagerProtocol {
    func fetch<T: Decodable>(of type: T.Type, for request: NetworkRequest, completion: @escaping (Result<T, Error>) -> Void) {
        
        let urlRequest = buildURLRequest(request)
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            do {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else {
                    preconditionFailure("No error was received but we also don't have data...")
                }
                
                let decodedObject = try JSONDecoder().decode(T.self, from: data)
                
                completion(.success(decodedObject))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    private func buildURLRequest(_ request: NetworkRequest) -> URLRequest {
        let urlString: String = "\(request.baseURL)\(request.path)"
        guard var urlComponent = URLComponents(string: urlString) else { preconditionFailure("Invalid URL") }
        
        let queryItems: [URLQueryItem]? = request.queryItems?.compactMap { URLQueryItem(name: $0.key, value: $0.value) }
        urlComponent.queryItems = queryItems

        guard let url = urlComponent.url else { preconditionFailure("Failed to build request") }
        return URLRequest(url: url)
    }
}
