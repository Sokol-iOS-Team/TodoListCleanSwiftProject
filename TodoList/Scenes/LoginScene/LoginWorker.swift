//
//  LoginWorker.swift
//  TodoList
//
//  Created by Kirill Leonov on 20.02.2023.
//

import Foundation

protocol ILoginWorker {
	func login(login: String, password: String) -> Bool
}

class LoginWorker: ILoginWorker {
	private let validLogin = "1"
	private let validPassword = "1"

	func login(login: String, password: String) -> Bool {
		login == validLogin && password == validPassword
	}
}
