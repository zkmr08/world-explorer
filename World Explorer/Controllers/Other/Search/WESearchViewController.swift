//
//  WESearchViewController.swift
//  World Explorer
//
//  Created by Zakaria Marouf on 25/09/23.
//

import UIKit

// Dynamic search option view
// Render results
// Render no results zero state
// Searching / API call

/// Configurable controller to search
final class WESearchViewController: UIViewController {
    
    /// Configuration for the search session
    struct Config {
        enum `Type` {
            case searchByLang // https://restcountries.com/v3.1/lang/spanish
            case searchByRegion // https://restcountries.com/v3.1/region/europe
            
            var endpoint: WEEndpoint {
                switch self {
                case .searchByLang: return .search
                case .searchByRegion: return .search
                }
            }
            /*
            var title: String {
                switch self {
                case .searchByLang: return "Search by Language"
                case .searchByRegion: return "Search by Region"
                }
            }*/
        }
        
        let type: `Type`
        
    }
    
    private let viewModel: WESearchViewViewModel
    private let searchView: WESearchView
    
    // MARK: - Init
    
    init(config: Config) {
        let viewModel = WESearchViewViewModel(config: config)
        self.viewModel = viewModel
        self.searchView = WESearchView(frame: .zero, viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        //title = viewModel.config.type.title
        view.backgroundColor = .systemBackground
        view.addSubviews(searchView)
        addContraints()
        //navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Search", style: .done, target: self, action: #selector(didTapSearch))
        //navigationItem.rightBarButtonItem?.isHidden = true
        searchView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchView.presentKeyboard()
    }
    /*
    @objc
    private func didTapSearch() {
        //navigationItem.rightBarButtonItem?.isHidden = true
        viewModel.executeSearch()
    }*/
    
    private func addContraints() {
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            searchView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            searchView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor),
        ])
    }

}

// MARK: - WESearchViewDelegate
extension WESearchViewController: WESearchViewDelegate {
    
    func weSearchView(_ SearchView: WESearchView, didSelectOption option: WESearchInputViewViewModel.DynamicOption) {
        print("should present option picker")
        let vc = WESearchOptionPickerViewController(option: option) { [weak self] selection in
            DispatchQueue.main.async {
                self?.viewModel.set(value: selection, for: option)
                //self?.viewModel.set(query: "")
            }
        }
        vc.sheetPresentationController?.detents = [.medium()]
        vc.sheetPresentationController?.prefersGrabberVisible = true
        navigationItem.rightBarButtonItem?.isHidden = false
        present(vc, animated: true)
    }
    
    func weSearchView(_ SearchView: WESearchView, didSelectCountry country: WECountry) {
        let vc = WECountryDetailViewController(viewModel: .init(country: country))
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
}
