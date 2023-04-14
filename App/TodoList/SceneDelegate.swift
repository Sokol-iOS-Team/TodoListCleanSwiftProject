//
//  SceneDelegate.swift
//  TodoList
//
//  Created by Kirill Leonov on 20.02.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	var window: UIWindow?

	func scene(
		_ scene: UIScene,
		willConnectTo session: UISceneSession,
		options connectionOptions: UIScene.ConnectionOptions
	) {
		guard let scene = (scene as? UIWindowScene) else { return }
		let window = UIWindow(windowScene: scene)
		window.rootViewController = createRootViewController()
		window.makeKeyAndVisible()
		
		self.window = window
	}
	
	private func createRootViewController() -> UIViewController {
	#if DEBUG
		if ProcessInfo.processInfo.environment["UITEST_START_FROM_TODOLISTSCREEN"] == "1" {
			return UINavigationController(rootViewController: assemblyForSecondScreenUITests())
		} else {
					return UINavigationController(rootViewController: assembly())
		}
	#endif
		return UINavigationController(rootViewController: assembly())
	}

	func assembly() -> UIViewController {
		let loginViewController = LoginAssembler().assembly()
		let todoListViewController = TodoListAssembler().assembly()

		let router = LoginRouter(
			loginViewController: loginViewController,
			todoListViewController: todoListViewController
		)

		if let loginViewController = loginViewController as? LoginViewController {
			loginViewController.router = router
		}

		return loginViewController
	}
	
	func assemblyForSecondScreenUITests() -> UIViewController {
		let todoListViewController = TodoListAssembler().assembly()

		return todoListViewController
	}
}
