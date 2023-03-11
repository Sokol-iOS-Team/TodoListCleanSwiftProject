//
//  TodoListInteractor.swift
//  TodoList
//
//  Created by Kirill Leonov on 01.03.2023.
//

import Foundation

protocol ITodoListInteractor {
	func fetchData()
	func didTaskSelected(atIndex: TodoListModel.Request.TaskSelected)
}

class TodoListInteractor: ITodoListInteractor {
	private let sectionManager: ISectionForTaskManagerAdapter
	private let presenter: ITodoListPresenter

	internal init(sectionManager: ISectionForTaskManagerAdapter, presenter: ITodoListPresenter) {
		self.sectionManager = sectionManager
		self.presenter = presenter
	}
		
	func fetchData() {
		var responseData = [TodoListModel.Response.SectionWithTasks]()
		for section in sectionManager.getSections() {
			let sectionWithTasks = TodoListModel.Response.SectionWithTasks(
				section: section,
				tasks: sectionManager.getTasksForSection(section: section)
			)
			responseData.append(sectionWithTasks)
		}
		let response = TodoListModel.Response(data: responseData)
		presenter.present(responce: response)
	}
	
	func didTaskSelected(atIndex index: TodoListModel.Request.TaskSelected) {
		let section = sectionManager.getSection(forIndex: index.indexPath.section)
		let task = sectionManager.getTasksForSection(section: section)[index.indexPath.row]
		task.isComplete.toggle()
		fetchData()
	}
}
