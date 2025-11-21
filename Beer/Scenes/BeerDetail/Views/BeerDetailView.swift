//
//  BeerDetailView.swift
//  Beer
//
//  Created by Milena Alcântara on 21/11/25.
//

import UIKit
import ThemeKit

final class BeerDetailView: UIView {
    private(set) lazy var beerImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.largeTitle
        label.textColor = AppColor.textPrimary
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.subtitle
        label.textColor = AppColor.textPrimary
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.body
        label.textColor = AppColor.textSecondary
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) não foi implementado")
    }
}

extension BeerDetailView {
    func configure(with viewModel: BeerDetailModel.ViewModel) {
        titleLabel.text = viewModel.title
        typeLabel.text = viewModel.subtitle
        descriptionLabel.text = viewModel.description
        beerImage.image = UIImage(named: viewModel.imageName)
    }
}

extension BeerDetailView {
    private func setupView() {
        backgroundColor = AppColor.background
        
        addSubview(beerImage)
        addSubview(titleLabel)
        addSubview(typeLabel)
        addSubview(descriptionLabel)
        
        setupAllConstraints()
    }
    
    
    private func setupAllConstraints() {
        setupBeerImageConstraints()
        setupNameLabelConstraints()
        setupTypeLabelConstraints()
        setupDescriptionLabelConstraints()
    }
    
    func setupBeerImageConstraints() {
        NSLayoutConstraint.activate([
            beerImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1),
            beerImage.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1),
            beerImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            beerImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        ])
    }
    
    func setupNameLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: beerImage.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: beerImage.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
    
    func setupTypeLabelConstraints() {
        NSLayoutConstraint.activate([
            typeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            typeLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            typeLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
        ])
    }
    
    func setupDescriptionLabelConstraints() {
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: beerImage.bottomAnchor, constant: 33),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
}
