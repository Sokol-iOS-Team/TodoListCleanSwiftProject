//
//  Tasks.swift
//  TodoList
//
//  Created by Kirill Leonov on 20.02.2023.
//

import Foundation

/// Задание, для ведения списка дел.
class Task {

	/// Наименование задания.
	var title: String

	/// Состояние задания -- выполнено ли задание.
	var isComplete = false

	init(title: String, isComplete: Bool = false) {
		self.title = title
		self.isComplete = isComplete
	}
}

/// Обычное задание.
final class RegularTask: Task { }

/// Важное задание с приоритетом.
final class ImportantTask: Task {

	/// Приоритет задания. Приоритет влияет на крайний срок выполнения задания.
	enum TaskPriority: Int {
		/// Низкий приоритет. На выполнение задания с низким приоритетом, отводится 3 дня.
		case low
		/// Средний приоритет. На выполнение задания со средним приоритетом, отводится 2 дня.
		case medium
		/// Высокий приоритет. На выполнение задания с высоким приоритетом, отводится 1 день.
		case high
	}

	/// Крайний срок выполнения задания.
	var deadLine: Date {
		switch taskPriority {
		case .low:
			guard let date = Calendar.current.date(byAdding: .day, value: 3, to: createDate)
			else { fatalError("Deadline date is not exist")}
			return date
		case .medium:
			guard let date = Calendar.current.date(byAdding: .day, value: 2, to: createDate)
			else { fatalError("Deadline date is not exist")}
			return date
		case .high:
			guard let date = Calendar.current.date(byAdding: .day, value: 1, to: createDate)
			else {fatalError("Deadline date is not exist")}
			return date
		}
	}

	private let createDate: Date

	/// Приоритет задания.
	var taskPriority: TaskPriority

	init(title: String, taskPriority: TaskPriority, createDate: Date = Date()) {
		self.taskPriority = taskPriority
		self.createDate = createDate
		super.init(title: title)
	}
}
