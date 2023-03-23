//
//  TaskStub.swift
//  
//
//  Created by Вадим Гамзаев on 22.03.2023.
//

import Foundation

public enum TaskStub {
	static var singleTask = RegularTask(
			title: "SomeTask1",
			isComplete: true
		)
	static var tasks = [
			RegularTask(
				title: "SomeRegularTask1",
				isComplete: false
			),
			RegularTask(
				title: "SomeRegularTask2",
				isComplete: false
			),
			RegularTask(
				title: "SomeRegularTask3",
				isComplete: true
			),
			RegularTask(
				title: "SomeRegularTask4",
				isComplete: true
			),
			ImportantTask(
				title: "SomeImportantTask1",
				taskPriority: .high,
				createDate: Date()
			),
			ImportantTask(
				title: "SomeImportantTask2",
				taskPriority: .high,
				createDate: Date()
			)
		]
	}
