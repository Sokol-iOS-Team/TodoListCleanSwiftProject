//
//  TodoListViewControllerSpy.swift
//  TodoListTests
//
//  Created by Dmitry Troshkin on 24.03.2023.
//

@testable import TodoList

class TodoListViewControllerSpy: ITodoListViewController {

	// MARK: - Internal Properties

	private(set) var isCalledRender = false
	private(set) var viewModel: TodoListModel.ViewModel = TodoListModel.ViewModel(tasksBySections: [])

	// MARK: - Internal Methods

	func render(viewData: TodoList.TodoListModel.ViewModel) {
		isCalledRender = true

		self.viewModel = viewData
	}
}
