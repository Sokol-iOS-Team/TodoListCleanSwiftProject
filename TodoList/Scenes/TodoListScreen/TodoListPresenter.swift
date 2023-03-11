//
//  TodoListPresenter.swift
//  TodoList
//
//  Created by Kirill Leonov on 20.02.2023.
//

import Foundation

protocol ITodoListPresenter {
	func present(responce: TodoListModel.Response)
}

class TodoListPresenter: ITodoListPresenter {
	private weak var viewController: ITodoListViewController!
	
	init(viewController: ITodoListViewController) {
		self.viewController = viewController
	}
	
	func present(responce: TodoListModel.Response) {
		var sections = [TodoListModel.ViewModel.Section]()
		for section in responce.data {
			let sectionData = TodoListModel.ViewModel.Section(
				title: section.section.title,
				tasks: mapTasksData(tasks: section.tasks )
			)
			
			sections.append(sectionData)
		}
		
		let viewData = TodoListModel.ViewModel(tasksBySections: sections)
		viewController.render(viewData: viewData)
	}
	
	private func mapTasksData(tasks: [Task]) -> [TodoListModel.ViewModel.Task] {
		tasks.map{ mapTaskData(task: $0) }
	}
	
	private func mapTaskData(task: Task) -> TodoListModel.ViewModel.Task {
		if let task = task as? ImportantTask {
			let result = TodoListModel.ViewModel.ImportantTask(
				name: task.title,
				isDone: task.isComplete,
				isOverdue: task.deadLine < Date(),
				deadLine: "Deadline: \(task.deadLine)",
				priority: "\(task.taskPriority)"
			)
			return .importantTask(result)
		} else {
			return .regularTask(TodoListModel.ViewModel.RegularTask(name: task.title, isDone: task.isComplete))
		}
	}
}
