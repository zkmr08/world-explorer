//
//  WESearchResultViewModel.swift
//  World Explorer
//
//  Created by Zakaria Marouf on 26/09/23.
//

import Foundation

struct WESearchResultViewModel {
    let results: WESearchResultType
}

enum WESearchResultType {
    case countries([WECountryCollectionViewCellViewModel])
}
