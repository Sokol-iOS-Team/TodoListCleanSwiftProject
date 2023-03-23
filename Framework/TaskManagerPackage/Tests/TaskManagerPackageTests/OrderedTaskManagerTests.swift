//
//  OrderedTaskManagerTests.swift
//  TodoListTests
//
//  Created by Supodoco on 15.03.2023.
//

import XCTest
@testable import TaskManagerPackage

final class OrderedTaskManagerTests: XCTestCase {

	// MARK: AllTasks
	func test_allTasks_withTasksFromTaskStub_shouldBeNotEmpty() {
		let sut = makeSut()
		sut.addTasks(tasks: TaskStub.tasks)
		XCTAssertFalse(sut.allTasks().isEmpty, "sut.allTasks не содержит добавленных задач")
	}
	
	func test_allTasks_initialState_shouldBeEmpty() {
		let sut = makeSut()
		XCTAssertTrue(sut.allTasks().isEmpty, "sut.allTasks не должен содержать ни каких задач")
	}
	
	// MARK: UnCompletedTasks
	func test_unCompletedTasks_withTaskStub_shouldBeEmpty()  {
		let sut = makeSut()
		sut.addTasks(tasks: TaskStub.tasks)
		sut.allTasks().forEach { $0.isComplete = true }
		XCTAssertTrue(sut.uncompletedTasks().isEmpty, "sut.uncompletedTasks не должен содержать задачи")
	}
	
	func test_unCompletedTasks_withNewTask_shouldBeNotEmpty() {
		let sut = makeSut()
		let task = RegularTask(title: "do test", isComplete: false)
		sut.addTasks(tasks: [task])
		XCTAssertFalse(sut.uncompletedTasks().isEmpty, "sut.uncompletedTasks должен содержать задачи")
	}
	
	func test_unCompletedTasks_withTask_shouldBeNotEmpty() {
		let sut = makeSut()
		sut.addTasks(tasks: [RegularTask(title: "do something")])
		XCTAssertFalse(sut.uncompletedTasks().isEmpty, "sut.uncompletedTasks не должен быть пустым")
	}
	
	// MARK: CompletedTasks
	func test_completedTasks_withTaskRepository_shouldBeEmpty()  {
		let sut = makeSut()
		sut.addTasks(tasks: TaskStub.tasks)
		sut.allTasks().forEach { $0.isComplete = false }
		XCTAssertTrue(sut.completedTasks().isEmpty, "sut.completedTasks не должен содержать задачи")
	}
	
	func test_completedTasks_withNewTask_shouldBeNotEmpty() {
		let sut = makeSut()
		let task = RegularTask(title: "do test", isComplete: true)
		sut.addTasks(tasks: [task])
		XCTAssertFalse(sut.completedTasks().isEmpty, "sut.completedTasks не должен быть пустым")
	}
	
	func test_completedTasks_withTaskStub_shouldBeNotEmpty() {
		let sut = makeSut()
		sut.addTasks(tasks: [RegularTask(title: "test", isComplete: true)])
		XCTAssertFalse(sut.completedTasks().isEmpty, "sut.completedTasks не должен быть пустым")
	}

	// MARK: AddTasks
	func test_addTasks_withNewTask_shouldBeNotEmpty() {
		let sut = makeSut()
		let task = RegularTask(title: "do test")
		sut.addTasks(tasks: [task])
		XCTAssertFalse(sut.allTasks().isEmpty, "sut.allTasks должен содержать задачи")
	}
	
	func test_addTasks_withNewTask_comletedTasksShouldBeNotEmpty() {
		let sut = makeSut()
		let task = RegularTask(title: "do something", isComplete: true)
		sut.addTasks(tasks: [task])
		XCTAssertFalse(sut.completedTasks().isEmpty, "sut.completedTasks должен содержать задачи")
	}
	
	func test_addTasks_withNewTask_uncompletedTasksShouldBeNotEmpty() {
		let sut = makeSut()
		let task = RegularTask(title: "do homework", isComplete: false)
		sut.addTasks(tasks: [task])
		XCTAssertFalse(sut.uncompletedTasks().isEmpty, "sut.uncompletedTasks должен содержать задачи")
	}
	
	// MARK: Sorting
	func test_sorting_withCustomTasks_firstTaskShouldBeImportantTask() {
		let sut = makeSut()
		let regularTask = RegularTask(title: "do test")
		let importantTask = ImportantTask(title: "do another", taskPriority: .high)
		sut.addTasks(tasks: [regularTask, importantTask])
		XCTAssertTrue(sut.allTasks().first === importantTask, "Первая задача дожна быть ImportantTask")
	}
	
	func test_sorting_withCustomTasks_firstShouldBeTaskWithHighPriority() {
		let sut = makeSut()
		let lowPriorityTask = ImportantTask(title: "do test", taskPriority: .low)
		let highPriorityTask = ImportantTask(title: "do another", taskPriority: .high)
		sut.addTasks(tasks: [lowPriorityTask, highPriorityTask])
		XCTAssertTrue(sut.allTasks().first === highPriorityTask, "Первая задача должна быть ImportantTask с высоким приоритетом")
	}
	
	func test_sorting_withCustomTasks_firstShouldBeReturnLastAddedTask() {
		let sut = makeSut()
		let firstTask = RegularTask(title: "do test")
		let secondTask = RegularTask(title: "do another test")
		sut.addTasks(tasks: [firstTask, secondTask])
		XCTAssertTrue(sut.uncompletedTasks().first === secondTask, "Первая задача должна быть последняя добавленная")
	}
	
	func test_sorting_with3Tasks_tasksShouldBeInRightPosition() {
		let sut = makeSut()
		let mediumPriorityTask = ImportantTask(title: "do test", taskPriority: .medium)
		let highPriorityTask = ImportantTask(title: "do another", taskPriority: .high)
		let regularTask = RegularTask(title: "do test")
		let sortedTasks = [highPriorityTask, mediumPriorityTask, regularTask]
		
		sut.addTasks(tasks: [regularTask, highPriorityTask, mediumPriorityTask])
		
		XCTAssertEqual(sortedTasks, sut.allTasks(), "Задачи отсортированы неверно")
	}
}

private extension OrderedTaskManagerTests {
	func makeSut() -> OrderedTaskManager {
		OrderedTaskManager(taskManager: TaskManager())
	}
}
