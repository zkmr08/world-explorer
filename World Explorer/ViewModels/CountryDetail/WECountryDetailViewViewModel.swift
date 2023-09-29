//
//  WECountryDetailViewViewModel.swift
//  World Explorer
//
//  Created by Zakaria Marouf on 24/09/23.
//

import UIKit

final class WECountryDetailViewViewModel {
    
    private let country: WECountry
    
    enum SectionType {
        case flag(viewModel: WECountryFlagCollectionViewCellViewModel)
        case info(viewModels: [WECountryInfoCollectionViewCellViewModel])
        case borderCountries(viewModel: WECountryBordersCollectionViewCellViewModel)
    }
    
    public var sections: [SectionType] = []
    
    // MARK: - Init
    
    init(country: WECountry) {
        self.country = country
        setUpSections()
    }
    
    private func setUpSections() {
        sections = [
            .flag(viewModel: .init(imageUrl: URL(string: country.flags.png))),
            .info(viewModels: [
                .init(type: .name, value: country.name.common),
                .init(type: .nativeName, value: country.name.official),
                .init(type: .population, value: "\(country.population)"),
                .init(type: .region, value: "\(country.region)"),
                .init(type: .capital, value: country.capital?.joined(separator: ", ") ?? ""),
                .init(type: .tld, value: country.tld?.joined(separator: ", ") ?? ""),
                //.init(type: .currencies, value: String(describing: country.currencies)),
                .init(type: .languages, value: country.languages?.map { $0.1 }.joined(separator: ", ") ?? ""),
                .init(type: .timezones, value: "\(country.timezones.joined(separator: ","))"),
                //.init(type: .subregion, value: "\(country.subregion ?? "")"),
                
            ]),
            .borderCountries(viewModel: .init(name: country.borders?.joined(separator: ", ") ?? "")),
        ]
    }
    
    public var title: String {
        country.name.official
    }
    
    // MARK: - Layouts
    
    public func createFlagSectionLayout() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.3)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    public func createInfoSectionLayout() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0)))
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(150)), subitems: [item, item])
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    public func createBorderCountriesSectionLayout() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1.0)))
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 10, trailing: 5)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4), heightDimension: .absolute(150)), subitems: [item, item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
}
