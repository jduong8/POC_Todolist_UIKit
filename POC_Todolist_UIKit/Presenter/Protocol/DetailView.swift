//
//  DetailView.swift
//  POC_Todolist_UIKit
//
//  Created by Jonathan Duong on 15/02/2024.
//

import Foundation

protocol DetailView: AnyObject {
    func updateTask(for record: Record)
}
