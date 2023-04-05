//
//  SectionForTaskManagerAdapter.swift
//  TodoList
//
//  Created by Kirill Leonov on 20.02.2023.
//
import TaskManagerPackage
import Foundation

protocol ISectionForTaskManagerAdapter {
	func getSections() -> [Section]
	func getTasksForSection(section: Section) -> [Task]
	func getSectionIndex(section: Section) -> Int
	func getSection(forIndex index: Int) -> Section
}

enum Section: CaseIterable {
	case completed
	case uncompleted
	case all

	var title: String {
		switch self {
		case .completed:
			return L10n.TodoList.completedSection // NSLocalizedString("TodoList.completedSection", comment: "")
		case .uncompleted:
			return L10n.TodoList.uncompletedSection // NSLocalizedString("TodoList.uncompletedSection", comment: "")
		case .all:
			return L10n.TodoList.allSection // NSLocalizedString("TodoList.allSection", comment: "")
		}
	}
}

final class SectionForTaskManagerAdapter: ISectionForTaskManagerAdapter {

	private let sections: [Section] = [.uncompleted, .completed]

	private let taskManager: ITaskManager

	init(taskManager: ITaskManager) {
		self.taskManager = taskManager
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
			return taskManager.completedTasks()
		case .uncompleted:
			return taskManager.uncompletedTasks()
		case .all:
			return taskManager.allTasks()
		}
	}
}
