//
//  ImportantTaskTests.swift
//  TodoListTests
//
//  Created by Dmitry Troshkin on 12.03.2023.
//

import XCTest
@testable import TaskManagerPackage

final class ImportantTaskTests: XCTestCase {

	func test_createImportatTask_shouldBeCreatedSuccessfully() {
		let sut = ImportantTask(title: "Test task", taskPriority: .low)

		XCTAssertNotNil(sut, "Important task isn't created")
	}

	func test_createImportatTask_withPriorityAndTitle_priorityAndTitleShouldBeSetCorrectly() {
		let title = "Test task"
		let taskPriority = ImportantTask.TaskPriority.low

		let sut = ImportantTask(title: title, taskPriority: taskPriority)

		XCTAssertEqual(sut.title, title, "Title isn't set correctly")
		XCTAssertEqual(sut.taskPriority, taskPriority, "TaskPriority isn't set correctly")
	}

	func test_createImportantTask_withLowPriority_deadlineShouldBeIn3Days() {
		let createDate = Date()
		let deadline = Calendar.current.date(byAdding: .day, value: 3, to: createDate)
		let sut = ImportantTask(title: "Test task", taskPriority: .low, createDate: createDate)

		XCTAssertEqual(sut.deadLine, deadline, "Deadline isn't correct (3 days after create date) for low priority")
	}

	func test_createImportantTask_withMediumPriority_deadlineShouldBeIn2Days() {
		let createDate = Date()
		let deadline = Calendar.current.date(byAdding: .day, value: 2, to: createDate)
		let sut = ImportantTask(title: "Test task", taskPriority: .medium, createDate: createDate)

		XCTAssertEqual(sut.deadLine, deadline, "Deadline isn't correct (2 days after create date) for medium priority")
	}

	func test_createImportantTask_withHighPriority_deadlineShouldBeIn1Days() {
		let createDate = Date()
		let deadline = Calendar.current.date(byAdding: .day, value: 1, to: createDate)
		let sut = ImportantTask(title: "Test task", taskPriority: .high, createDate: createDate)

		XCTAssertEqual(sut.deadLine, deadline, "Deadline isn't correct (1 day after create date) for high priority")
	}

	func test_createImportantTask_isCompleteShouldBeFalseByDefault() {
		let sut = ImportantTask(title: "Test task", taskPriority: .low)

		XCTAssertFalse(sut.isComplete, "isComplete should be false by default")
	}

	func test_isComplete_setTrue_isCompleteShouldBeTrue() {
		let sut = ImportantTask(title: "Test task", taskPriority: .low)

		sut.isComplete = true

		XCTAssertTrue(sut.isComplete, "isComplete should be true")
	}

	func test_taskPriority_setNewValue_taskPriorityShouldBeChangedWithNewValue() {
		let taskPriority = ImportantTask.TaskPriority.low
		let sut = ImportantTask(title: "Test task", taskPriority: .medium, createDate: Date())

		sut.taskPriority = taskPriority

		XCTAssertEqual(sut.taskPriority, taskPriority, "TaskPriority isn't changed")
	}
}
