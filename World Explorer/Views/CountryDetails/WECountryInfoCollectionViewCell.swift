//
//  WECountryInfoCollectionViewCell.swift
//  World Explorer
//
//  Created by Zakaria Marouf on 24/09/23.
//

import UIKit

final class WECountryInfoCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "WECountryInfoCollectionViewCell"
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Earth"
        label.font = .systemFont(ofSize: 20, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        label.text = "Earth 01"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let titleContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondarySystemBackground
        return view
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .tertiarySystemBackground
        contentView.layer.cornerRadius = 8
        contentView.addSubviews(titleContainerView, valueLabel)
        titleContainerView.addSubview(titleLabel)
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            
            titleContainerView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            titleContainerView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            titleContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleContainerView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.33),
            
            titleLabel.bottomAnchor.constraint(equalTo: titleContainerView.bottomAnchor),
            titleLabel.rightAnchor.constraint(equalTo: titleContainerView.rightAnchor),
            titleLabel.leftAnchor.constraint(equalTo: titleContainerView.leftAnchor),
            titleLabel.topAnchor.constraint(equalTo: titleContainerView.topAnchor),
            
            valueLabel.bottomAnchor.constraint(equalTo: titleContainerView.topAnchor),
            valueLabel.rightAnchor.constraint(equalTo: titleContainerView.rightAnchor),
            valueLabel.leftAnchor.constraint(equalTo: titleContainerView.leftAnchor),
            valueLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        //titleLabel.text = nil
        //valueLabel.text = nil
    }
    
    public func configure(with viewModel: WECountryInfoCollectionViewCellViewModel) {
        titleLabel.text = viewModel.title
        valueLabel.text = viewModel.displayValue
    }
}
