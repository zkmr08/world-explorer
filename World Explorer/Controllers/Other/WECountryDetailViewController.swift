//
//  WECountryDetailViewController.swift
//  World Explorer
//
//  Created by Zakaria Marouf on 24/09/23.
//

import UIKit


/// Controller to show info about single country
class WECountryDetailViewController: UIViewController {
    
    private let viewModel: WECountryDetailViewViewModel
    
    private let detailView: WECountryDetailView
    
    // MARK: - Init
    
    init(viewModel: WECountryDetailViewViewModel) {
        self.viewModel = viewModel
        self.detailView = WECountryDetailView(frame: .zero, viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = viewModel.title
        view.addSubview(detailView)
        //navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapShare))
        addConstraints()
        
        detailView.collectionView?.delegate = self
        detailView.collectionView?.dataSource = self
    }
    /*
    @objc
    private func didTapShare(){
        // Share country info
    }*/
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            detailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
        ])
    }

}

// MARK: - CollectionView

extension WECountryDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = viewModel.sections[section]
        switch sectionType {
        case .flag:
            return 1
        case .info(let viewModels):
            return viewModels.count
        case .borderCountries:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let sectionType = viewModel.sections[indexPath.section]
        switch sectionType {
        case .flag(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WECountryFlagCollectionViewCell.cellIdentifier, for: indexPath) as? WECountryFlagCollectionViewCell else {
                fatalError()
            }
            cell.configure(with: viewModel)
            return cell
        case .info(let viewModels):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WECountryInfoCollectionViewCell.cellIdentifier, for: indexPath) as? WECountryInfoCollectionViewCell else {
                fatalError()
            }
            cell.configure(with: viewModels[indexPath.row])
            return cell
        case .borderCountries(let viewModel):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WECountryBordersCollectionViewCell.cellIdentifier, for: indexPath) as? WECountryBordersCollectionViewCell else {
                fatalError()
            }
            cell.configure(with: viewModel)
            return cell
        }
    }
}
