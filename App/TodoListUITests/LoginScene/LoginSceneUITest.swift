//
//  LoginSceneUITest.swift
//  TodoListUITests
//
//  Created by Kirill Leonov on 03.04.2023.
//

import XCTest

final class LoginSceneUITest: XCTestCase {
	
	func test_login_withValidCredentials_shouldBeSuccess() {
		let app = XCUIApplication()
		let loginScreen = LoginScreenObject(app: app)

		app.launch()

		loginScreen
			.isLoginScreen()
			.set(login: "1")
			.set(password: "1")
			.login()
	}

	func test_login_withInvalidCredentials_shouldBeFailure() {
		let app = XCUIApplication()
		let loginScreen = LoginScreenObject(app: app)

		app.launch()

		loginScreen
			.isLoginScreen()
			.set(login: "WrongName")
			.set(password: "WrongPassword")
			.login()
	}
}
