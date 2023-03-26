//
//  LoginPresenterSpy.swift
//  TodoListTests
//
//  Created by Вадим Гамзаев on 25.03.2023.
//

@testable import TodoList

class TodoPresenterSpy: ITodoListPresenter {
	// MARK: - Internal Properties

	private(set) var isCalledPresent = false
	private(set) var response = TodoList.TodoListModel.Response(data: [])

	// MARK: - Internal Methods

	func present(response: TodoList.TodoListModel.Response) {
		isCalledPresent = true
		self.response = response
	}
}
