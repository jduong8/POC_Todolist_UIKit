//
//  Field.swift
//  POC_Todolist_UIKit
//
//  Created by Jonathan Duong on 13/02/2024.
//

import Foundation

struct Field {
    let priority: Priority
    var done: Bool?
    let deadline: String
    let toDo: String
}

extension Field {
    enum Priority: String, CaseIterable, Codable {
        case low = "Low"
        case medium = "Medium"
        case high = "High"
        
        static func allValues() -> [String] {
            return [low, medium, high].map { $0.rawValue }
        }
        
        var index: Int {
            switch self {
            case .low:
                return 0
            case .medium:
                return 1
            case .high:
                return 2
            }
        }
    }
}

extension Field: Codable {
    enum CodingKeys: String, CodingKey {
        case priority = "Priority"
        case done = "Done"
        case deadline = "To do before"
        case toDo = "Task"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.priority = try container.decode(Priority.self, forKey: .priority)
        self.done = try container.decodeIfPresent(Bool.self, forKey: .done)
        self.deadline = try container.decode(String.self, forKey: .deadline)
        self.toDo = try container.decode(String.self, forKey: .toDo)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(self.priority, forKey: .priority)
        try container.encode(self.done, forKey: .done)
        try container.encode(self.deadline, forKey: .deadline)
        try container.encode(self.toDo, forKey: .toDo)
    }
}

extension Field: Equatable { }
