//
//  TodoServices.swift
//  POC_Todolist_UIKit
//
//  Created by Jonathan Duong on 13/02/2024.
//

import Foundation

enum TodoServices {
    case getcurrentTask(id: String)
    case getAllTask
    case updateTask(id: String)
    
    var path: String {
        switch self {
        case let .getcurrentTask(id):
            return "/\(id)"
        case .getAllTask:
            return "?view=Grid%20view"
        case let .updateTask(id):
            return "/\(id)"
        }
    }
}
