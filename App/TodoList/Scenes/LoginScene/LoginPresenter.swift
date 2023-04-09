//
//  LoginPresenter.swift
//  TodoList
//
//  Created by Kirill Leonov on 20.02.2023.
//

import TaskManagerPackage

protocol ILoginPresenter {
	func present(responce: LoginModels.Response)
}

class LoginPresenter: ILoginPresenter {
	private weak var viewController: ILoginViewController?

	init(viewController: ILoginViewController?) {
		self.viewController = viewController
	}

	func present(responce: LoginModels.Response) {
		let viewModel: LoginModels.ViewModel = responce.success ? .success : .failure(L10n.Authorization.wrongCredentials)
		viewController?.render(viewModel: viewModel)
	}
}

extension ImportantTask.TaskPriority: CustomStringConvertible {
	public var description: String {
		switch self {
		case .high:
			return "!!!"
		case .medium:
			return "!!"
		case .low:
			return "!"
		}
	}
}
