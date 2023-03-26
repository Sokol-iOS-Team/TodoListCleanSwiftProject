//
//  LoginPresenterTests.swift
//  TodoListTests
//
//  Created by Владимир Свиридов on 25.03.2023.
//

import XCTest
@testable import TodoList

final class LoginPresenterTests: XCTestCase {
	private let viewController = LoginViewControllerSpy()

	// MARK: - Internal methods

	func test_present_withValidRequest_shouldBeRenderSuccess() {
		let sut = makeSut()
		let response = LoginModels.Response(success: true)

		sut.present(responce: response)

		XCTAssertTrue(viewController.isCalledRender, "Метод viewController.render не был вызыван")
		XCTAssertTrue(viewController.viewModel, "ViewModel передает результат .failure")
	}

	func test_present_withFailureRequest_shouldBeRenderFailure() {
		let sut = makeSut()
		let response = LoginModels.Response(success: false)

		sut.present(responce: response)

		XCTAssertTrue(viewController.isCalledRender, "Не вызван метод viewController.render")
		XCTAssertFalse(viewController.viewModel, "Ошибка во viewModel, передается результат .success")
	}
}

// MARK: - Private

private extension LoginPresenterTests {
	func makeSut() -> LoginPresenter {
		LoginPresenter(viewController: viewController)
	}
}
