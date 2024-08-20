//
//  NetworkError.swift
//  Fetch iOS Submission
//
//  Created by Kartikeya Saxena Jain on 8/18/24.
//

import Foundation

enum NetworkError: Error {
    case invalidResponse
    case requestFailure(Error)
    case invalidUrl(_ url: URL?)
    case decodeFailed(_ err: Error)
    case httpError(HttpStatus)
    
    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "Invalid response received from the server"
        case .requestFailure(let error):
            return "Request failed with error: \(error.localizedDescription)"
        case .invalidUrl(let url):
            return "Invalid Url: \(url?.absoluteString ?? "Empty")"
        case .decodeFailed(let err):
            return "Failed to decode response: \(err.localizedDescription)"
        case .httpError(let status):
            return "HTTP Error: \(status.userFriendlyDescription)"
        }
    }
}
