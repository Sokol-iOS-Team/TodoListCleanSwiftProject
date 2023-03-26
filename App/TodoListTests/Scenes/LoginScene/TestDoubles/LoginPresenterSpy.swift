//
//  LoginPresenterSpy.swift
//  TodoListTests
//
//  Created by Supodoco on 25.03.2023.
//

@testable import TodoList

class LoginPresenterSpy: ILoginPresenter {
	
	// MARK: - Internal Properties
	
	private(set) var isCalledPresent = false
		
	// MARK: - Internal Methods
	
	func present(responce: TodoList.LoginModels.Response) {
		isCalledPresent = true
	}
}
