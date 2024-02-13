//
//  APIManager.swift
//  POC_Todolist_UIKit
//
//  Created by Jonathan Duong on 13/02/2024.
//

import Foundation

class APIManager {
    
    static let shared = APIManager()
    
    private init() { }
    
    func fetchData<T: Decodable>(model: T.Type, path: String) async throws -> T {
        guard let url = URL(string: APIConstants.baseURL + path) else {
            throw APIError.invalidPath
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethod.get.rawValue
        urlRequest.setValue(APIConstants.token, forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw APIError.decoding
        }
        let decoder = JSONDecoder()
        let decoded = try decoder.decode(T.self, from: data)
        
        return decoded
    }

    @discardableResult
    func postData<T: Codable>(requestBody: T, path: String = "") async throws -> T {
        guard let url = URL(string: APIConstants.baseURL + path) else {
            throw APIError.invalidPath
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethod.post.rawValue
        urlRequest.setValue(APIConstants.token, forHTTPHeaderField: "Authorization")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let encoder = JSONEncoder()
        do {
            let requestData = try encoder.encode(requestBody)
            urlRequest.httpBody = requestData
        } catch {
            throw APIError.encoding
        }

        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw APIError.invalidResponse(statusCode: (response as? HTTPURLResponse)?.statusCode ?? 0)
        }

        let decoder = JSONDecoder()
        do {
            let decodedResponse = try decoder.decode(T.self, from: data)
            return decodedResponse
        } catch {
            throw APIError.decoding
        }
    }

    @discardableResult
    func putData<T: Codable>(requestBody: T, path: String) async throws -> T {
        guard let url = URL(string: APIConstants.baseURL + path) else {
            throw APIError.invalidPath
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethod.put.rawValue
        urlRequest.setValue(APIConstants.token, forHTTPHeaderField: "Authorization")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let encoder = JSONEncoder()
        do {
            let requestData = try encoder.encode(requestBody)
            urlRequest.httpBody = requestData
        } catch {
            throw APIError.encoding
        }

        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw APIError.invalidResponse(statusCode: (response as? HTTPURLResponse)?.statusCode ?? 0)
        }

        let decoder = JSONDecoder()
        do {
            let decodedResponse = try decoder.decode(T.self, from: data)
            return decodedResponse
        } catch {
            throw APIError.decoding
        }
    }

    @discardableResult
    func deleteData<T: Decodable>(path: String) async throws -> T {
        guard let url = URL(string: APIConstants.baseURL + path) else {
            throw APIError.invalidPath
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethod.delete.rawValue
        urlRequest.setValue(APIConstants.token, forHTTPHeaderField: "Authorization")

        let (data, response) = try await URLSession.shared.data(for: urlRequest)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw APIError.invalidResponse(statusCode: (response as? HTTPURLResponse)?.statusCode ?? 0)
        }

        let decoder = JSONDecoder()
        do {
            let decodedResponse = try decoder.decode(T.self, from: data)
            return decodedResponse
        } catch {
            throw APIError.decoding
        }
    }
}
