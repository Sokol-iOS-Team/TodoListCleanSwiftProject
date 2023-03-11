//
//  LoginInteractor.swift
//  TodoList
//
//  Created by Kirill Leonov on 20.02.2023.
//

import Foundation

protocol ILoginInteractor {
	func login(request: LoginModels.Request)
}

class LoginInteractor: ILoginInteractor {
	private var worker: ILoginWorker
	private var presenter: ILoginPresenter?
	
	init(worker: ILoginWorker, presenter: ILoginPresenter) {
		self.worker = worker
		self.presenter = presenter
	}
	
	func login(request: LoginModels.Request) {
		let result = worker.login(login: request.login, password: request.password)
		let responce = LoginModels.Response(success: result)
		
		presenter?.present(responce: responce)
	}
	
}
