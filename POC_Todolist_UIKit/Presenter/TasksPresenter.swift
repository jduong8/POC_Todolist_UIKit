//
//  TasksPresenter.swift
//  POC_Todolist_UIKit
//
//  Created by Jonathan Duong on 13/02/2024.
//

import Foundation

class TasksPresenter {
    weak var view: TasksView?

    private let apiManager = APIManager.shared
    
    init(view: TasksView?) {
        self.view = view
    }
    
    func fetchTasks() {
        Task {
            do {
                let records: Records = try await apiManager.fetchData(model: Records.self, path: TodoServices.getAllTask.path)
                self.view?.displayTasks(records.records.compactMap { $0 })
            } catch {
                print(error)
            }
        }
    }
    
    func deleteTask(with indexPath: IndexPath, recordId: String) {
        Task {
            do {
                let _ : DeleteTaskResponse = try await apiManager.deleteData(path: TodoServices.getcurrentTask(id: recordId).path)
                self.view?.deleteTask(for: indexPath)
            } catch {
                print(error)
            }
        }
    }
}
