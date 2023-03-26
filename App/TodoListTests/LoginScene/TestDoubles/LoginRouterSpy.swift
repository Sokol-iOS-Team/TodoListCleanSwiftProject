//
//  LoginRouterSpy.swift
//  TodoListTests
//
//  Created by Supodoco on 25.03.2023.
//

@testable import TodoList

class LoginRouterSpy: ILoginRouter {
	
	// MARK: - Internal Properties
	
	private(set) var isCalledShowError = false
	private(set) var isCalledRouteToTodoList = false

		
	// MARK: - Internal Methods
	
	func routeToTodoList() {
		isCalledRouteToTodoList = true
	}
	
	func showError(message: String) {
		isCalledShowError = true
	}
}
