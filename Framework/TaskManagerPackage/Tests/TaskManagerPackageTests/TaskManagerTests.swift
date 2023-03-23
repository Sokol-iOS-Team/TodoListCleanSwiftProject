//
//  TaskManagerTests.swift
//  TodoListTests
//
//  Created by Владимир Свиридов и Вадим Гамзаев on 12.03.2023.
//

import XCTest
@testable import TaskManagerPackage

final class TaskManagerTests: XCTestCase {

	// MARK: - func allTasks()
	func test_allTasks_withTasksFromStub_shouldBeNotEmpty() {
		let sut = makeSut()
		
		sut.addTasks(tasks: TaskStub.tasks)

		XCTAssertFalse(
			sut.allTasks().isEmpty,
			"Возвращаемый массив задач, тасков, не должен быть пустым."
		)
	}

	func test_allTasks_initialState_shouldBeEmpty() {
		let sut = makeSut()
		
		XCTAssertTrue(
			sut.allTasks().isEmpty,
			"Инициализированный экземпляр класса TaskManager не должен содержать задач."
		)
	}

	func test_allTasks_shouldReturnArrayOfTaskType() {
		let sut = makeSut()
		
		XCTAssertTrue(
			(sut.allTasks() as Any) is [Task],
			"Обекты в возвращаемом массиве Tasks не соответсвуют типу Task.")
	}

	// MARK: - func completedTasks()
	func test_completedTasks_withTasksFromStub_shouldBeNotEmpty() {
		let sut = makeSut()
		
		sut.addTasks(tasks: TaskStub.tasks)

		XCTAssertFalse(
			sut.completedTasks().isEmpty,
			"Возвращаемый массив завершенных задач не должен быть пустым."
		)
	}

	func test_completedTasks_initialState_shouldBeEmpty() {
		let sut = makeSut()
		
		XCTAssertTrue(
			sut.completedTasks().isEmpty,
			"Инициализированный экземпляр класса TaskManager не должен содержать завершенных задач."
		)
	}

	func test_completedTasks_withTasksFromStub_shouldReturnArrayOfTaskType() {
		let sut = makeSut()
		
		sut.addTasks(tasks: TaskStub.tasks)
		
		XCTAssertTrue(
			(sut.completedTasks() as Any) is [Task],
			"Обекты в возвращаемом массиве Tasks не соответсвуют типу Task."
		)
	}

	func test_completedTasks_withTasksFromStub_shouldHaveOnlyComletedTasks() {
		let sut = makeSut()
		
		sut.addTasks(tasks: TaskStub.tasks)
		let uncompletedTasks = sut.completedTasks().filter { $0.isComplete == false }

		XCTAssertTrue(
			uncompletedTasks.isEmpty,
			"Массив Tasks должен содержать только завершенные задачи."
			)
	}

	// MARK: - func uncompletedTasks()
	func test_uncompletedTasks_withTasksFromStub_shouldBeNotEmpty() {
		let sut = makeSut()
		
		sut.addTasks(tasks: TaskStub.tasks)

		XCTAssertFalse(
			sut.uncompletedTasks().isEmpty,
			"Возвращаемый массив не завершенных задач не должен быть пустым."
		)
	}

	func test_uncompletedTasks_initialState_shouldBeEmpty() {
		let sut = makeSut()
		
		XCTAssertTrue(
			sut.uncompletedTasks().isEmpty,
			"Инициализированный экземпляр класса TaskManager не должен содержать завершенных задач."
			)
	}

	func test_uncompletedTasks_withTasksFromStub_shouldReturnArrayOfTaskType() {
		let sut = makeSut()
		
		sut.addTasks(tasks: TaskStub.tasks)
		
		XCTAssertTrue(
			(sut.uncompletedTasks() as Any) is [Task],
			"Обекты в возвращаемом массиве Tasks не соответсвуют типу Task."
		)
	}

	func test_uncompletedTasks_withTasksFromStub_shouldHaveOnlyUncompletedTasks() {
		let sut = makeSut()
		
		sut.addTasks(tasks: TaskStub.tasks)
		let completedTasks = sut.uncompletedTasks().filter { $0.isComplete == true }

		XCTAssertTrue(
			completedTasks.isEmpty,
			"Массив Tasks должен содержать только не завершенные задачи."
		)
	}

	// MARK: - func addTask()

	func test_addTask_withAddedNewSingleTask_ShouldIncreaseTheCounOfTasksByOne() {
		let sut = makeSut()
		
		let expectedTaskCount = sut.allTasks().count + 1
		let task = TaskStub.tasks[0]
		sut.addTask(task: task)

		XCTAssertEqual(
			expectedTaskCount,
			sut.allTasks().count,
			"При добавлении новой задачи, возвращаемое количество задач должно увеличится на 1"
		)
	}

	func test_addTask_withAddedNewSingleTask_ShouldConteinAddedTask() {
		let sut = makeSut()
		let task = TaskStub.tasks[0]
		
		sut.addTask(task: task)

		XCTAssertTrue(
			sut.allTasks().contains { $0 === task },
			"В возвращаемом массиве должна содержаться добавленная задача."
		)
	}

	// MARK: - func addTasks()
	func test_AddTasks_withTasksFromStub_ShouldBeReturnEqualTaskCount() {
		let sut = makeSut()
		
		let expectedTaskCount = TaskStub.tasks.count
		sut.addTasks(tasks: TaskStub.tasks)

		XCTAssertEqual(
			sut.allTasks().count,
			expectedTaskCount,
			"Количество возвращаемых задач должно соответствовать количеству добавленных"
		)
	}

	// MARK: - func removeTask()
	func test_removeTask_withTaskFromStub_ShouldBeReturnZeroCount() {
		let sut = makeSut()
		let task = TaskStub.tasks[0]
		sut.addTask(task: task)
		
		sut.removeTask(task: task)

		XCTAssertEqual(
			sut.allTasks().count,
			Int.zero,
			"После удаления задачи, количество возвращаемых задач должно ровняться нулю"
		)
	}

	func test_RemoveTask_ShouldNotContainRemovedTask() {
		let sut = makeSut()
		let task = TaskStub.tasks[0]
		sut.addTask(task: task)

		sut.removeTask(task: task)

		XCTAssertFalse(
			sut.allTasks().contains { $0 === task },
			"Возвращаемый массив задач не должен содержать удаленную задачу"
		)
	}
}

private extension TaskManagerTests {
	func makeSut() -> TaskManager {
		return TaskManager()
	}
}
