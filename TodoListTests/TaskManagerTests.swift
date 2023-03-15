//
//  TaskManagerTests.swift
//  TodoListTests
//
//  Created by Владимир Свиридов on 12.03.2023.
//

import XCTest
@testable import TodoList

final class TaskManagerTests: XCTestCase {

	var sut: TaskManager!
	var taskRepository: ITaskRepository!

	override func setUp() {
		super.setUp()
		sut = TaskManager()
		taskRepository = TaskRepositoryStub()
	}

	override func tearDown() {
		sut = nil
		taskRepository = nil
		super.tearDown()
	}

	func test_allTasks_withTasksFromRepository_shouldBeNotEmpty() {
		sut.addTasks(tasks: taskRepository.getTasks())

		XCTAssertFalse(sut.allTasks().isEmpty, "Tasks must be not empty")
	}

	func test_allTasks_initialState_shouldBeEmpty() {
		XCTAssertTrue(sut.allTasks().isEmpty, "Tasks must be empty")
	}

	func test_allTasks_shouldGetArrayOfTaskType() {
		XCTAssertTrue((sut.allTasks() as Any) is [Task], "Tasks have another type")
	}

	func test_completedTasks_withTasksFromRepository_shouldBeNotEmpty() {
		sut.addTasks(tasks: taskRepository.getTasks())

		XCTAssertFalse(sut.completedTasks().isEmpty, "Tasks must be not empty")
	}

	func test_completedTasks_initialState_shouldBeEmpty() {
		XCTAssertTrue(sut.completedTasks().isEmpty, "Tasks must be empty")
	}

	func test_completedTasks_shouldGetArrayOfTaskType() {
		XCTAssertTrue((sut.completedTasks() as Any) is [Task], "Tasks have another type")
	}

	func test_completedTasks_withTasksFromRepository_shouldHaveOnlyComletedTasks() {
		sut.addTasks(tasks: taskRepository.getTasks())

		XCTAssertTrue((sut.completedTasks().filter { $0.isComplete == false }.isEmpty ), "Tasks have uncompleted task")
	}

	func test_uncompletedTasks_withTasksFromRepository_shouldBeNotEmpty() {
		sut.addTasks(tasks: taskRepository.getTasks())

		XCTAssertFalse(sut.uncompletedTasks().isEmpty, "Tasks must be not empty")
	}

	func test_uncompletedTasks_initialState_shouldBeEmpty() {
		XCTAssertTrue(sut.uncompletedTasks().isEmpty, "Tasks must be empty")
	}

	func test_uncompletedTasks_shouldGetArrayOfTaskType() {
		XCTAssertTrue((sut.uncompletedTasks() as Any) is [Task], "Tasks have another type")
	}

	func test_uncompletedTasks_withTasksFromRepository_shouldHaveOnlyUncompletedTasks() {
		sut.addTasks(tasks: taskRepository.getTasks())

		XCTAssertTrue((sut.uncompletedTasks().filter { $0.isComplete == true }.isEmpty ), "Tasks have completed task")
	}

	func testAddTaskShouldIReturnTaskCountPlusOneWhenAddOneTask() {
		let taskCount = sut.allTasks().count
		let task = RegularTask(title: "Task", isComplete: false)
		sut.addTask(task: task)

		XCTAssert(
			sut.allTasks().count == taskCount + 1,
			"Test failed: Number of tasks must be increased by one when one task added"
		)
	}

	func testAddTaskShouldIReturnTrueWhenCallConteinWithAddedTask() {
		let task = RegularTask(title: "Task", isComplete: false)
		sut.addTask(task: task)

		XCTAssert(sut.allTasks().contains { $0 === task }, "TaskManager should contain added task")
	}

	func testAddTasksShouldBeReturnCountOfAddedTasksWhenAddArrayOfTasks() {
		let taskCount = taskRepository.getTasks().count

		sut.addTasks(tasks: taskRepository.getTasks())

		XCTAssert(sut.allTasks().count == taskCount, "Test failed: Number of tasks must be equal added tasks array count")
	}

	func testRemoveTaskShouldBeReturn0CountWhenTaskRemoved() {
		let task = RegularTask(title: "Task", isComplete: false)
		sut.addTask(task: task)

		sut.removeTask(task: task)

		XCTAssert(
			sut.allTasks().count == Int.zero,
			"Test failed: Number of tasks must be 0"
		)
	}

	func testRemoveTaskShouldBeReturnFalseWhenCallConteinWithRemovedTask() {
		let task = RegularTask(title: "Task", isComplete: false)
		sut.addTask(task: task)

		sut.removeTask(task: task)

		XCTAssert(
			!sut.allTasks().contains { $0 === task },
			"Test failed: TaskManager should not contain removed task"
		)
	}
}
