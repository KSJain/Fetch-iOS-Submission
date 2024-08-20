//
//  APIProtocol.swift
//  Fetch iOS Submission
//
//  Created by Kartikeya Saxena Jain on 8/18/24.
//

import Foundation

protocol Api {
    var headers: [String: String] { get }
    
    var components: URLComponents { get }
    
    var method: HttpMethod { get }
    
    var baseUrl: BaseUrl { get }
    
    var path: String { get }
    
    var queryItems: [URLQueryItem]? { get }
    
    var body: Data? { get }
    
    func request(print: Bool) async throws -> (Data, StatusCode)
    
    func requestData<T: Decodable>(_ responseType: T.Type, print: Bool) async throws -> T
    
    func decodeResponse<T: Decodable>(_ responseType: T.Type, data: Data) throws -> T
}

// MARK: - Shared Functionality
extension Api {
    var sharedHeaders: [String: String] {
        ["User-Agent": "iPhone", "Authorization": "Token"]
    }
    
    var headers: [String: String] {
        var allHeaders = sharedHeaders
        if method == .POST || method == .PUT {
            allHeaders["Content-Type"] = "application/json"
        }
        return allHeaders
    }
    
    var components: URLComponents {
        var urlComponents = baseUrl.components
        urlComponents.path = path
        urlComponents.queryItems = queryItems
        return urlComponents
    }
    
    var urlRequest: URLRequest {
        guard let url = components.url else {
            fatalError(NetworkError.invalidUrl(nil).localizedDescription)
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        request.httpBody = body
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        return request
    }
    
    typealias StatusCode = Int
    
    func request(print: Bool) async throws -> (Data, StatusCode) {
        do {
            let (data, response) = try await URLSession.shared.data(for: self.urlRequest)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
            }
            
            let statusCode = httpResponse.statusCode
            
            if let httpStatus = HttpStatus(rawValue: statusCode), !httpStatus.isSuccessful {
                throw NetworkError.httpError(httpStatus)
            }
            
            if print {
                Factory.log(request: urlRequest, data: data, response: response)
            }
            
            // Success case
            return (data, statusCode)
            
        } catch let error as NetworkError {
            throw error
        } catch {
            throw NetworkError.requestFailure(error)
        }
    }
    
    func requestData<T: Decodable>(_ responseType: T.Type, print: Bool) async throws -> T {
        let (data, _) = try await request(print: print)
        return try decodeResponse(responseType, data: data)
    }
    
    func decodeResponse<T: Decodable>(_ responseType: T.Type, data: Data) throws -> T {
        do {
            return try JSONDecoder().decode(responseType, from: data)
        } catch let error {
            throw NetworkError.decodeFailed(error)
        }
    }
    
}
