//
//  OrderedTaskManagerTests.swift
//  TodoListTests
//
//  Created by Supodoco on 15.03.2023.
//

import XCTest
@testable import TaskManagerPackage

final class OrderedTaskManagerTests: XCTestCase {
	
	var sut: ITaskManager!
	var taskManager: ITaskManager!
	
	enum TaskStub {
		static var tasks = [
				RegularTask(
					title: "SomeRegularTask1",
					isComplete: false
				),
				RegularTask(
					title: "SomeRegularTask2",
					isComplete: false
				),
				RegularTask(
					title: "SomeRegularTask3",
					isComplete: true
				),
				RegularTask(
					title: "SomeRegularTask4",
					isComplete: true
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
		taskManager = TaskManager()
		sut = OrderedTaskManager(taskManager: taskManager)
	}
	
	override func tearDown() {
		sut = nil
		taskManager = nil
		super.tearDown()
	}
	
	// MARK: AllTasks
	func test_allTasks_withTasksFromTaskStub_shouldBeNotEmpty() {
		sut.addTasks(tasks: TaskStub.tasks)
		XCTAssertFalse(sut.allTasks().isEmpty, "Tasks must be not empty")
	}
	
	func test_allTasks_initialState_shouldBeEmpty() {
		XCTAssertTrue(sut.allTasks().isEmpty, "Tasks must be empty")
	}
	
	// MARK: UnCompletedTasks
	func test_unCompletedTasks_withTaskStub_shouldBeEmpty()  {
		sut.addTasks(tasks: TaskStub.tasks)
		sut.allTasks().forEach { $0.isComplete = true }
		XCTAssertTrue(sut.uncompletedTasks().isEmpty, "Uncomleted tasks should be empty")
	}
	
	func test_unCompletedTasks_withNewTask_shouldBeNotEmpty() {
		let task = RegularTask(title: "do test", isComplete: false)
		sut.addTasks(tasks: [task])
		XCTAssertFalse(sut.uncompletedTasks().isEmpty, "Uncompleted task should be not empty")
	}
	
	func test_unCompletedTasks_withTaskStub_shouldBeNotEmpty() {
		sut.addTasks(tasks: TaskStub.tasks)
		XCTAssertFalse(!sut.uncompletedTasks().isEmpty, "Uncompleted tasks must be not empty")
	}
	
	// MARK: CompletedTasks
	func test_completedTasks_withTaskRepository_shouldBeEmpty()  {
		sut.addTasks(tasks: TaskStub.tasks)
		sut.allTasks().forEach { $0.isComplete = false }
		XCTAssertTrue(sut.completedTasks().isEmpty, "Completed tasks should be empty")
	}
	
	func test_completedTasks_withNewTask_shouldBeNotEmpty() {
		let task = RegularTask(title: "do test", isComplete: true)
		sut.addTasks(tasks: [task])
		XCTAssertFalse(sut.completedTasks().isEmpty, "Completed task should be not empty")
	}
	
	func test_completedTasks_withTaskStub_shouldBeNotEmpty() {
		sut.addTasks(tasks: TaskStub.tasks)
		XCTAssertFalse(!sut.completedTasks().isEmpty, "Completed tasks must be not empty")
	}
	
	// MARK: AddTasks
	func test_addTasks_withNewTask_shouldBeNotEmpty() {
		let task = RegularTask(title: "do test")
		sut.addTasks(tasks: [task])
		XCTAssertFalse(sut.allTasks().isEmpty, "Tasks must be not empty")
	}
	
	func test_addTasks_withNewTask_comletedTasksShouldBeNotEmpty() {
		let task = RegularTask(title: "do something", isComplete: true)
		sut.addTasks(tasks: [task])
		XCTAssertFalse(sut.completedTasks().isEmpty, "Completed tasks must be not empty")
	}
	
	func test_addTasks_withNewTask_uncompletedTasksShouldBeNotEmpty() {
		let task = RegularTask(title: "do homework", isComplete: false)
		sut.addTasks(tasks: [task])
		XCTAssertFalse(sut.uncompletedTasks().isEmpty, "Uncompleted tasks must be not empty")
	}
	
	// MARK: Sorting
	func test_sorted_withCustomTasks_firstTaskShouldBeImportantTask() {
		let regularTask = RegularTask(title: "do test")
		let importantTask = ImportantTask(title: "do another", taskPriority: .high)
		sut.addTasks(tasks: [regularTask, importantTask])
		XCTAssertTrue(sut.allTasks().first === importantTask, "First task must be ImportantTask")
	}
	
	func test_sorted_withCustomTasks_firstShouldBeTaskWithHighPriority() {
		let lowPriorityTask = ImportantTask(title: "do test", taskPriority: .low)
		let highPriorityTask = ImportantTask(title: "do another", taskPriority: .high)
		sut.addTasks(tasks: [lowPriorityTask, highPriorityTask])
		XCTAssertTrue(sut.allTasks().first === highPriorityTask, "First Task should be ImportantTask with high priority")
	}
	
	func test_sorted_withCustomTasks_firstShouldBeReturnLastAddedTask() {
		let firstTask = RegularTask(title: "do test")
		let secondTask = RegularTask(title: "do another test")
		sut.addTasks(tasks: [firstTask, secondTask])
		XCTAssertTrue(sut.uncompletedTasks().first === secondTask, "First task should be last added task")
	}
	
}
