//
//  WECountryBorderCountriesCollectionViewCell.swift
//  World Explorer
//
//  Created by Zakaria Marouf on 24/09/23.
//

import UIKit

final class WECountryBordersCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "WECountryBordersCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemMint
        contentView.layer.cornerRadius = 8
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setUpConstraints() {
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    public func configure(with viewModel: WECountryBordersCollectionViewCellViewModel) {
        
    }
}
