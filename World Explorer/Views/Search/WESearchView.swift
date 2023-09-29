//
//  WESearchView.swift
//  World Explorer
//
//  Created by Zakaria Marouf on 25/09/23.
//

import UIKit

protocol WESearchViewDelegate: AnyObject {
    func weSearchView(_ SearchView: WESearchView, didSelectOption option: WESearchInputViewViewModel.DynamicOption)
    func weSearchView(_ SearchView: WESearchView, didSelectCountry country: WECountry)
}

final class WESearchView: UIView {
    
    weak var delegate: WESearchViewDelegate?
    
    private let viewModel: WESearchViewViewModel
    
    // MARK: - Subviews
    
    private let searchInputView = WESearchInputView()
    
    private let noResultsView = WENoResultsView()
    
    private let resultsView = WESearchResultsView()
    
    // MARK: - Init
    
    init(frame: CGRect, viewModel: WESearchViewViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        backgroundColor = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(resultsView, noResultsView, searchInputView)
        addContraints()
        
        // .init = WESearchInputViewViewModel
        searchInputView.configure(with: .init(type: viewModel.config.type))
        searchInputView.delegate = self
        resultsView.delegate = self
        
        setUpHandlers(viewModel: viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setUpHandlers(viewModel: WESearchViewViewModel) {
        viewModel.registerOptionChangeBlock { tuple in
            // tuple: Option | newValue
            self.searchInputView.update(option: tuple.0, value: tuple.1)
        }
        
        viewModel.registerSearchResultHandler { [weak self] results in
            DispatchQueue.main.async {
                self?.resultsView.configure(with: results)
                self?.noResultsView.isHidden = true
                self?.resultsView.isHidden = false
            }
        }
        
        viewModel.registerNoResultsHandler { [weak self] in
            DispatchQueue.main.async {
                self?.noResultsView.isHidden = false
                self?.resultsView.isHidden = true
            }
        }
    }
    
    private func addContraints() {
        NSLayoutConstraint.activate([
            
            // Search input view
            searchInputView.topAnchor.constraint(equalTo: topAnchor),
            searchInputView.leftAnchor.constraint(equalTo: leftAnchor),
            searchInputView.rightAnchor.constraint(equalTo: rightAnchor),
            searchInputView.heightAnchor.constraint(equalToConstant: 55),
            
            resultsView.topAnchor.constraint(equalTo: searchInputView.bottomAnchor),
            resultsView.leftAnchor.constraint(equalTo: leftAnchor),
            resultsView.rightAnchor.constraint(equalTo: rightAnchor),
            resultsView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            // No results
            noResultsView.widthAnchor.constraint(equalToConstant: 150),
            noResultsView.heightAnchor.constraint(equalToConstant: 150),
            
            noResultsView.centerXAnchor.constraint(equalTo: centerXAnchor),
            noResultsView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    public func presentKeyboard() {
        searchInputView.presentKeyboard()
    }
}

// MARK: - CollectionView

extension WESearchView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

// MARK: - WESearchInputViewDelegate

extension WESearchView: WESearchInputViewDelegate {
    
    func weSearchInputView(_ inputView: WESearchInputView, didSelectOption option: WESearchInputViewViewModel.DynamicOption) {
        delegate?.weSearchView(self, didSelectOption: option)
    }
    
    func weSearchInputView(_ inputView: WESearchInputView, didChangeSearchText text: String) {
        viewModel.set(text: text)
    }
    
    func weSearchInputViewDidTapSearchKeyboardButton(_ inputView: WESearchInputView) {
        viewModel.executeSearch()
    }
}

// MARK: - WESearchInputViewDelegate

extension WESearchView: WESearchResultsViewDelegate {
    
    func weSearchResultsView(_ resultsView: WESearchResultsView, didTapCountryAt index: Int) {
        guard let countryModel = viewModel.countrySearchResult(at: index) else { return }
        delegate?.weSearchView(self, didSelectCountry: countryModel)
    }
}
