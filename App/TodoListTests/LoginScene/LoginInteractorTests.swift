//
//  LoginInteractorTests.swift
//  
//
//  Created by Supodoco on 25.03.2023.
//

import XCTest
@testable import TodoList

final class LoginInteractorTests: XCTestCase {
	
	// MARK: - Internal Properties
	
	private let worker = LoginWorkerSpy()
	private let presenter = LoginPresenterSpy()
	
	// MARK: - Internal Methods
	
	func test_login_withValidRequest_shouldSuccessfullyLoggedIn() {
		let sut = makeSut()
		let request = LoginModels.Request(login: "validEmail", password: "validPass")
		
		sut.login(request: request)
		
		XCTAssertTrue(worker.isCalledLogin, "Не вызван worker.login(:)")
		XCTAssertTrue(presenter.isCalledPresent, "Не вызван  presenter.present(:)")
	}
}

// MARK: - Making sut

private extension LoginInteractorTests {
	func makeSut() -> LoginInteractor {
		LoginInteractor(worker: worker, presenter: presenter)
	}
}
