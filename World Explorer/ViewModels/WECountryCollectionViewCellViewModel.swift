//
//  WECountryCollectionViewCellViewModel.swift
//  World Explorer
//
//  Created by Zakaria Marouf on 24/09/23.
//

import Foundation

final class WECountryCollectionViewCellViewModel {
    
    let countryName: Name
    let countryCapital: [String]?
    let countryFlags: Flags
    
    init(
        countryName: Name,
        countryCapital: [String]?,
        countryFlags: Flags
    ) {
        self.countryName = countryName
        self.countryCapital = countryCapital
        self.countryFlags = countryFlags
    }
    
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        // 
        guard let url = URL(string: countryFlags.png) else {
            completion(.failure(URLError(.badURL)))
            return
        }
        WEImageLoader.shared.downloadImage(url, completion: completion)
    }
}
