//
//  WECountryInfoCollectionViewCellViewModel.swift
//  World Explorer
//
//  Created by Zakaria Marouf on 24/09/23.
//

import Foundation

final class WECountryInfoCollectionViewCellViewModel {
    
    
    private let type: `Type`
    private let value: String
    
    public var title: String {
        type.displayTitle
    }
    
    public var displayValue: String {
        if value.isEmpty { return "None" }
        return value
    }
    
    enum `Type`: String {
        case name
        case nativeName
        case population
        case region
        case capital
        case tld
        //case currencies
        case languages
        //case borders
        //case subregion
        case timezones
        
        var displayTitle: String {
            switch self {
            case .name, .population, .capital, .region, .languages, .timezones:
                return rawValue.uppercased()
            case .nativeName:
                return "NATIVE NAME"
            case .tld:
                return "Top Level Domain"
            }
        }
    }
    
    init(type: `Type`, value: String) {
        self.value = value
        self.type = type
    }
}
