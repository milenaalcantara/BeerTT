//
//  BeerListCell.swift
//  Beer
//
//  Created by Milena Alcântara on 16/11/25.
//

import UIKit
import ThemeKit

class ProductListCell: UITableViewCell {
    static let reuseIdentifier = "BeerListCell"
    
    private lazy var productImage: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(systemName: "beer.fill")
        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.makeRounded(10)
        return imageView
    }()
    
    private lazy var productTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.text = "Default Title"
        label.textColor = AppColor.textPrimary
        return label
    }()
    
    
    
    
    
    
}
