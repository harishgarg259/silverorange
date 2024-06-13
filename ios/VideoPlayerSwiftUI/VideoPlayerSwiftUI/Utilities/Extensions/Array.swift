//
//  Array.swift
//  VideoPlayerSwiftUI
//
//  Created by Harish Garg on 12/06/24.
//

import Foundation

extension Array {
    public subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
