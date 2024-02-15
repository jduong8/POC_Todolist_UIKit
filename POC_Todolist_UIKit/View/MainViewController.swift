//
//  MainViewController.swift
//  POC_Todolist_UIKit
//
//  Created by Jonathan Duong on 13/02/2024.
//

import UIKit

class MainViewController: UIViewController {

    lazy var presenter = TasksPresenter(view: self)

    private var records = [Record]()

    private var tableView: UITableView!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
        presenter.fetchTasks()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        presenter.fetchTasks()
    }

    // MARK: - Private Action
    @objc private func addTask() {
        let addTaskViewController = AddTaskViewController()
        addTaskViewController.onTaskAdded = {
            self.presenter.fetchTasks()
        }
        let navigationController = UINavigationController(rootViewController: addTaskViewController)
        self.present(navigationController, animated: true, completion: nil)
    }
}

// MARK: - UI Configuration
extension MainViewController {
    private func setupNavigationBar() {
        self.navigationItem.title = "Tasks"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTask))
    }

    private func setupTableView() {
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        
        tableView.register(TaskViewCell.self, forCellReuseIdentifier: "TaskViewCell")
        
        tableView.dataSource = self
        tableView.delegate = self
    }
}

// MARK: - TasksView Protocol
extension MainViewController: TasksView {
    func deleteTask(for indexPath: IndexPath) {
        DispatchQueue.main.async {
            self.records.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

    func displayTasks(_ records: [Record]) {
        self.records = records
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TaskViewCell", for: indexPath) as? TaskViewCell else {
            return UITableViewCell()
        }
        
        let record = records[indexPath.row]
        cell.configureWith(field: record.fields)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let record = records[indexPath.row]
        let detailViewController = DetailViewController()
        detailViewController.record = record
        
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let recordId = records[indexPath.row].id else { return }
        if editingStyle == .delete {
            self.presenter.deleteTask(with: indexPath, recordId: recordId)
        }
    }
}
