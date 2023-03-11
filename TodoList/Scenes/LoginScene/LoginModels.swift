//
//  LoginModels.swift
//  TodoList
//
//  Created by Kirill Leonov on 20.02.2023.
//

import Foundation

enum LoginModels {
	struct Request {
		var login: String
		var password: String
	}
	
	struct Response {
		var success: Bool
	}
	
	enum ViewModel {
		case success
		case failure(String)
	}
}
