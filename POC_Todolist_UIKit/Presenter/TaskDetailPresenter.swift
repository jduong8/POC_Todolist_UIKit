//
//  TaskDetailPresenter.swift
//  POC_Todolist_UIKit
//
//  Created by Jonathan Duong on 15/02/2024.
//

import Foundation

class TaskDetailPresenter {
    weak var view: DetailView?
    private let apiManager = APIManager.shared
    var didUpdateStatus: (() -> Void)?

    init(view: DetailView?) {
        self.view = view
    }

    func updateTask(for record: Record) {
        Task {
            do {
                guard let id = record.id else { return }
                let record: Record = try await apiManager.putData(requestBody: record, path: TodoServices.updateTask(id: id).path)
                DispatchQueue.main.async {
                    self.view?.updateTask(for: record)
                    self.didUpdateStatus?() // Me sert pour revenir à la vue parente.
                }
            } catch {
                print(error)
            }
        }
    }
}
