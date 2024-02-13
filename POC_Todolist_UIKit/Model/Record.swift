//
//  Record.swift
//  POC_Todolist_UIKit
//
//  Created by Jonathan Duong on 13/02/2024.
//

import Foundation

struct Record: Identifiable {
    var id: String?
    var createdAt: String?
    var fields: Field
}

extension Record: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "createdTime"
        case fields
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.createdAt = try container.decodeIfPresent(String.self, forKey: .createdAt)
        self.fields = try container.decode(Field.self, forKey: .fields)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(self.fields, forKey: .fields)
    }
}

extension Record: Equatable { }
