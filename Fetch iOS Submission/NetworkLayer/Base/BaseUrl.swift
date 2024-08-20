//
//  BaseUrl.swift
//  Fetch iOS Submission
//
//  Created by Kartikeya Saxena Jain on 8/19/24.
//

import Foundation

enum BaseUrl {
    case themealdb
    
    var host: String {
        switch self {
        case .themealdb:
            return "www.themealdb.com"
        }
    }
    
    var components: URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = self.host
        return urlComponents
    }
}
