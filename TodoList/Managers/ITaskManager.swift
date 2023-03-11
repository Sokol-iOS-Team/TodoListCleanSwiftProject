//
//  ITaskManager+.swift
//  TodoList
//
//  Created by Kirill Leonov on 20.02.2023.
//

/// Протокол для TaskManager
protocol ITaskManager {
	func allTasks() -> [Task]
	func completedTasks() -> [Task]
	func uncompletedTasks() -> [Task]
	func addTasks(tasks: [Task])
}

extension TaskManager: ITaskManager { }

extension ImportantTask.TaskPriority: CustomStringConvertible {
	var description: String {
		switch self {
		case .high:
			return "!!!"
		case .medium:
			return "!!"
		case .low:
			return "!"
		}
	}
}
