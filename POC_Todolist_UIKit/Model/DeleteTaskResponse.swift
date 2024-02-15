//
//  DeleteTaskResponse.swift
//  POC_Todolist_UIKit
//
//  Created by Jonathan Duong on 14/02/2024.
//

import Foundation

struct DeleteTaskResponse: Codable {
    let id: String
    let deleted: Bool
}
