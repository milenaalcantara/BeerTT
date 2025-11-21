//
//  BeerListCell.swift
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
        label.numberOfLines = 0 // Permite múltiplas linhas
        label.textAlignment = .left
        label.text = "Name"
        label.font = AppFont.title
        label.textColor = AppColor.textPrimary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.text = "Type"
        label.font = AppFont.body
        label.textColor = AppColor.textSecondary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var textStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameLabel, typeLabel])
        stack.axis = .vertical
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    } ()
    
    private lazy var contentStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [beerImage, textStack])
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

    required init?(coder: NSCoder) { fatalError() }
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
        
        setupAllConstraints()
    }
    
    private func setupAllConstraints() {
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            contentStack.topAnchor.constraint(equalTo: container.layoutMarginsGuide.topAnchor, constant: 17),
            contentStack.bottomAnchor.constraint(equalTo: container.layoutMarginsGuide.bottomAnchor, constant: -17),
            contentStack.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 8),
            contentStack.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -8),
            
            beerImage.widthAnchor.constraint(equalTo: beerImage.heightAnchor)
        ])
    }
}
