//
//  TodoListPresenterTests.swift
//  TodoListTests
//
//  Created by Dmitry Troshkin on 24.03.2023.
//

import XCTest
@testable import TodoList
@testable import TaskManagerPackage

final class TodoListPresenterTests: XCTestCase {

	private let viewController = TodoListViewControllerSpy()

	func test_present_withEmptyResponce_shouldBeRenderSuccess() {
		let sut = makeSut()
		let response = TodoListModel.Response(data: [])

		sut.present(responce: response)

		XCTAssertTrue(viewController.isCalledRender, "Не вызван viewController.render(:)")
	}

	func test_present_withResponse1CompletedTask_shouldBeRenderWith1CompletedSectionWith1Task() {
		let sut = makeSut()
		let regularTask = RegularTask(title: "Regular Task", isComplete: true)
		let sectionWithTasks = TodoListModel.Response.SectionWithTasks(section: .completed, tasks: [regularTask])
		let response = TodoListModel.Response(data: [sectionWithTasks])

		sut.present(responce: response)

		let sectionCount = viewController.viewModel.tasksBySections.count
		let sectionTitle = viewController.viewModel.tasksBySections[0].title
		let taskCountInSection = viewController.viewModel.tasksBySections[0].tasks.count
		XCTAssertEqual(sectionCount, 1, "Ошибка в модели данных: некорретное количество секций")
		XCTAssertEqual(sectionTitle, "Completed", "Ошибка в модели данных: некорретный заголовок секции")
		XCTAssertEqual(taskCountInSection, 1, "Ошибка в модели данных: некорретное количество задач в секции")
	}

	func test_present_withResponse2UncompletedTasks_shouldBeRenderWith1UncompletedSectionWith2Tasks() {
		let sut = makeSut()
		let importantTask = ImportantTask(title: "Important Task", taskPriority: .high)
		let regularTask = RegularTask(title: "Regular Task", isComplete: false)
		let sectionWithTasks = TodoListModel.Response.SectionWithTasks(
			section: .uncompleted,
			tasks: [importantTask, regularTask]
		)
		let response = TodoListModel.Response(data: [sectionWithTasks])

		sut.present(responce: response)

		let sectionCount = viewController.viewModel.tasksBySections.count
		let sectionTitle = viewController.viewModel.tasksBySections[0].title
		let taskCountInSection = viewController.viewModel.tasksBySections[0].tasks.count
		XCTAssertEqual(sectionCount, 1, "Ошибка в модели данных: некорретное количество секций")
		XCTAssertEqual(sectionTitle, "Uncompleted", "Ошибка в модели данных: некорретный заголовок секции")
		XCTAssertEqual(taskCountInSection, 2, "Ошибка в модели данных: некорретное количество задач в секции")
	}

	func test_present_withResponse1CompletedRegularTask_shouldBeRenderCompletedRegularTaskCorrectly() {
		let sut = makeSut()
		let regularTask = RegularTask(title: "Regular Task", isComplete: true)
		let sectionWithTasks = TodoListModel.Response.SectionWithTasks(section: .completed, tasks: [regularTask])
		let response = TodoListModel.Response(data: [sectionWithTasks])

		sut.present(responce: response)

		if let task = viewController.viewModel.tasksBySections[0].tasks.first {
			switch task {
			case .regularTask(let regularTaskViewModel):
				XCTAssertEqual(
					regularTaskViewModel.name,
					"Regular Task",
					"Ошибка в модели данных: некорретное название задачи"
				)
				XCTAssertTrue(
					regularTaskViewModel.isDone,
					"Ошибка в модели данных: задача должна отображаться, как завершеная"
				)
			case .importantTask(_):
				XCTFail("Ошибка в модели данных: важная задача должна отсутствовать")
			}
		} else {
			XCTFail("Ошибка в модели данных: должна быть хотя бы одна задача")
		}
	}

	func test_present_withResponse1UncompletedImportantTask_shouldBeRenderUncompletedImportantTaskCorrectly() {
		let sut = makeSut()
		let importantTask = ImportantTask(title: "Important Task", taskPriority: .high)
		let sectionWithTasks = TodoListModel.Response.SectionWithTasks(section: .uncompleted, tasks: [importantTask])
		let response = TodoListModel.Response(data: [sectionWithTasks])

		sut.present(responce: response)

		if let task = viewController.viewModel.tasksBySections[0].tasks.first {
			switch task {
			case .regularTask(_):
				XCTFail("Ошибка в модели данных: регулярная задача должна отсутствовать")
			case .importantTask(let importantTaskViewModel):
				XCTAssertEqual(
					importantTaskViewModel.name,
					"Important Task",
					"Ошибка в модели данных: некорретное название задачи"
				)
				XCTAssertFalse(
					importantTaskViewModel.isDone,
					"Ошибка в модели данных: задача должна отображаться, как незавершеная"
				)
				XCTAssertFalse(
					importantTaskViewModel.isOverdue,
					"Ошибка в модели данных: задача должна отображаться, как просроченая"
				)
				XCTAssertEqual(
					importantTaskViewModel.deadLine,
					"Deadline: \(importantTask.deadLine)",
					"Ошибка в модели данных: поле даты завершения задачи сформировано некорректно"
				)
				XCTAssertEqual(
					importantTaskViewModel.priority,
					"\(importantTask.taskPriority)",
					"Ошибка в модели данных: поле приоритета задачи сформировано некорректно"
				)
			}
		} else {
			XCTFail("Ошибка в модели данных: должна быть хотя бы одна задача")
		}
	}
}

// MARK: - Private

private extension TodoListPresenterTests {
	func makeSut() -> TodoListPresenter {
		TodoListPresenter(viewController: viewController)
	}
}
