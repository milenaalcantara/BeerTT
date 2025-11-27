//
//  AppColors.swift
//  ThemeKit
//
//  Created by Milena Alcântara on 15/11/25.
//

import UIKit

public enum AppColor {
    
    // MARK: - Helpers Privados
    private static func dynamicColor(light: UIColor, dark: UIColor) -> UIColor {
        return UIColor { traitCollection in
            switch traitCollection.userInterfaceStyle {
            case .dark:
                return dark
            default:
                return light
            }
        }
    }
    
    // MARK: - Brand
    
    /// Cor principal da marca.
    public static var brand: UIColor = dynamicColor(
        light: UIColor(red: 74, green: 144, blue: 226),
        dark:  UIColor(red: 40, green: 79, blue: 124)
    )
    
    // MARK: - Background
    
    public static var background: UIColor = dynamicColor(
        light: UIColor(red: 255, green: 255, blue: 255),
        dark:  UIColor(red: 15, green: 23, blue: 42)
    )
    
    public static var surface: UIColor = dynamicColor(
        light: UIColor(red: 246, green: 246, blue: 246),
        dark:  UIColor(red: 30, green: 41, blue: 59)
    )
    
    // MARK: - Text
    
    public static var textPrimary: UIColor = dynamicColor(
        light: UIColor(red: 102, green: 102, blue: 102),
        dark:  UIColor(red: 226, green: 232, blue: 240)
    )
    
    public static var textSecondary: UIColor = dynamicColor(
        light: UIColor(red: 177, green: 177, blue: 177),
        dark:  UIColor(red: 148, green: 163, blue: 184)
    )
    
    public static var textOnBrand: UIColor = dynamicColor(
        light: UIColor(red: 255, green: 255, blue: 255),
        dark:  UIColor(red: 255, green: 255, blue: 255)
    )
    
    public static var searchPlaceholder: UIColor = dynamicColor(
        light: UIColor(red: 102, green: 102, blue: 102),
        dark:  UIColor(red: 102, green: 102, blue: 102)
    )
}
