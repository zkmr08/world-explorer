//
//  WECountryFlagCollectionViewCellViewModel.swift
//  World Explorer
//
//  Created by Zakaria Marouf on 24/09/23.
//

import Foundation

final class WECountryFlagCollectionViewCellViewModel {
    
    private let imageUrl: URL?
    
    init(imageUrl: URL?) {
        self.imageUrl = imageUrl
    }
    
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let imageUrl = imageUrl else {
            completion(.failure(URLError(.badURL)))
            return
        }
        WEImageLoader.shared.downloadImage(imageUrl, completion: completion)
    }
}
