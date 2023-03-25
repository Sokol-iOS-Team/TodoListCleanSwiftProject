//
//  LoginViewControllerSpy.swift
//  TodoListTests
//
//  Created by Владимир Свиридов on 25.03.2023.
//

@testable import TodoList

final class LoginViewControllerSpy: ILoginViewController {

	// MARK: - Internal Properties

	private(set) var isCalledRender = false
	private(set) var viewModel = false

	// MARK: - Internal Methods

	func render(viewModel: TodoList.LoginModels.ViewModel) {
		isCalledRender = true

		if case .success = viewModel {
			self.viewModel = true
		}
	}
}
