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
		app.launch()

		let textFieldLogin = app.textFields[AccessibilityIdentifier.Login.textFieldLogin]
		let textFieldPass = app.textFields[AccessibilityIdentifier.Login.textFieldPass]

		let buttonLogin = app.buttons[AccessibilityIdentifier.Login.buttonLogin]

		textFieldLogin.tap()
		textFieldLogin.typeText("1")

		textFieldPass.tap()
		textFieldPass.typeText("1")

		buttonLogin.tap()

		XCTAssertTrue(app.tables.staticTexts[L10n.TodoList.completedSection].exists)
	}

	func test_login_withInvalidCredentials_shouldBeFailure() {
		let app = XCUIApplication()
		app.launch()

		let textFieldLogin = app.textFields[AccessibilityIdentifier.Login.textFieldLogin]
		let textFieldPass = app.textFields[AccessibilityIdentifier.Login.textFieldPass]

		let buttonLogin = app.buttons[AccessibilityIdentifier.Login.buttonLogin]

		textFieldLogin.tap()
		textFieldLogin.typeText("WrongName")

		textFieldPass.tap()
		textFieldPass.typeText("WrongPassword")

		buttonLogin.tap()

		XCTAssertTrue(app.alerts.staticTexts[L10n.Authorization.wrongCredentials].exists)
	}
}
