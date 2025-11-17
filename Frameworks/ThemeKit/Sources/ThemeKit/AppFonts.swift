//
//  AppFonts.swift
//  ThemeKit
//
//  Created by Milena Alcântara on 16/11/25.
//

import UIKit
import CoreGraphics // Importa para o registro da fonte

/// Define o catálogo de fontes da aplicação.
/// Centraliza a tipografia para garantir consistência.
public enum AppFont {
    // MARK: - Registro de Fontes
    public static func registerFonts() {
        ["MyFont-Regular", "MyFont-Bold"].forEach { font in
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

    // MARK: - Nomes de Fontes (PostScript)
    
    private enum FontName {
        static let bold = "Montserrat-Bold"
        static let semibold = "Montserrat-SemiBold"
        static let medium = "Montserrat-Medium"
    }

    // MARK: - Estilos de Fonte (Design System)
    public static let titleLarge = UIFont(name: FontName.bold, size: 22)!
    
    public static let titleMedium = UIFont(name: FontName.medium, size: 18)!
    
    public static let body = UIFont(name: FontName.regular, size: 16)!
    
    public static let caption = UIFont(name: FontName.regular, size: 14)!
    
    public static let button = UIFont(name: FontName.medium, size: 16)!
}
