//
//  WESearchInputViewViewModel.swift
//  World Explorer
//
//  Created by Zakaria Marouf on 25/09/23.
//

import Foundation

final class WESearchInputViewViewModel {
    
    private let type: WESearchViewController.Config.`Type`
    
    enum DynamicOption: String {
        case countryLanguage = "Country Language"
        case countryRegion = "Country Region"
        
        var queryArgument: String {
            switch self {
            case .countryLanguage: return "lang"
            case .countryRegion: return "region"
            }
        }
        
        var choices: [String] {
            switch self {
            case .countryLanguage:
                return []
            case .countryRegion:
                return ["All", "Africa", "Americas", "Asia", "Europe", "Oceania"]
            }
        }
    }
    
    init(type: WESearchViewController.Config.`Type`) {
        self.type = type
    }
    
    // MARK: - Public
    
    public var hasDynamicOptions: Bool {
        switch self.type {
        case .searchByLang:
            return false
        case .searchByRegion:
            return false
        }
    }
    
    public var options: [DynamicOption] {
        switch self.type {
        case .searchByLang:
            return []
        case .searchByRegion:
            return []
        }
    }
    
    public var searchPlaceHolderText: String {
        switch self.type {
        case .searchByLang:
            return "Language Name"
        case .searchByRegion:
            return "Region Name"
        }
    }
}
