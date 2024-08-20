//
//  String+EXT.swift
//  Fetch iOS Submission
//
//  Created by Kartikeya Saxena Jain on 8/19/24.
//

import Foundation

extension String {
    func urlFormatted() -> String {
        self
            .lowercased()
            .components(separatedBy: " ")
            .joined(separator: "%20")
    }
}
