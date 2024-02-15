//
//  AddTaskPresenter.swift
//  POC_Todolist_UIKit
//
//  Created by Jonathan Duong on 14/02/2024.
//

import Foundation

class AddTaskPresenter {
    weak var view: AddTaskView?
    private let apiManager = APIManager.shared
    
    func addTask(_ field: Field) {
        Task {
            do {
                let requestBody = Record(fields: field)

                try await apiManager.postData(
                    requestBody: requestBody
                )

                DispatchQueue.main.async { [weak self] in
                    self?.view?.addTaskSuccess()
                }
            } catch {
                DispatchQueue.main.async { [weak self] in
                    self?.view?.addTaskFailedWithError("Une erreur est survenue lors de l'ajout de la tâche.")
                }
            }
        }
    }
}
