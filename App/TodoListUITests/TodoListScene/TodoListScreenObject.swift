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
	private lazy var firstSectionHeader = app.staticTexts[AccessibilityIdentifier.TodoList.firstSectionHeader]
	private lazy var secondSectionHeader = app.staticTexts[AccessibilityIdentifier.TodoList.secondSectionHeader]
	
	// MARK: - ScreenObject Methods
	
	@discardableResult
	func isTodoListScreen() -> Self {
		assert(tableView, [.exists])
		assert(firstSectionHeader, [.exists])
		assert(secondSectionHeader, [.exists])

		return self
	}

	@discardableResult
	func verifySectionHeaderTitles(section: Int, title: String) -> Self {
		let sectionHeaderTitle = section == 0 ? firstSectionHeader : secondSectionHeader
		assert(sectionHeaderTitle, [.contains(title)])

		return self
	}

	@discardableResult
	func tapCell(at indexPath: IndexPath) -> Self {
		let cell = tableView.cells.element(
			matching: .cell,
			identifier: AccessibilityIdentifier.TodoList.tableViewCell(indexPath: indexPath)
		)
		assert(cell, [.exists, .isHittable])
		cell.tap()

		return self
	}

	@discardableResult
	func verifyNumberOfRowsInSection(_ section: Int, expectedCount: Int) -> Self {
		let count = numberOfRows(inSection: section)
		XCTAssertEqual(
			count,
			expectedCount,
			"Количество ячеек \(count) в секции \(section) не соответствует ожидаемому результату \(expectedCount)"
		)

		return self
	}

	func numberOfRows(inSection section: Int) -> Int {
		tableView.cells.matching(NSPredicate(format: "identifier BEGINSWITH 'cell-\(section)-'")).count
	}
}
