//
//  TodoListUITests.swift
//  TodoListUITests
//
//  Created by Вадим Гамзаев on 11.04.2023.
//

import XCTest

final class TodoListUITests: XCTestCase {
	
	func test_todoListSections_mustReturnEqualValue() {
		let app = XCUIApplication()
		let todoListScreen = TodoListScreenObject(app: app)
		
		app.launchEnvironment["UITEST_START_FROM_TODOLISTSCREEN"] = "1"
		app.launch()

		todoListScreen
			.isTodoListScreen()
		
		
	}
}
