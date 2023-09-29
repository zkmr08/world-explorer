//
//  CountryListViewViewModel.swift
//  World Explorer
//
//  Created by Zakaria Marouf on 24/09/23.
//

import UIKit

protocol WECountryListViewModelDelegate: AnyObject {
    func didLoadInitialCharacters()
    func didSelectCountry(_ country: WECountry)
}

/// View Model to handle character list view logic
final class WECountryListViewViewModel: NSObject {
    
    public weak var delegate: WECountryListViewModelDelegate?
    
    var countries: [WECountry] = [] {
        didSet {
            for country in countries {
                // just in case i have to change this
                let viewModel = WECountryCollectionViewCellViewModel(countryName: country.name, countryCapital: country.capital, countryFlags: country.flags)
                cellViewModels.append(viewModel)
            }
        }
    }
    
    private var cellViewModels: [WECountryCollectionViewCellViewModel] = []
    
    ///  Fetch initial set of countries
    public func fetchCountries() {
        
        WEService.shared.execute(.listCountriesRequest, expecting: [WECountry].self) { [weak self] result in
            switch result {
            case .success(let responseModel):
                self?.countries = responseModel
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialCharacters()
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    public var shouldShowLoadMoreIndicator: Bool {
        return false
    }
}

// MARK: CollectionView

extension WECountryListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WECountryCollectionViewCell.cellIdentifier, for: indexPath) as? WECountryCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        cell.configure(with: cellViewModels[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width-30)/2
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let country = countries[indexPath.row]
        delegate?.didSelectCountry(country)
    }
}
