//
//  TaskManagerTests.swift
//  TaskManagerTests
//
//  Created by Вадим Гамзаев on 12.03.2023.
//

import XCTest
@testable import TodoList

final class TaskManagerTests: XCTestCase {
	var sut: TaskManager!
	
	enum TaskStub {
	static var someCompletedTask = RegularTask(
			title: "SomeTask1",
			isComplete: true
		)
	static var uncompletedTasksArray = [
			RegularTask(
				title: "SomeRegularTask1",
				isComplete: false
			),
			RegularTask(
				title: "SomeRegularTask1",
				isComplete: false
			),
			ImportantTask(
				title: "SomeImportantTask1",
				taskPriority: .high,
				createDate: Date()
			),
			ImportantTask(
				title: "SomeImportantTask2",
				taskPriority: .high,
				createDate: Date()
			)
		]
	}
	
	override func setUp() {
		super.setUp()
		sut = TaskManager()
	}
	
	override func tearDown()  {
		sut = nil
		super.tearDown()
	}
	
	func testAllTasksShouldReturnCorrectCountOfTasksWhenСompareWithStubCount() {
		sut.addTasks(tasks: TaskStub.uncompletedTasksArray)
		
		XCTAssert(
			sut.allTasks().count == TaskStub.uncompletedTasksArray.count,
			"Test failed: Number of all tasks does not match what is expected"
		)
	}
	
	func testCompletedTaskShouldBeReturn1WhenCallComletedTasksCount() {
		sut.addTasks(tasks: TaskStub.uncompletedTasksArray)
		sut.addTask(task: TaskStub.someCompletedTask)
		
		XCTAssert(
			sut.completedTasks().count == 1,
			"Test failed: Number of completed tasks does not match what is expected"
		)
	}
	
	func testUncompletedTaskShouldBeReturn4WhenCallUncomletedTasksCount() {
		sut.addTasks(tasks: TaskStub.uncompletedTasksArray)
		sut.addTask(task: TaskStub.someCompletedTask)
		
		XCTAssert(
			sut.uncompletedTasks().count == 4,
			"Test failed: Number of uncompleted tasks does not match what is expected"
		)
	}
	
	func testAddTaskShouldIReturn1WhenAddOneTask() {
		sut.addTask(task: TaskStub.someCompletedTask)
		
		XCTAssert(
			sut.allTasks().count == 1,
			"Test failed: Number of tasks must be increased by one when one task added"
		)
	}
	
	func testAddTasksShouldBeReturn4WhenAddArrayOfTasks() {
		sut.addTasks(tasks: TaskStub.uncompletedTasksArray)
		
		XCTAssert(
			sut.allTasks().count == 4,
			"Test failed: Number of tasks must be 4 when tasks array added"
		)
	}
	
	func testRemoveTaskShouldBeReturn0CountWhenTaskRemoved() {
		sut.addTask(task: TaskStub.someCompletedTask)
		
		sut.removeTask(task: TaskStub.someCompletedTask)
		
		XCTAssert(
			sut.allTasks().count == 0,
			"Test failed: Number of tasks must be 0"
		)
	}

	func testPerformanceExample() throws {
		// This is an example of a performance test case.
		measure {
			// Put the code you want to measure the time of here.
		}
	}
	
}
