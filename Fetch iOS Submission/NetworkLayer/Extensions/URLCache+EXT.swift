//
//  URLCache+EXT.swift
//  Fetch iOS Submission
//
//  Created by Kartikeya Saxena Jain on 8/20/24.
//

import Foundation

extension URLCache {
    static let imageCache = URLCache(
        memoryCapacity: 512*1000*1000,
        diskCapacity: 10*1000*1000*1000
    )
}
