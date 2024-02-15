//
//  APIError.swift
//  POC_Todolist_UIKit
//
//  Created by Jonathan Duong on 13/02/2024.
//

import Foundation

enum APIError: Error {
    case invalidPath
    case decoding
    case encoding
    case invalidResponse(statusCode: Int)
}
