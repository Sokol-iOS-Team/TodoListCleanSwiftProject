//
//  TodoListInteractorTests.swift
//  TodoListTests
//
//  Created by Вадим Гамзаев on 25.03.2023.
//

import XCTest
@testable import TodoList

class TodoListInteractorTests: XCTestCase {

	private let presenter = TodoPresenterSpy()
	private let sectionManager = MockSectionForTaskManagerAdapter()

	func test_fetchData_withResponse_shouldCalledPresenter() {
		let sut = makeSut()

		sut.fetchData()

		XCTAssertTrue(
			presenter.isCalledPresent,
			"Функция TodoListPresenter present(:) не была вызвана."
			)
	}

	func test_fetchData_withResponse_responseShouldContainData() {
		let sut = makeSut()

		sut.fetchData()

		XCTAssertFalse(
			presenter.response.data.isEmpty,
			"response.data не содержит информацию о секциях и содержащихся в них задачах."
		)
	}

	func test_fetchData_withResponse_responseDataShouldBeArrayOfSectionWithTasksType() {
		let sut = makeSut()

		sut.fetchData()

		XCTAssertTrue(
			(presenter.response.data as Any) is [TodoListModel.Response.SectionWithTasks],
			"Обекты в возвращаемом массиве Tasks не соответсвуют типу Task."
		)
	}

	func test_didTaskSelected_withIndexPath_shouldToggleIsCompleteTaskProperty() {
		let sut = makeSut()
		let indexPath = IndexPath(row: 0, section: 0)
		let section = sectionManager.getSection(forIndex: indexPath.section)
		let task = sectionManager.getTasksForSection(section: section)[indexPath.row]
		task.isComplete = false

		sut.didTaskSelected(atIndex: TodoListModel.Request.TaskSelected(indexPath: indexPath))

		XCTAssertTrue(
			task.isComplete,
			"Значение isComplete должно изменится на true."
		)
	}
}

// MARK: - Private

private extension TodoListInteractorTests {
	func makeSut() -> TodoListInteractor {
		TodoListInteractor(sectionManager: sectionManager, presenter: presenter)
	}
}
