//
//  TaskRepositoryTests.swift
//  TodoListTests
//
//  Created by Dmitry Troshkin on 16.03.2023.
//

import XCTest
@testable import TodoList
@testable import TaskManagerPackage

final class TaskRepositoryTests: XCTestCase {

	func test_getTasks_shouldReturnNonEmptyArray() {
		let sut = makeSut()

		let tasks = sut.getTasks()

		XCTAssertTrue(!tasks.isEmpty, "Return empty array")
	}

	func test_getTasks_shouldReturnArrayOfTasks() {
		let sut = makeSut()

		let tasks = sut.getTasks()

		XCTAssertTrue(tasks.allSatisfy { $0 is Task }, "Tasks are not of type Task")
	}

	func test_getTasks_shouldReturnCorrectNumberOfTasks() {
		let sut = makeSut()
		let expectedCount = 5

		let tasks = sut.getTasks()

		XCTAssertEqual(tasks.count, expectedCount, "Return wrong number of tasks")
	}
}

private extension TaskRepositoryTests {
	func makeSut() -> ITaskRepository {
		TaskRepositoryStub()
	}
}
