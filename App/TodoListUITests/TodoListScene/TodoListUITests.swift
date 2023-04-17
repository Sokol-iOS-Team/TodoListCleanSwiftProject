//
//  TodoListUITests.swift
//  TodoListUITests
//
//  Created by Вадим Гамзаев on 11.04.2023.
//

import XCTest

final class TodoListUITests: XCTestCase {
	
	func test_sectionHeaderTitlesAreCorrect() {
		let app = makeApp()
		app.launch()
		let todoListScreen = TodoListScreenObject(app: app)

		todoListScreen
			.isTodoListScreen()
			.verifySectionHeaderTitles(section: 0, title: L10n.TodoList.uncompletedSection)
			.verifySectionHeaderTitles(section: 1, title: L10n.TodoList.completedSection)
	}

	func test_taskCompletion() {
		let app = makeApp()
		app.launch()
		let todoListScreen = TodoListScreenObject(app: app)
		let uncompeletedTaskCount = todoListScreen.numberOfRows(inSection: 0)
		let compeletedTaskCount = todoListScreen.numberOfRows(inSection: 1)

		todoListScreen
			.isTodoListScreen()
			.tapCell(at: IndexPath(row: 0, section: 0))
			.verifyNumberOfRowsInSection(0, expectedCount: uncompeletedTaskCount - 1)
			.verifyNumberOfRowsInSection(1, expectedCount: compeletedTaskCount + 1)
	}
}

// MARK: - Private

private extension TodoListUITests {
	func makeApp() -> XCUIApplication {
		let app = XCUIApplication()
		app.launchEnvironment["UITEST_START_FROM_TODOLISTSCREEN"] = "1"

		return app
	}
}
