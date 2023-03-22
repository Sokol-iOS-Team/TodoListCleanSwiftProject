//
//  RegularTaskTests.swift
//  RegularTaskTests
//
//  Created by Supodoco on 11.03.2023.
//

import XCTest
@testable import TaskManagerPackage

final class RegularTaskTests: XCTestCase {
	
	var task: RegularTask?
	
	override func setUp() {
		super.setUp()
		task = RegularTask(title: "do tests")
	}
	
	override func tearDown()  {
		task = nil
		super.tearDown()
	}
	
	func testChangeTitleShouldBeNotEqualWhenGetNewValue() {
		let taskTitle = task?.title
		task?.title = "do unit tests"
		XCTAssertNotEqual(task?.title, taskTitle)
	}
	
	func testIsCompleteShouldBeNotEqualWhenGetNewValue() {
		let isComplete = task?.isComplete
		task?.isComplete.toggle()
		XCTAssertNotEqual(task?.isComplete, isComplete)
	}
	
	func testIsCompleteShouldBeEqualFalse() {
		XCTAssertEqual(task?.isComplete, false)
	}
	
}
