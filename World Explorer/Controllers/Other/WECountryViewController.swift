//
//  ViewController.swift
//  World Explorer
//
//  Created by Zakaria Marouf on 23/09/23.
//

import UIKit

/// Controller to show and search for Countries
final class WECountryViewController: UIViewController {
    
    private let countryListView = WECountryListView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Countries"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        //navigationItem.largeTitleDisplayMode = .never
        setUpView()
        //addSearchButton()
    }
    
    private func addSearchButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))
    }
    
    @objc private func didTapSearch() {
        let vc = WESearchViewController(config: WESearchViewController.Config(type: .searchByLang))
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setUpView() {
        countryListView.delegate = self
        view.addSubview(countryListView)
        NSLayoutConstraint.activate([
            countryListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            countryListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            countryListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            countryListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
        ])
    }

}

// MARK: - WECountryListViewDelegate

extension WECountryViewController: WECountryListViewDelegate {
    
    func weCountryListView(_ countryListView: WECountryListView, didSelectCountry country: WECountry) {
        let viewModel = WECountryDetailViewViewModel(country: country)
        let detailVC = WECountryDetailViewController(viewModel: viewModel)
        //let navVC = UINavigationController(rootViewController: detailVC)
        detailVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
