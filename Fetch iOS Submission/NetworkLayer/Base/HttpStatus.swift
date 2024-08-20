//
//  HttpStatus.swift
//  Fetch iOS Submission
//
//  Created by Kartikeya Saxena Jain on 8/18/24.
//

import Foundation

enum HttpStatus: Int {
    case ok = 200
    case restricted = 301
    case serviceRestricted = 307
    
    var isSuccessful: Bool {
        self == .ok
    }
    
    var isRestricted: Bool {
        self == .restricted || self == .serviceRestricted
    }
}

// Updated extension for HttpStatus to provide user-friendly descriptions
extension HttpStatus {
    var userFriendlyDescription: String {
        switch self {
        case .ok:
            return "OK - Request successful"
        case .restricted:
            return "Restricted - Access is restricted"
        case .serviceRestricted:
            return "Service Restricted - Access to the service is restricted"
        }
    }
}
