//
//  AppFonts.swift
//  ThemeKit
//
//  Created by Milena Alcântara on 16/11/25.
//

import UIKit
import CoreGraphics


public enum AppFont {
    // MARK: - Nomes de Fontes (PostScript)
    
    private enum FontName {
        static let bold = "Montserrat-Bold"
        static let semibold = "Montserrat-SemiBold"
        static let medium = "Montserrat-Medium"
    }
    
    // MARK: - Registro de Fontes
    public static func registerFonts() {
        [FontName.bold, FontName.semibold, FontName.medium].forEach { font in
            registerFont(bundle: .module, fontName: font, fontExtension: "ttf")
        }
    }

    private static func registerFont(bundle: Bundle, fontName: String, fontExtension: String) {
        guard let url = bundle.url(forResource: fontName, withExtension: fontExtension),
              let dataProvider = CGDataProvider(url: url as CFURL),
              let font = CGFont(dataProvider)
        else { return }

        CTFontManagerRegisterGraphicsFont(font, nil)
    }

    // MARK: - Estilos de Fonte (Design System)
    public static let largeTitle = UIFont(name: FontName.bold, size: 24)
    
    public static let title = UIFont(name: FontName.bold, size: 22)
    
    public static let subtitle = UIFont(name: FontName.semibold, size: 12)
    
    public static let body = UIFont(name: FontName.medium, size: 14)
}
