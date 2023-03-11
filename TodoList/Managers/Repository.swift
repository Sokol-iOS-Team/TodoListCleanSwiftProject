//
//  Repository.swift
//  TodoList
//
//  Created by Kirill Leonov on 20.02.2023.
//

protocol ITaskRepository {
	func getTasks() -> [Task]
}

final class TaskRepositoryStub: ITaskRepository {
	func getTasks() -> [Task] {
		[
			ImportantTask(title: "Do homework", taskPriority: .high),
			RegularTask(title: "Do Workout", isComplete: true),
			ImportantTask(title: "Write new tasks", taskPriority: .low),
			RegularTask(title: "Solve 3 algorithms"),
			ImportantTask(title: "Go shopping", taskPriority: .medium)
		]
	}
}
