//
//  ImportantTaskTests.swift
//  TodoListTests
//
//  Created by Dmitry Troshkin on 12.03.2023.
//

import XCTest
@testable import TaskManagerPackage

final class ImportantTaskTests: XCTestCase {

	func test_initImportatTask_shouldBeCreated() {
		let sut = ImportantTask(title: "Test task", taskPriority: .low)

		XCTAssertNotNil(sut, "Important task isn't created")
	}

	func test_initImportatTask_withPriorityAndTitle_shouldBeCorrect() {
		let title = "Test task"
		let taskPriority = ImportantTask.TaskPriority.low

		let sut = ImportantTask(title: title, taskPriority: taskPriority)

		XCTAssertEqual(sut.title, title, "Title isn't set correctly")
		XCTAssertEqual(sut.taskPriority, taskPriority, "TaskPriority isn't set correctly")
	}

	func test_setTaskDeadline_withLowPriority_shouldBeCorrect() {
		let createDate = Date()
		let sut = ImportantTask(title: "Test task", taskPriority: .low, createDate: createDate)

		let deadline = Calendar.current.date(byAdding: .day, value: 3, to: createDate)

		XCTAssertEqual(sut.deadLine, deadline, "Deadline is not correct for low priority task")
	}

	func test_setTaskDeadline_withMediumPriority_shouldBeCorrect() {
		let createDate = Date()
		let sut = ImportantTask(title: "Test task", taskPriority: .medium, createDate: createDate)

		let deadline = Calendar.current.date(byAdding: .day, value: 2, to: createDate)

		XCTAssertEqual(sut.deadLine, deadline, "Deadline is not correct for medium priority task")
	}

	func test_setTaskDeadline_withHighPriority_shouldBeCorrect() {
		let createDate = Date()
		let sut = ImportantTask(title: "Test task", taskPriority: .high, createDate: createDate)

		let deadline = Calendar.current.date(byAdding: .day, value: 1, to: createDate)

		XCTAssertEqual(sut.deadLine, deadline, "Deadline is not correct for high priority task")
	}

	func test_setTaskIsComplete_shouldBeFalseByDefault() {
		let sut = ImportantTask(title: "Test task", taskPriority: .low)

		XCTAssertFalse(sut.isComplete, "isComplete should be false by default")
	}

	func test_setTaskAsCompleted_shouldBeTrue() {
		let sut = ImportantTask(title: "Test task", taskPriority: .low)

		sut.isComplete = true

		XCTAssertTrue(sut.isComplete, "isComplete should be true")
	}

	func test_changeTaskPriority_shouldBeCorrect() {
		let taskPriority = ImportantTask.TaskPriority.low
		let sut = ImportantTask(title: "Test task", taskPriority: .medium, createDate: Date())

		sut.taskPriority = taskPriority

		XCTAssertEqual(sut.taskPriority, taskPriority, "TaskPriority isn't changed")
	}
}
