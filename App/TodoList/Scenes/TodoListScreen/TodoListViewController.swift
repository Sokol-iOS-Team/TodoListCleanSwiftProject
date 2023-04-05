//
//  TodoListTableViewController.swift
//  TodoList
//
//  Created by Kirill Leonov on 20.02.2023.
//

import UIKit
import PinLayout

protocol ITodoListViewController: AnyObject {
	func render(viewData: TodoListModel.ViewModel)
}

final class TodoListViewController: UITableViewController {

	// MARK: - Internal Properties

	var viewModel: TodoListModel.ViewModel = TodoListModel.ViewModel(tasksBySections: [])
	var interactor: ITodoListInteractor?

	// MARK: - Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()
		title = NSLocalizedString("TodoList.title", comment: "")

		configureTableView()
		interactor?.fetchData()
	}

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        self.tableView.pin.all()
    }

	// MARK: - Private

	private func configureTableView() {
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
		tableView.dataSource = self
		tableView.accessibilityIdentifier = AccessibilityIdentifier.TodoList.tableView
	}

	// MARK: - TableViewDataSource
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		viewModel.tasksBySections.count
	}

	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		viewModel.tasksBySections[section].title
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		let section = viewModel.tasksBySections[section]
		return section.tasks.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let tasks = viewModel.tasksBySections[indexPath.section].tasks
		let taskData = tasks[indexPath.row]
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		cell.accessibilityIdentifier = "cell-\(indexPath.row)-\(indexPath.section)"
		var contentConfiguration = cell.defaultContentConfiguration()

		switch taskData {
		case .importantTask(let task):
			let redText = [NSAttributedString.Key.foregroundColor: UIColor.red]
			let taskText = NSMutableAttributedString(string: "\(task.priority) ", attributes: redText )
			taskText.append(NSAttributedString(string: task.name))

			contentConfiguration.attributedText = taskText
			contentConfiguration.secondaryText = task.deadLine
			contentConfiguration.secondaryTextProperties.color = task.isOverdue ? .red : .black
			cell.accessoryType = task.isDone ? .checkmark : .none
		case .regularTask(let task):
			contentConfiguration.text = task.name
			cell.accessoryType = task.isDone ? .checkmark : .none
		}

		cell.tintColor = .red
		contentConfiguration.secondaryTextProperties.font = UIFont.systemFont(ofSize: 16)
		contentConfiguration.textProperties.font = UIFont.boldSystemFont(ofSize: 19)
		cell.contentConfiguration = contentConfiguration

		return cell
	}

	// MARK: - TableViewDelegate

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		interactor?.didTaskSelected(atIndex: TodoListModel.Request.TaskSelected(indexPath: indexPath))
	}
}

// MARK: - ITodoListViewController

extension TodoListViewController: ITodoListViewController {
	func render(viewData: TodoListModel.ViewModel) {
		self.viewModel = viewData
		tableView.reloadData()
	}
}
