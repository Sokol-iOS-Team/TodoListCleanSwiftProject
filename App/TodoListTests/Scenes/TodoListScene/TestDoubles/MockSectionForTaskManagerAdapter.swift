//
//  MockSectionForTaskManagerAdapter.swift
//  TodoListTests
//
//  Created by Вадим Гамзаев on 25.03.2023.
//

@testable import TodoList
@testable import TaskManagerPackage

class MockSectionForTaskManagerAdapter: ISectionForTaskManagerAdapter {
	// MARK: - Private Properties
	private let sections: [Section] = [.uncompleted, .completed]

	// MARK: - Internal Static Properties
	static let completedHighImportantTask = ImportantTask(title: "ITask0", isComplete: true, taskPriority: .high)
	static let completedMediumImportantTask = ImportantTask(title: "ITask1", isComplete: true, taskPriority: .medium)
	static let completedLowImportantTask = ImportantTask(title: "ITask2", isComplete: true, taskPriority: .low)
	static let completedRegularTask = RegularTask(title: "RTask0", isComplete: true)
	static let uncompletedHighImportantTask = ImportantTask(title: "ITask3", taskPriority: .high)
	static let uncompletedMediumImportantTask = ImportantTask(title: "ITask4", taskPriority: .medium)
	static let uncompletedLowImportantTask = ImportantTask(title: "ITask5", taskPriority: .low)
	static let uncompletedRegularTask = RegularTask(title: "RTask1")

	// MARK: - Private Methods
	private func completedTasks() -> [TaskManagerPackage.Task] {
		[
			MockSectionForTaskManagerAdapter.completedHighImportantTask,
			MockSectionForTaskManagerAdapter.completedMediumImportantTask,
			MockSectionForTaskManagerAdapter.completedLowImportantTask,
			MockSectionForTaskManagerAdapter.completedRegularTask
		]
	}

	private func uncompletedTasks() -> [TaskManagerPackage.Task] {
		[
			MockSectionForTaskManagerAdapter.uncompletedHighImportantTask,
			MockSectionForTaskManagerAdapter.uncompletedMediumImportantTask,
			MockSectionForTaskManagerAdapter.uncompletedLowImportantTask,
			MockSectionForTaskManagerAdapter.uncompletedRegularTask
		]
	}

	func getSections() -> [Section] {
		sections
	}

	func getSectionIndex(section: Section) -> Int {
		sections.firstIndex(of: section) ?? 0
	}

	func getSection(forIndex index: Int) -> Section {
		let index = min(index, sections.count - 1)
		return sections[index]
	}

	func getTasksForSection(section: Section) -> [Task] {
		switch section {
		case .completed:
			return completedTasks()
		case .uncompleted:
			return uncompletedTasks()
		case .all:
			return completedTasks() + uncompletedTasks()
		}
	}
}
