//
//  LoginViewController.swift
//  TodoList
//
//  Created by Kirill Leonov on 20.02.2023.
//

import UIKit
import SwiftUI
import PinLayout

protocol ILoginViewController: AnyObject {
	func render(viewModel: LoginModels.ViewModel)
}

class LoginViewController: UIViewController {

	private lazy var textFieldLogin: UITextField = makeTextField(
		accessibilityIdentifier: AccessibilityIdentifier.Login.textFieldLogin
	)
	private lazy var textFieldPass: UITextField = makeTextField(
		accessibilityIdentifier: AccessibilityIdentifier.Login.textFieldPass
	)
	private lazy var buttonLogin: UIButton = makeButtonLogin(
		accessibilityIdentifier: AccessibilityIdentifier.Login.buttonLogin
	)

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
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		layoutPinLayout()
	}
	
	@objc
	func login() {
		let request = LoginModels.Request(login: loginText, password: passText)
		interactor?.login(request: request)
	}
	
	private func setupUI() {
		view.backgroundColor = .white
		title = NSLocalizedString("Authorization.title", comment: "")
		navigationController?.navigationBar.prefersLargeTitles = true
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

extension LoginViewController {
	private func layoutPinLayout() {
		view.addSubview(textFieldLogin)
		view.addSubview(textFieldPass)
		view.addSubview(buttonLogin)
		
		textFieldLogin
			.pin
			.top(Sizes.topOffset)
			.hCenter()
			.width(Sizes.M.maxWidth)
			.height(Sizes.M.height)
		
		textFieldPass
			.pin
			.hCenter()
			.below(of: textFieldLogin)
			.margin(Sizes.Padding.normal)
			.width(Sizes.M.maxWidth)
			.height(Sizes.M.height)
		
		buttonLogin
			.pin
			.hCenter()
			.below(of: textFieldPass)
			.margin(Sizes.Padding.double)
			.width(Sizes.L.width)
			.height(Sizes.L.height)
	}
	
	private func makeTextField(accessibilityIdentifier: String) -> UITextField {
		let textField = UITextField()
		
		textField.backgroundColor = .white
		textField.textColor = .black
		textField.layer.borderWidth = Sizes.borderWidth
		textField.layer.cornerRadius = Sizes.cornerRadius
		textField.layer.borderColor = UIColor.lightGray.cgColor
		textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: Sizes.Padding.half, height: textField.frame.height))
		textField.leftViewMode = .always
		textField.translatesAutoresizingMaskIntoConstraints = false

		textField.accessibilityIdentifier = accessibilityIdentifier
		
		return textField
	}
	
	func makeButtonLogin(accessibilityIdentifier: String) -> UIButton {
		let button = UIButton()
		
		button.configuration = .filled()
		button.configuration?.cornerStyle = .medium
		button.configuration?.baseBackgroundColor = .red
		button.configuration?.title = NSLocalizedString("Authorization.authorization", comment: "")
		button.addTarget(self, action: #selector(login), for: .touchUpInside)
		button.translatesAutoresizingMaskIntoConstraints = false

		button.accessibilityIdentifier = accessibilityIdentifier
		
		return button
	}
}

struct ViewControllerProvider: PreviewProvider {
	static var previews: some View {
		Group {
			LoginViewController().preview()
		}
	}
}
