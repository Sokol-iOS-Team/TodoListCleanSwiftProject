//
//  LoginViewControllerTests.swift
//  TodoListTests
//
//  Created by Supodoco on 25.03.2023.
//

import XCTest
@testable import TodoList

final class LoginViewControllerTests: XCTestCase {
	
	private var interactor: LoginInteractorSpy!
	private var sut: LoginViewController!
	private var router: LoginRouterSpy!
	
	// MARK: - Lifecycle
	
	override func setUp() {
		super.setUp()
	
		sut = LoginViewController()
		interactor = LoginInteractorSpy()
		router = LoginRouterSpy()
		
		sut.interactor = interactor
		sut.router = router
	}
	
	override func tearDown() {
		sut = nil
		interactor = nil
		router = nil
		
		super.tearDown()
	}
	
	// MARK: - Public Methods
	
	func test_render_withValidRequest_shouldBeLoggedIn() {
		sut.loginText = "validEmail"
		sut.passText = "validPass"
		
		sut.login()
		
		XCTAssertTrue(interactor.isCalledLogin, "Не вызван interactor.login(:).")
	}
	
	func test_login_withValidRequest_shouldBeLoggedIn() {
		let request = LoginModels.Request(login: "login", password: "password")
		
		interactor.login(request: request)
		
		XCTAssertTrue(interactor.isCalledLogin, "interactor.login(:) не вызван.")
	}
	
	func test_render_withSuccessViewModel_shouldBeCalledRouting() {
		let viewModel = LoginModels.ViewModel.success
		
		sut.render(viewModel: viewModel)
		
		XCTAssertTrue(router.isCalledRouteToTodoList, "router.routeToTodoList(:) не был вызван.")
	}
	
	func test_render_withFailureViewModel_shouldBeCalledShowError() {
		let viewModel = LoginModels.ViewModel.failure("error")
		
		sut.render(viewModel: viewModel)
		
		XCTAssertTrue(router.isCalledShowError, "router.isCalledShowError(:) не был вызван.")
	}
}
