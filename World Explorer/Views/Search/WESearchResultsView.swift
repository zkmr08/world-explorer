//
//  WESearchResultsView.swift
//  World Explorer
//
//  Created by Zakaria Marouf on 26/09/23.
//

import UIKit

protocol WESearchResultsViewDelegate: AnyObject {
    func weSearchResultsView(_ resultsView: WESearchResultsView, didTapCountryAt index: Int)
}

/// shows search results UI (collectionView)
final class WESearchResultsView: UIView {
    
    weak var delegate: WESearchResultsViewDelegate?
    
    private var viewModel: WESearchResultViewModel? {
        didSet {
            self.processViewModel()
        }
    }
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isHidden = true
        //collectionView.alpha = 0
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(WECountryCollectionViewCell.self, forCellWithReuseIdentifier: WECountryCollectionViewCell.cellIdentifier)
        return collectionView
    }()
    
    private var collectionViewCellViewModels: [WECountryCollectionViewCellViewModel] = []
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isHidden = true
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .red
        addSubview(collectionView)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func processViewModel() {
        guard let viewModel = viewModel else { return }
        switch viewModel.results {
        case .countries(let viewModels):
            self.collectionViewCellViewModels = viewModels
            setUpCollectionView()
        }
    }
    
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
        ])
    }
    
    private func setUpCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isHidden = false
        //collectionView.backgroundColor = .systemMint
        collectionView.reloadData()
    }
    
    public func configure(with viewModel: WESearchResultViewModel) {
        self.viewModel = viewModel
    }
    
}

// MARK: - CollectionView

extension WESearchResultsView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewCellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WECountryCollectionViewCell.cellIdentifier, for: indexPath) as? WECountryCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        cell.configure(with: collectionViewCellViewModels[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handling cell tap
        collectionView.deselectItem(at: indexPath, animated: true)
        guard let viewModel = viewModel else { return }
        switch viewModel.results {
        case .countries:
            delegate?.weSearchResultsView(self, didTapCountryAt: indexPath.row)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //return .zero
        let bounds = UIScreen.main.bounds
        let width = (bounds.width-30)/2
        return CGSize(width: width, height: width)
    }
    
}
