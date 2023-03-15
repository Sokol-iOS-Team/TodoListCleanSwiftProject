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
	var interactor: ILoginInteractor?
	var router: ILoginRouter?

	@IBOutlet private weak var textFieldLogin: UITextField!
	@IBOutlet private weak var textFieldPass: UITextField!
	@IBAction private func buttonLogin(_ sender: Any) {
		if let email = textFieldLogin.text, let password = textFieldPass.text {
			let request = LoginModels.Request(login: email, password: password)
			interactor?.login(request: request)
		}
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
