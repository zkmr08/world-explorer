//
//  WERequest.swift
//  World Explorer
//
//  Created by Zakaria Marouf on 23/09/23.
//

import Foundation

/// Object that represents a single API call
final class WERequest {
    
    // common or official value
    // https://restcountries.com/v3.1/name/eesti
    // https://restcountries.com/v3.1/name/deutschland
    
    // https://restcountries.com/v3.1/lang/spanish
    // https://restcountries.com/v3.1/lang/cop
    
    /// API Constants
    private struct Constants {
        static let baseUrl = "https://restcountries.com/v3.1"
    }
    
    /// Desired endpoint
    private let endpoint: WEEndpoint
    
    /// Path components for API, if any
    private let pathCompnents: [String]
    
    /// Query arguments for API, if any
    private let queryParameters: [URLQueryItem]
    
    /// Constructed url for the API request format
    private var urlString: String {
        var string = Constants.baseUrl
        string += "/"
        string += endpoint.rawValue
        
        if !pathCompnents.isEmpty {
            pathCompnents.forEach({
                string += "\($0)"
            })
        }
        
        if !queryParameters.isEmpty {
            string += "?"
            let argumentString = queryParameters.compactMap({
                guard let value = $0.value else { return nil }
                return "\($0.name)=\(value)"
            }).joined(separator: "&")
            string += argumentString
        }
        
        return string
    }
    
    /// Computed & constructed API url
    public var url: URL? {
        return URL(string: urlString)
    }
    
    /// Desired http method
    public let httpMethod = "GET"
    
    // MARK: - Public
    
    /// Contruct request
    ///   - Parameters:
    ///    - endpoint: Target endpoint
    ///    - pathComponents: Collection of Path components
    ///    - queryParameters: Collection of query parameters
    
    public init(endpoint: WEEndpoint, pathCompnents: [String] = [], queryParameters: [URLQueryItem] = []) {
        self.endpoint = endpoint
        self.pathCompnents = pathCompnents
        self.queryParameters = queryParameters
    }
    
    convenience init?(url: URL) {
        let string = url.absoluteString
        if !string.contains(Constants.baseUrl) {
            return nil
        }
        let trimmed = string.replacingOccurrences(of: Constants.baseUrl+"/", with: "")
        if trimmed.contains("/") {
            let components = trimmed.components(separatedBy: "/")
            if !components.isEmpty {
                let endpointString = components[0] // endpoint
                var pathComponents: [String] = []
                if components.count > 1 {
                    pathComponents = components
                    pathComponents.removeFirst()
                }
                if let weEndpoint = WEEndpoint(rawValue: endpointString) {
                    self.init(endpoint: weEndpoint, pathCompnents: pathComponents)
                    return
                }
            }
        } else if trimmed.contains("?") {
            let components = trimmed.components(separatedBy: "?")
            if !components.isEmpty, components.count >= 2 {
                let endpointString = components[0]
                let queryItemsString = components[1]
                let queryItems: [URLQueryItem] = queryItemsString.components(separatedBy: "&").compactMap({
                    guard $0.contains("=") else { return nil }
                    let parts = $0.components(separatedBy: "=")
                    return URLQueryItem(name: parts[0], value: parts[1])
                })
                if let weEndpoint = WEEndpoint(rawValue: endpointString) {
                    self.init(endpoint: weEndpoint, queryParameters: queryItems)
                    return
                }
            }
        }
        return nil
    }
}

extension WERequest {
    static let listCountriesRequest = WERequest(endpoint: .all)
}
