//
//  AddTaskView.swift
//  POC_Todolist_UIKit
//
//  Created by Jonathan Duong on 14/02/2024.
//

import Foundation

protocol AddTaskView: AnyObject {
    func addTaskSuccess()
    func addTaskFailedWithError(_ message: String)
}
