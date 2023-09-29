//
//  WESearchViewViewModel.swift
//  World Explorer
//
//  Created by Zakaria Marouf on 25/09/23.
//

import Foundation

// Responsibilities:
// - show search results
// - show no results view
// - kick off API requests

final class WESearchViewViewModel {
    
    let config: WESearchViewController.Config
    private var optionMap: [WESearchInputViewViewModel.DynamicOption: String] = [:]
    private var searchText = ""
    
    var optionMapUpdateBlock: (((WESearchInputViewViewModel.DynamicOption, String)) -> Void)?
    
    private var searchResultHandler: ((WESearchResultViewModel) -> Void)?
    
    private var noResultsHandler: (() -> Void)?
    
    private var searchResultModel: Codable?
    
    // MARK: - Init
    
    init(config: WESearchViewController.Config) {
        self.config = config
    }
    
    // MARK: - Public
    
    public func registerSearchResultHandler(_ block: @escaping (WESearchResultViewModel) -> Void) {
        self.searchResultHandler = block
    }
    
    public func registerNoResultsHandler(_ block: @escaping () -> Void) {
        self.noResultsHandler = block
    }
    
    public func executeSearch() {
        // https://restcountries.com/v3.1/region/europe
        // https://restcountries.com/v3.1/lang/spanish
        //URLQueryItem(name: "lang", value: searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
        
        // Build arguments
        var queryParams: [URLQueryItem] = []
        var pathCompnents: [String] = []
        
        switch config.type {
        case .searchByLang:
            pathCompnents.append("lang/" + searchText)
        case .searchByRegion:
            pathCompnents.append("region/" + searchText)
        }
        
        // Create request queryParameters: queryParams
        let request = WERequest(endpoint: config.type.endpoint, pathCompnents: pathCompnents, queryParameters: queryParams)
        WEService.shared.execute(request, expecting: [WECountry].self) { [weak self] result in
            switch result {
            case .success(let model):
                print("result is:", model.count)
                // processing search results
                self?.processSearchResults(model: model)
            case .failure(_):
                print("result is failed:")
                self?.handleNoResults()
                break
            }
        }
        
        // notify view of results, no results or errors
        // Create Request based on filters
        // send api call
        // notify view of results, no results or errors
    }
    
    private func processSearchResults(model: Codable) {
        self.searchResultModel = model
        var resultsVM: WESearchResultViewModel?
        if let countryResults = model as? [WECountry] {
            resultsVM = WESearchResultViewModel(results:.countries(countryResults.compactMap({ return WECountryCollectionViewCellViewModel(countryName: $0.name, countryCapital: $0.capital, countryFlags: $0.flags) })))
            if let results = resultsVM { searchResultHandler?(results) }
        } else {
            handleNoResults()
        }
    }
    
    private func handleNoResults() {
        noResultsHandler?()
    }
    
    public func set(text: String) {
        self.searchText = text
    }
    
    public func set(value: String, for option: WESearchInputViewViewModel.DynamicOption) {
        optionMap[option] = value
        let tuple = (option, value)
        optionMapUpdateBlock?(tuple)
    }
    
    public func registerOptionChangeBlock(_ block: @escaping ((WESearchInputViewViewModel.DynamicOption, String)) -> Void) {
        self.optionMapUpdateBlock = block
    }
    
    public func countrySearchResult(at index: Int) -> WECountry? {
        guard let searchModel = searchResultModel as? [WECountry] else { return nil }
        return searchModel[index]
    }
}
