//
//  TasksView.swift
//  POC_Todolist_UIKit
//
//  Created by Jonathan Duong on 13/02/2024.
//

import Foundation

protocol TasksView: AnyObject {
    func displayTasks(_ records: [Record])
    func deleteTask(for indexPath: IndexPath)
}
