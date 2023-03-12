//
//  TaskManagerTests.swift
//  TodoListTests
//
//  Created by Владимир Свиридов on 12.03.2023.
//

import XCTest
@testable import TodoList

final class TaskManagerTests: XCTestCase {
	
	var sut: ITaskManager!
	var taskRepository: ITaskRepository!
	
	override func setUp() {
		sut = TaskManager()
		taskRepository = TaskRepositoryStub()
	}
	
	override func tearDown() {
		sut = nil
		taskRepository = nil
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
}
