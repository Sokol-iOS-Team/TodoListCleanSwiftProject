//
//  LoginWorkerTests.swift
//  TodoListTests
//
//  Created by Dmitry Troshkin on 16.03.2023.
//

import XCTest
@testable import TodoList

final class LoginWorkerTests: XCTestCase {

	func test_login_withValidCredentials_shouldReturnTrue() {
		let sut = makeSut()
		let login = "1"
		let password = "1"

		let result = sut.login(login: login, password: password)

		XCTAssertTrue(result, "Authorization should be successful with valid credentials")
	}

	func test_login_withInvalidLogin_shouldReturnFalse() {
		let sut = makeSut()
		let login = "invalid"
		let password = "1"

		let result = sut.login(login: login, password: password)

		XCTAssertFalse(result, "Authorization should fail with invalid login")
	}

	func test_login_withInvalidPassword_shouldReturnFalse() {
		let sut = makeSut()
		let login = "1"
		let password = "invalid"

		let result = sut.login(login: login, password: password)

		XCTAssertFalse(result, "Authorization should fail with invalid password")
	}

	func test_login_withInvalidCredentials_shouldReturnFalse() {
		let sut = makeSut()
		let login = "invalid"
		let password = "invalid"

		let result = sut.login(login: login, password: password)

		XCTAssertFalse(result, "Authorization should fail with invalid credentials")
	}
}

private extension LoginWorkerTests {
	func makeSut() -> ILoginWorker {
		LoginWorker()
	}
}
