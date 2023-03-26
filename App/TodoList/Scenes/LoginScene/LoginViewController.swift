//
//  LoginViewController.swift
//  TodoList
//
//  Created by Kirill Leonov on 20.02.2023.
//

import UIKit

protocol ILoginViewController: AnyObject {
	func render(viewModel: LoginModels.ViewModel)
}

class LoginViewController: UIViewController {

	@IBOutlet private weak var textFieldLogin: UITextField!
	@IBOutlet private weak var textFieldPass: UITextField!
	@IBAction private func buttonLogin(_ sender: Any) { login() }

	var interactor: ILoginInteractor?
	var router: ILoginRouter?
	
	var loginText: String {
		get {
			textFieldLogin.text ?? ""
		}
		
		set {
			textFieldLogin.text = newValue
		}
	}
	
	var passText: String {
		get {
			textFieldPass.text ?? ""
		}
		
		set {
			textFieldPass.text = newValue
		}
	}
	
	func login() {
		let request = LoginModels.Request(login: loginText, password: passText)
		interactor?.login(request: request)
	}
}

extension LoginViewController: ILoginViewController {
	func render(viewModel: LoginModels.ViewModel) {
		switch viewModel {
		case .success:
			router?.routeToTodoList()
		case .failure(let message):
			router?.showError(message: message)
		}
	}
}
