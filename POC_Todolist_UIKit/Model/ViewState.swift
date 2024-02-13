//
//  ViewState.swift
//  POC_Todolist_UIKit
//
//  Created by Jonathan Duong on 15/02/2024.
//

import Foundation

enum ViewState: Equatable {
    case addView
    case editView(Record)
}
