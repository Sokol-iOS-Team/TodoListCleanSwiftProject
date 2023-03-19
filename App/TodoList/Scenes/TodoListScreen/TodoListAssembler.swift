//
//  TodoListAssembler.swift
//  TodoList
//
//  Created by Kirill Leonov on 01.03.2023.
//

import UIKit
import TaskManagerPackage

final class TodoListAssembler {
	func assembly() -> UIViewController {
		let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
		guard let viewController = storyboard.instantiateViewController(withIdentifier: "TodoListViewController") as?
				TodoListViewController
		else {
			fatalError("Нету на Main.storyboard TodoListViewController!")
		}

		let taskManager = OrderedTaskManager(taskManager: TaskManager())
		let repository: ITaskRepository = TaskRepositoryStub()
		taskManager.addTasks(tasks: repository.getTasks())
		let sectionForTaskManagerAdapter = SectionForTaskManagerAdapter(taskManager: taskManager)

		let presenter = TodoListPresenter(viewController: viewController)
		let interactor = TodoListInteractor(sectionManager: sectionForTaskManagerAdapter, presenter: presenter)
		viewController.interactor = interactor

		return viewController
	}
}
