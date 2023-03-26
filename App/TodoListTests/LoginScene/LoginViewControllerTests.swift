//
//  LoginViewControllerTests.swift
//  TodoListTests
//
//  Created by Supodoco on 25.03.2023.
//

import XCTest
@testable import TodoList

final class LoginViewControllerTests: XCTestCase {
	
	private var interactor: LoginInteractorSpy! // swiftlint:disable:this implicitly_unwrapped_optional
	private var window: UIWindow! // swiftlint:disable:this implicitly_unwrapped_optional
	private var sut: LoginViewController! // swiftlint:disable:this implicitly_unwrapped_optional
	private var router = LoginRouterSpy()
	
	// MARK: - Lifecycle
	
	override func setUp() {
		super.setUp()
	
		let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
		sut = storyboard.instantiateViewController(identifier: "LoginViewController") as? LoginViewController
		interactor = LoginInteractorSpy()
		sut.interactor = interactor
		sut.router = router
		window = UIWindow()
		window.addSubview(sut.view)
		RunLoop.current.run(until: Date())
	}
	
	override func tearDown() {
		sut = nil
		interactor = nil
		window = nil
		
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
