//
//  Array+.swift
//  Beer
//
//  Created by Milena Alcântara on 20/11/25.
//

extension Array {
    subscript(safe index: Int) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
