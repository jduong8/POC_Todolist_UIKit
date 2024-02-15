//
//  AddTaskViewController.swift
//  POC_Todolist_UIKit
//
//  Created by Jonathan Duong on 14/02/2024.
//

import Foundation
import UIKit

class AddTaskViewController: UIViewController {
    
    private let presenter = AddTaskPresenter()

    private let toDoTextField = UITextField()
    private let prioritySegmentedControl = UISegmentedControl(items: Field.Priority.allValues())
    private let deadlineDatePicker = UIDatePicker()

    var record: Record?
    var onTaskAdded: (() -> Void)?
    var onRecordUpdated: ((Record) -> Void)?
    var viewState: ViewState = .addView

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
        setupViewState()
        setupLayout()
    }

    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTask))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissView))
    }

    private func setupViewState() {
        switch viewState {
        case .addView:
            setupAddViewUI()
        case .editView(let record):
            self.record = record
            setupUIForEditing(for: record)
        }
    }

    private func setupLayout() {
        let stackView = UIStackView(arrangedSubviews: [toDoTextField, prioritySegmentedControl, deadlineDatePicker])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    @objc private func dismissView() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - Setup for editView state
extension AddTaskViewController {
    private func setupUIForEditing(for record: Record) {
        setupTextFieldToEdit(for: record)
        setupPrioritySegmentedControlToEdit(for: record)
        setupDeadlineDatePickerToEdit(for: record)
    }
    private func setupTextFieldToEdit(for record: Record) {
        toDoTextField.borderStyle = .roundedRect
        toDoTextField.text = record.fields.toDo
    }
    private func setupPrioritySegmentedControlToEdit(for record: Record) {
        prioritySegmentedControl.selectedSegmentIndex = record.fields.priority.index
    }
    private func setupDeadlineDatePickerToEdit(for record: Record) {
        deadlineDatePicker.preferredDatePickerStyle = .inline
        deadlineDatePicker.datePickerMode = .date
        if let deadlineDate = record.fields.deadline.dateFromString() {
            deadlineDatePicker.date = deadlineDate
        }
    }
}

// MARK: - Setup for addView state
extension AddTaskViewController {
    private func setupAddViewUI() {
        setupToDoTextField()
        setupPrioritySegmentedControl()
        setupDeadlineDatePicker()
    }

    private func setupToDoTextField() {
        toDoTextField.borderStyle = .roundedRect
        toDoTextField.placeholder = "Enter task"
    }

    private func setupPrioritySegmentedControl() {
        prioritySegmentedControl.selectedSegmentIndex = 1 // Default to Medium
    }

    private func setupDeadlineDatePicker() {
        deadlineDatePicker.preferredDatePickerStyle = .inline
        deadlineDatePicker.datePickerMode = .date
    }

    @objc func saveTask() {
        guard let toDoText = toDoTextField.text, !toDoText.isEmpty else {
            showAlert(message: "Veuillez entrer un titre pour la tâche.", isSuccess: false)
            return
        }

        let selectedPriorityIndex = prioritySegmentedControl.selectedSegmentIndex
        let priority = Field.Priority.allCases[selectedPriorityIndex]
        let deadlineDate = deadlineDatePicker.date

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let deadlineString = dateFormatter.string(from: deadlineDate)

        let newField = Field(priority: priority, deadline: deadlineString, toDo: toDoText)
        let updatedRecord = Record(id: self.record?.id, createdAt: self.record?.createdAt, fields: newField)
        switch viewState {
        case .addView:
            presenter.addTask(newField)
        case .editView(_):
            onRecordUpdated?(updatedRecord)
        }
        addTaskSuccess()
    }
}

extension AddTaskViewController: AddTaskView {
    func addTaskSuccess() {
        showAlert(message: viewState == .addView ? "Tâche ajoutée avec succès!" : "Mise à jour effectuée", isSuccess: true)
    }
    
    func addTaskFailedWithError(_ message: String) {
        showAlert(message: message, isSuccess: false)
    }
    
    private func showAlert(message: String, isSuccess: Bool) {
        let alert = UIAlertController(title: isSuccess ? "Succès" : "Erreur", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            if isSuccess {
                DispatchQueue.main.async {
                    self.dismiss(animated: true) {
                        self.onTaskAdded?()
                    }
                }
            }
        })
        self.present(alert, animated: true)
    }
}
