//
//  UIView+.swift
//  Beer
//
//  Created by Milena Alcântara on 16/11/25.
//

import UIKit

extension UIView {
    public func makeRounded(_ value: CGFloat) {
        self.layer.cornerRadius = value
        self.layer.masksToBounds = true
    }
}
