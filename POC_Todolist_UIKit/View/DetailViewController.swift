//
//  DetailViewController.swift
//  POC_Todolist_UIKit
//
//  Created by Jonathan Duong on 13/02/2024.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {

    var record: Record?
    lazy var presenter = TaskDetailPresenter(view: self)
    var onRecordUpdated: ((Record) -> Void)?

    private let createdLabel = UILabel()
    private let priorityLabel = UILabel()
    private let deadlineLabel = UILabel()
    private let todoLabel = UILabel()
    private let markAsDone = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBarItem()
        setupUI()
        configureMarkAsDoneButton()
        configureUIWithRecord()
    }
    
    @objc private func openEditTask() {
        guard let record = self.record else { return }
        let addTaskVC = AddTaskViewController()
        addTaskVC.viewState = .editView(record)
        addTaskVC.onRecordUpdated = { [weak self] updatedRecord in
            self?.record = updatedRecord
            self?.presenter.updateTask(for: updatedRecord)
            self?.configureUIWithRecord()
        }
        let navigationController = UINavigationController(rootViewController: addTaskVC)
        self.present(navigationController, animated: true, completion: nil)
    }
    
    private func setupNavigationBarItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(openEditTask))
    }

    private func setupUI() {
        let stackView = UIStackView(arrangedSubviews: [createdLabel, priorityLabel, deadlineLabel, todoLabel, markAsDone])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8)
        ])
    }
    
    private func configureMarkAsDoneButton() {
        updateButtonTitle()
        updateButtonBackground()
        markAsDone.setTitleColor(.white, for: .normal)
        markAsDone.layer.cornerRadius = 5
        markAsDone.clipsToBounds = true
        markAsDone.addTarget(self, action: #selector(updateStatus), for: .touchUpInside)
    }
    
    private func updateButtonTitle() {
        let buttonTitle = self.record?.fields.done ?? false ? "Mark as Undone" : "Mark as Done"
        markAsDone.setTitle(buttonTitle, for: .normal)
    }
    private func updateButtonBackground() {
        markAsDone.backgroundColor = self.record?.fields.done ?? false ? .systemRed : .systemBlue
    }
    
    @objc private func updateStatus() {
        guard var recordToUpdate = self.record else { return }
        recordToUpdate.fields.done = !(recordToUpdate.fields.done ?? false)
        presenter.updateTask(for: recordToUpdate)
        presenter.didUpdateStatus = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }

    // TODO: - To rework later
    private func configureUIWithRecord() {
        guard let record = record,
              let createdAt = record.createdAt?.toFormattedDateString(),
        let deadline = record.fields.deadline.toFormattedDateString() else { return }
        
        createdLabel.text = "Created at: \(createdAt)"
        priorityLabel.text = "Priority: \(record.fields.priority.rawValue)"
        deadlineLabel.text = "to do before: \(deadline)"
        todoLabel.text = "Task: \(record.fields.toDo)"
    }
}

extension DetailViewController: DetailView {
    func updateTask(for record: Record) {
        self.record = record
    }
}
