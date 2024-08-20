//
//  Factory.swift
//  Fetch iOS Submission
//
//  Created by Kartikeya Saxena Jain on 8/18/24.
//

import Foundation

class Factory {
    static func prettyPrintData(_ data: Data) {
        do {
            guard !data.isEmpty else { return }
            let jsonObject = try JSONSerialization.jsonObject(with: data)
            let jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print(jsonString)
            } else {
                print("Unable to convert data to UTF-8 string")
            }
        } catch {
            print("Failed to pretty print data: \(error)")
        }
    }
    
    static func log(request: URLRequest, data: Data, response: URLResponse) {
        Factory.prettyPrintData(data)
    }
}
