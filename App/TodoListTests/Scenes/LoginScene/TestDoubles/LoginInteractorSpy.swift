//
//  LoginInteractorSpy.swift
//  TodoListTests
//
//  Created by Supodoco on 03.04.2023.
//

import Foundation
@testable import TodoList

class LoginInteractorSpy: ILoginInteractor {
	
	//MARK: Internal Properties
	
	private(set) var isCalledLogin = false
	
	// MARK: Internal Methods
	
	func login(request: TodoList.LoginModels.Request) {
		isCalledLogin = true
	}
}
