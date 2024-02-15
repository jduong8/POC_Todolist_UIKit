//
//  TaskViewCell.swift
//  POC_Todolist_UIKit
//
//  Created by Jonathan Duong on 13/02/2024.
//

import Foundation
import UIKit

class TaskViewCell: UITableViewCell {
    
    // MARK: - Properties
    private let priorityLabel = UILabel()
    private let deadlineLabel = UILabel()
    private let taskLabel = UILabel()
    private let statusImageView = UIImageView()
    private let roundedBackgroundView = UIView()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    // MARK: - Configuration
    private func setupViews() {
        configureRoundedBackgroundView()
        setupLabels()
        configureStatusImageView()
        setupLayout()
    }
    
    // MARK: - Public method
    func configureWith(field: Field) {
        priorityLabel.text = "Priority: \(field.priority.rawValue)"
        deadlineLabel.text = "To do before: \(field.deadline)"
        taskLabel.text = "Task: \(field.toDo)"
        configureStatusIcon(done: field.done)
    }
}

// MARK: - UI Setup
extension TaskViewCell {
    private func setupLabels() {
        [priorityLabel, deadlineLabel, taskLabel].forEach { label in
            label.translatesAutoresizingMaskIntoConstraints = false
            roundedBackgroundView.addSubview(label)
        }
        
        configureLabel(priorityLabel, textColor: .blue)
        configureLabel(deadlineLabel, textColor: .red)
        configureLabel(taskLabel, textColor: .black)
    }
    
    private func configureStatusImageView() {
        statusImageView.translatesAutoresizingMaskIntoConstraints = false
        statusImageView.contentMode = .scaleAspectFit
        roundedBackgroundView.addSubview(statusImageView)
    }
    
    private func setupLayout() {
        let verticalStackView = UIStackView(arrangedSubviews: [priorityLabel, deadlineLabel, taskLabel])
        verticalStackView.axis = .vertical
        verticalStackView.distribution = .fillEqually
        verticalStackView.spacing = 8
        
        let horizontalStackView = UIStackView(arrangedSubviews: [verticalStackView, statusImageView])
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = 8
        horizontalStackView.alignment = .center
        configureStackView(horizontalStackView)
    }
    
    private func configureRoundedBackgroundView() {
        roundedBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        roundedBackgroundView.backgroundColor = .lightGray
        roundedBackgroundView.layer.cornerRadius = 10
        roundedBackgroundView.layer.masksToBounds = true // Pour appliquer l'arrondi
        
        addSubview(roundedBackgroundView)
        
        // Ajout de contraintes pour le rounded rectangle
        NSLayoutConstraint.activate([
            roundedBackgroundView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            roundedBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            roundedBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            roundedBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
        
        // Contrainte de hauteur maximale pour roundedBackgroundView (optionnelle)
        let heightConstraint = roundedBackgroundView.heightAnchor.constraint(lessThanOrEqualToConstant: 120)
        heightConstraint.priority = .defaultHigh
        heightConstraint.isActive = true
    }
    
    private func configureLabel(_ label: UILabel, textColor: UIColor) {
        label.textColor = textColor
        label.textAlignment = .left
    }
    
    private func configureStackView(_ stackView: UIStackView) {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        roundedBackgroundView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: roundedBackgroundView.topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: roundedBackgroundView.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: roundedBackgroundView.trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: roundedBackgroundView.bottomAnchor, constant: -8),
            statusImageView.widthAnchor.constraint(equalToConstant: 24)
        ])
    }
}

// MARK: - Status Icon Configuration
extension TaskViewCell {
    private func configureStatusIcon(done: Bool?) {
        let symbolName = done ?? false ? "checkmark.circle.fill" : "circle"
        statusImageView.image = UIImage(systemName: symbolName)
        statusImageView.tintColor = done ?? false ? .green : .red
    }
}
