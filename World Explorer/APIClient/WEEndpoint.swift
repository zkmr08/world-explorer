//
//  WEEndpoint.swift
//  World Explorer
//
//  Created by Zakaria Marouf on 23/09/23.
//

import Foundation

/// Represents a unique API endpoint
@frozen enum WEEndpoint: String {
    /// Endpoints to get  info
    case all
    case country
    case name
    case lang
    // da vedere
    case search = ""
}
