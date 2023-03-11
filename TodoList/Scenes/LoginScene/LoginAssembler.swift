//
//  LoginAssembler.swift
//  TodoList
//
//  Created by Kirill Leonov on 01.03.2023.
//

import UIKit

final class LoginAssembler {
	func assembly() -> UIViewController {
		let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
		guard let viewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as?
				LoginViewController
		else {
			fatalError("Нету на Main.storyboard LoginViewController!")
		}
		
		let presenter = LoginPresenter(viewController: viewController)
		let worker = LoginWorker()
		let interactor = LoginInteractor(worker: worker, presenter: presenter)
		viewController.interactor = interactor
		
		return viewController
	}
}
