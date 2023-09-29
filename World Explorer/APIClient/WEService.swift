//
//  WEService.swift
//  World Explorer
//
//  Created by Zakaria Marouf on 23/09/23.
//

import Foundation

/// Primary API Service object to get countries Data
final class WEService {
    /// Shared singleton instance
    static let shared = WEService()
    
    /// Privatized constructor
    private init() {}
    
    enum WEServiceError: Error {
        case failedToCreateRequest
        case failedToGetData
    }
    
    /// Send API Call
    /// - Parameters:
    ///   - request: Request instance
    ///   - Type: The type of object we expect to get back
    ///   - completion: Callback with data or error
    
    public func execute<T: Codable>(_ request: WERequest, expecting type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        guard let urlRequest = self.request(from: request) else {
            completion(.failure(WEServiceError.failedToCreateRequest))
            return
        }
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? WEServiceError.failedToGetData))
                return
            }
            // Decode response
            do {
                let result = try JSONDecoder().decode(type.self, from: data)
                completion(.success(result))
            }
            catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    // MARK: - Private
    private func request(from weRequest: WERequest) -> URLRequest? {
        guard let url = weRequest.url else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = weRequest.httpMethod
        return request
    }
}
