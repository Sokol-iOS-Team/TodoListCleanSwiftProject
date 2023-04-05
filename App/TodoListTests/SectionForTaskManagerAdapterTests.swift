//
//  SectionForTaskManagerAdapterTests.swift
//  TodoListTests
//
//  Created by Владимир Свиридов on 19.03.2023.
//

import XCTest
@testable import TaskManagerPackage
@testable import TodoList

final class SectionForTaskManagerAdapterTests: XCTestCase {

	// MARK: - Internal Methods

	func test_getSections_shouldBeReturnedFirstUncompletedSectionThenCompleted() {
		let sut = makeSut()
		let validSections: [Section] = [.uncompleted, .completed]

		let result = sut.getSections()

		XCTAssertTrue(result.count == 2, "Секций больше или меньше двух")
		XCTAssertEqual(result, validSections, "Порядок секций отличается")
	}

	func test_getSectionIndex_forUncompletedSectionType_shouldBeReturnedZeroSectionIndex() {
		let sut = makeSut()
		let section: Section = .uncompleted

		let result = sut.getSectionIndex(section: section)

		XCTAssertTrue(result == 0, "У незавршенной секции индекс отличный от 0")
	}

	func test_getSectionIndex_forCompletedSectionType_shouldBeReturnedFirstSectionIndex() {
		let sut = makeSut()
		let section: Section = .completed

		let result = sut.getSectionIndex(section: section)

		XCTAssertTrue(result == 1, "Неправильный индекс секции, должен быть 1")
	}

	func test_getSectionIndex_forAllSectionType_shouldBeReturnedZeroSectionIndex() {
		let sut = makeSut()
		let section: Section = .all

		let result = sut.getSectionIndex(section: section)

		XCTAssertTrue(result == 0, "Индекс секции должен быть 0")
	}

	func test_getSection_withZeroIndex_shouldBeReturnedUncompletedSection() {
		let sut = makeSut()

		let result = sut.getSection(forIndex: 0)

		XCTAssertTrue(result == .uncompleted, "Незавершенная секция отличается от индекса 0")
	}

	func test_getSection_withFirstIndex_shouldBeReturnedCompletedSection() {
		let sut = makeSut()

		let result = sut.getSection(forIndex: 1)

		XCTAssertTrue(result == .completed, "Cекция с индексом 1 должна быть завершенной")
	}

	func test_getTasksForSection_shouldBeFourTasksAndOnlyCompleted() {
		let sut = makeSut()
		let validTasks = [
			MockOrderedTaskManager.completedHighImportantTask,
			MockOrderedTaskManager.completedMediumImportantTask,
			MockOrderedTaskManager.completedLowImportantTask,
			MockOrderedTaskManager.completedRegularTask
		]

		let result = sut.getTasksForSection(section: .completed)

		XCTAssertTrue(result.count == 4, "Завершенных задач больше 4 или меньше")
		XCTAssertEqual(result, validTasks, "Нарушен порядок задач")
	}

	func test_getTasksForSection_shouldBeOnlyUncompletedAndFourTasks() {
		let sut = makeSut()
		let validTasks = [
			MockOrderedTaskManager.uncompletedHighImportantTask,
			MockOrderedTaskManager.uncompletedMediumImportantTask,
			MockOrderedTaskManager.uncompletedLowImportantTask,
			MockOrderedTaskManager.uncompletedRegularTask
		]

		let result = sut.getTasksForSection(section: .uncompleted)

		XCTAssertTrue(result.count == 4, "Количество незавершенных задач отличается от 4")
		XCTAssertEqual(result, validTasks, "Очередность задач нарушена")
	}

	func test_getTasksForSection_shouldBeAllTasksAndEightTasks() {
		let sut = makeSut()
		let validTasks = [
			MockOrderedTaskManager.completedHighImportantTask,
			MockOrderedTaskManager.completedMediumImportantTask,
			MockOrderedTaskManager.completedLowImportantTask,
			MockOrderedTaskManager.completedRegularTask,
			MockOrderedTaskManager.uncompletedHighImportantTask,
			MockOrderedTaskManager.uncompletedMediumImportantTask,
			MockOrderedTaskManager.uncompletedLowImportantTask,
			MockOrderedTaskManager.uncompletedRegularTask
		]

		let result = sut.getTasksForSection(section: .all)

		XCTAssertTrue(result.count == 8, "Размер всех задач не равен 8")
		XCTAssertEqual(result, validTasks, "При выборке всех задач нарушена очередность")
	}

	func test_sectionTitle_withCompletedSection_shouldBeEqualCompletedTitle() {
		let validTitle = L10n.TodoList.completedSection

		let result: Section = .completed

		XCTAssertEqual(result.title, validTitle, "Некорректное название завершенной секции")
	}

	func test_sectionTitle_withUncompletedSection_shouldBeEqualUncompletedTitle() {
		let validTitle = L10n.TodoList.uncompletedSection

		let result: Section = .uncompleted

		XCTAssertEqual(result.title, validTitle, "Название незаврешенной секции отличается")
	}

	func test_sectionTitle_withAllSection_shouldBeEqualAllTitle() {
		let validTitle = L10n.TodoList.allSection

		let result: Section = .all

		XCTAssertEqual(result.title, validTitle, "Секция все имеет нерпавильное название")
	}
}

private extension SectionForTaskManagerAdapterTests {
	func makeSut() -> SectionForTaskManagerAdapter {
		let taskManager = MockOrderedTaskManager()
		let sut = SectionForTaskManagerAdapter(taskManager: taskManager)
		return sut
	}
}
