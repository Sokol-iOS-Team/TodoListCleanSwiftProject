//
//  TodoListScreenObject.swift
//  TodoListUITests
//
//  Created by Вадим Гамзаев on 11.04.2023.
//

import XCTest

class TodoListScreenObject: BaseScreenObject {
	
	// MARK: - Private properties

	private lazy var tableView = app.tables[AccessibilityIdentifier.TodoList.tableView]
	private lazy var firstSection = app.staticTexts[AccessibilityIdentifier.TodoList.firstSectionHeader]
	private lazy var secondSection = app.staticTexts[AccessibilityIdentifier.TodoList.secondSectionHeader]
	
	// MARK: - ScreenObject Methods
	
	@discardableResult
	func isTodoListScreen() -> Self {
		assert(tableView, [.exists])
		assert(firstSection, [.exists])
		assert(secondSection, [.exists])

		return self
	}
}
