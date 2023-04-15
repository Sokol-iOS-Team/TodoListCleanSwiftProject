//
//  LoginSceneUITest.swift
//  TodoListUITests
//
//  Created by Владимир Свиридов on 09.04.2023.
//

import XCTest

final class LoginSceneUITest: XCTestCase {
 
	func test_login_withValidCredentials_shouldBeSuccess() {
		let app = XCUIApplication()
		let loginScreen = LoginScreenObject(app: app)

		app.launch()

		loginScreen
			.isLoginScreen()
			.set(password: "1")
			.set(login: "1")
			.login()

		XCTAssertTrue(app.tables[AccessibilityIdentifier.TodoList.tableView].exists)
	}

	func test_login_withInvalidCredentials_shouldBeFailure() {
		let app = XCUIApplication()
		let loginScreen = LoginScreenObject(app: app)

		app.launch()

		loginScreen
			.isLoginScreen()
			.set(password: "WrongPass")
			.set(login: "WrongLogin")
			.login()

		XCTAssertTrue(app.alerts.staticTexts[L10n.Authorization.wrongCredentials].exists)
	}
}
