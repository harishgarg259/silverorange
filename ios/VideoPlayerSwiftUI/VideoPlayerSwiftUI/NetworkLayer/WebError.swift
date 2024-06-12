//
//  WebError.swift
//  VideoPlayerSwiftUI
//
//  Created by Harish Garg on 12/06/24.
//

import Foundation

public enum WebError: Error {
    
    case networkLost
    case timeout
    case invalidRequest(String)
    case parse
    case unauthorized
    case other(String)
}

extension WebError {
    
    var description: String {
        switch self {
        case .timeout:
            return "The request timed out."
        case .invalidRequest(let url):
            return "URLRequest is not valid: \(url)"
        case .unauthorized:
            return "Invalid credentials. Please check your username or password"
        case .parse:
            return "Unable to parse json"
        case .other(let error):
            return error
        case .networkLost:
            return "No Internet Connection."
        }
    }
}
