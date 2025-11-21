//
//  BeerCell.swift
//  Beer
//
//  Created by Milena Alcântara on 16/11/25.
//

import UIKit
import ThemeKit

final class BeerCell: UITableViewCell {
    static let identifier = "BeerCell"
    
    private let container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.backgroundColor = AppColor.surface
        return view
    }()

    private lazy var beerImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "beer_default")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Name"
        label.font = AppFont.title
        label.textColor = AppColor.textPrimary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Type"
        label.font = AppFont.body
        label.textColor = AppColor.textSecondary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var chevronIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = AppColor.textSecondary
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var textStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameLabel, typeLabel])
        stack.axis = .vertical
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    } ()
    
    private lazy var contentStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [beerImage, textStack, chevronIcon])
        stack.axis = .horizontal
        stack.spacing = 12
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    } ()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension BeerCell {
    func configure(with viewModel: BeerCellViewModel) {
        beerImage.image = UIImage(named: viewModel.imageName)
        nameLabel.text = viewModel.name
        typeLabel.text = viewModel.type
    }
}

extension BeerCell {
    private func setupCell() {
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(container)
        container.addSubview(contentStack)
        
        beerImage.setContentHuggingPriority(.required, for: .horizontal)
        beerImage.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        chevronIcon.setContentHuggingPriority(.required, for: .horizontal)
        chevronIcon.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        textStack.setContentHuggingPriority(.defaultLow, for: .horizontal)
        textStack.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        setupAllConstraints()
    }
    
    private func setupAllConstraints() {
        setupContainerConstraints()
        setupContentStackConstraints()
        setupBeerImageConstraints()
        setupChevronIconConstraints()
    }
}

extension BeerCell {
    func setupContainerConstraints() {
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    
    func setupContentStackConstraints() {
        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(equalTo: container.topAnchor, constant: 8),
            contentStack.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -8),
            contentStack.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 8),
            contentStack.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -8)
        ])
    }
    
    func setupBeerImageConstraints() {
        NSLayoutConstraint.activate([
            beerImage.widthAnchor.constraint(equalToConstant: 60),
            beerImage.heightAnchor.constraint(equalToConstant: 60),
            beerImage.topAnchor.constraint(equalTo: contentStack.topAnchor, constant: 8),
            beerImage.bottomAnchor.constraint(equalTo: contentStack.bottomAnchor, constant: -8)
        ])
    }
    
    func setupChevronIconConstraints() {
        NSLayoutConstraint.activate([
            chevronIcon.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            chevronIcon.widthAnchor.constraint(equalToConstant: 12),
            chevronIcon.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
