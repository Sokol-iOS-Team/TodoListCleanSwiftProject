//
//  OrderedTaskManagerMock.swift
//  TodoListTests
//
//  Created by Владимир Свиридов on 21.03.2023.
//

import Foundation
@testable import TaskManagerPackage

class MockOrderedTaskManager: ITaskManager {
	// MARK: - Internal Static Properties
	static let completedHighImportantTask = ImportantTask(title: "ITask0", isComplete: true, taskPriority: .high)
	static let completedMediumImportantTask = ImportantTask(title: "ITask1", isComplete: true, taskPriority: .medium)
	static let completedLowImportantTask = ImportantTask(title: "ITask2", isComplete: true, taskPriority: .low)
	static let completedRegularTask = RegularTask(title: "RTask0", isComplete: true)
	static let uncompletedHighImportantTask = ImportantTask(title: "ITask3", taskPriority: .high)
	static let uncompletedMediumImportantTask = ImportantTask(title: "ITask4", taskPriority: .medium)
	static let uncompletedLowImportantTask = ImportantTask(title: "ITask5", taskPriority: .low)
	static let uncompletedRegularTask = RegularTask(title: "RTask1")

	// MARK: - Internal Methods
	func allTasks() -> [TaskManagerPackage.Task] {
		[
			MockOrderedTaskManager.completedHighImportantTask,
			MockOrderedTaskManager.completedMediumImportantTask,
			MockOrderedTaskManager.completedLowImportantTask,
			MockOrderedTaskManager.completedRegularTask,
			MockOrderedTaskManager.uncompletedHighImportantTask,
			MockOrderedTaskManager.uncompletedMediumImportantTask,
			MockOrderedTaskManager.uncompletedLowImportantTask,
			MockOrderedTaskManager.uncompletedRegularTask
		]
	}

	func completedTasks() -> [TaskManagerPackage.Task] {
		[
			MockOrderedTaskManager.completedHighImportantTask,
			MockOrderedTaskManager.completedMediumImportantTask,
			MockOrderedTaskManager.completedLowImportantTask,
			MockOrderedTaskManager.completedRegularTask
		]
	}

	func uncompletedTasks() -> [TaskManagerPackage.Task] {
		[
			MockOrderedTaskManager.uncompletedHighImportantTask,
			MockOrderedTaskManager.uncompletedMediumImportantTask,
			MockOrderedTaskManager.uncompletedLowImportantTask,
			MockOrderedTaskManager.uncompletedRegularTask
		]
	}

	func addTasks(tasks: [TaskManagerPackage.Task]) {
		fatalError("Not implemented")
	}
}
