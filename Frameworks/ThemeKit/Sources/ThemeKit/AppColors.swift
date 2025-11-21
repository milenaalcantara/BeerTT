//
//  AppColors.swift
//  ThemeKit
//
//  Created by Milena Alcântara on 15/11/25.
//

import UIKit

public enum AppColor {
    
    private static let bundle = Bundle.module
    
    // MARK: - Brand
    
    /// Cor principal da marca (usado na Nav Bar).
    public static var brandPrimary = UIColor(named: "BrandPrimary", in: bundle, compatibleWith: nil) ?? UIColor.blue
    
    /// Cor secundária da marca (usado na Splash).
    public static var brandSecondary = UIColor(named: "BrandSecondary", in: bundle, compatibleWith: nil) ?? UIColor.blue
    
    
    // MARK: - Background
    
    /// Cor de fundo principal das telas.
    public static var background = UIColor(named: "Background", in: bundle, compatibleWith: nil) ?? UIColor.white
    
    /// Cor de fundo de componentes.
    public static var surface = UIColor(named: "Surface", in: bundle, compatibleWith: nil) ?? UIColor.gray
    
    
    // MARK: - Text
    
    /// Cor para textos primários.
    public static var textPrimary = UIColor(named: "TextPrimary", in: bundle, compatibleWith: nil) ?? UIColor.black
    
    /// Cor para textos secundários.
    public static var textSecondary = UIColor(named: "TextSecondary", in: bundle, compatibleWith: nil) ?? UIColor.black
    
    /// Cor de texto para ser usada sobre a `brandPrimary`.
    public static var textOnBrand = UIColor(named: "TextOnBrand", in: bundle, compatibleWith: nil) ?? UIColor.white
    
    public static var searchPlaceholder = UIColor(named: "TextPlaceholder", in: bundle, compatibleWith: nil) ?? UIColor.black
}
