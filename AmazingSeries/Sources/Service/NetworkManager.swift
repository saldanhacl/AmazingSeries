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
        
        Swift.print("Request: \(urlRequest)")
        
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
            } catch DecodingError.keyNotFound(let key, let context) {
                Swift.print("could not find key \(key) in JSON: \(context.debugDescription)")
            } catch DecodingError.valueNotFound(let type, let context) {
                Swift.print("could not find type \(type) in JSON: \(context.debugDescription)")
            } catch DecodingError.typeMismatch(let type, let context) {
                Swift.print("type mismatch for type \(type) in JSON: \(context.debugDescription)")
            } catch DecodingError.dataCorrupted(let context) {
                Swift.print("data found to be corrupted in JSON: \(context.debugDescription)")
            } catch let error as NSError {
                NSLog("Error in read(from:ofType:) domain= \(error.domain), description= \(error.localizedDescription)")

            }
        }.resume()
    }
    
    private func buildURLRequest(_ request: NetworkRequest) -> URLRequest {
        let urlString: String = "\(request.baseURL)\(request.path)"
        guard var urlComponent = URLComponents(string: urlString) else { preconditionFailure("Invalid URL") }
        
        let queryItems: [URLQueryItem]? = request.queryItems.map { URLQueryItem(name: $0.key, value: $0.value) }
        urlComponent.queryItems = queryItems

        guard let url = urlComponent.url else { preconditionFailure("Failed to build request") }
        return URLRequest(url: url)
    }
}
