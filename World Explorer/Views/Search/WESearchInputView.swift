//
//  WESearchInputView.swift
//  World Explorer
//
//  Created by Zakaria Marouf on 25/09/23.
//

import UIKit

protocol WESearchInputViewDelegate: AnyObject {
    func weSearchInputView(_ inputView: WESearchInputView, didSelectOption option: WESearchInputViewViewModel.DynamicOption)
    func weSearchInputView(_ inputView: WESearchInputView, didChangeSearchText text: String)
    func weSearchInputViewDidTapSearchKeyboardButton(_ inputView: WESearchInputView)
}

/// View for top part search screen with search bar
final class WESearchInputView: UIView {
    
    weak var delegate: WESearchInputViewDelegate?
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        //searchBar.placeholder = "Search"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private var viewModel: WESearchInputViewViewModel? {
        didSet {
            guard let viewModel = viewModel, viewModel.hasDynamicOptions else { return }
            //let options = viewModel.options
            //createOptionSelectionViews(options: options)
        }
    }
    
    private var stackView: UIStackView?
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        addSubview(searchBar)
        addConstaints()
        
        searchBar.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    private func addConstaints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: topAnchor),
            searchBar.leftAnchor.constraint(equalTo: leftAnchor),
            searchBar.rightAnchor.constraint(equalTo: rightAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 55),
        ])
    }
    
    private func createOptionStackView() -> UIStackView {
        let stackView = UIStackView()
        self.stackView = stackView
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 6
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: leftAnchor),
            stackView.rightAnchor.constraint(equalTo: rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        return stackView
    }
    
    public func createOptionSelectionViews(options: [WESearchInputViewViewModel.DynamicOption]) {
        
        let stackView = createOptionStackView()
        
        for x in 0..<options.count {
            let option = options[x]
            let button = createButton(with: option, tag: x)
            stackView.addArrangedSubview(button)
        }
    }
    
    private func createButton(with option: WESearchInputViewViewModel.DynamicOption, tag : Int) -> UIButton {
        let button = UIButton()
        
        button.setAttributedTitle(NSAttributedString(string: option.rawValue, attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .medium), .foregroundColor: UIColor.label]), for: .normal)
        
        button.backgroundColor = .secondarySystemFill
        button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        button.tag = tag
        button.layer.cornerRadius = 6
        return button
    }
    
    @objc
    private func didTapButton(_ sender: UIButton) {
        guard let options = viewModel?.options else { return }
        let tag  = sender.tag
        let selected = options[tag]
        
        delegate?.weSearchInputView(self, didSelectOption: selected)
        print("Did tap \(selected.rawValue)")
    }
    
    // MARK: - Public
    
    public func configure(with viewModel: WESearchInputViewViewModel) {
        searchBar.placeholder = viewModel.searchPlaceHolderText
        self.viewModel = viewModel
    }
    
    public func presentKeyboard() {
        searchBar.becomeFirstResponder()
    }
    
    public func update(option: WESearchInputViewViewModel.DynamicOption, value: String) {
        // Update options
        guard let buttons = stackView?.arrangedSubviews as? [UIButton], let allOptions = viewModel?.options, let index = allOptions.firstIndex(of: option) else { return }
        buttons[index].setAttributedTitle(NSAttributedString(string: value.uppercased(), attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .medium), .foregroundColor: UIColor.link]), for: .normal)
    }
    
}

// MARK: - UISearchBarDelegate

extension WESearchInputView: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Notify delegate of change text
        delegate?.weSearchInputView(self, didChangeSearchText: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Dismiss keyboard and notify that search button was tapped
        //searchBar.text = ""
        searchBar.resignFirstResponder()
        delegate?.weSearchInputViewDidTapSearchKeyboardButton(self)
    }
}
