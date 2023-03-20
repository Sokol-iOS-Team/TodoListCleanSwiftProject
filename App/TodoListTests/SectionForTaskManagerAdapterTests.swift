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

    var sut: SectionForTaskManagerAdapter?
    var taskManager: OrderedTaskManager?

    enum TaskStub {
        static var singleTask = RegularTask(
            title: "SomeTask1",
            isComplete: false
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

    override func setUp() {
        super.setUp()
        let taskManager = OrderedTaskManager(taskManager: TaskManager())
        sut = SectionForTaskManagerAdapter(taskManager: taskManager)
        self.taskManager = taskManager
    }

    override func tearDown() {
        sut = nil
        taskManager = nil
        super.tearDown()
    }

    func test_getSections_initialState_shouldBeNotEmpty() {
        XCTAssertFalse(sut?.getSections().isEmpty == true, "Sections must be not empty")
    }

    func test_getSections_initialState_shouldBeNotNil() {
        XCTAssertNotNil(sut?.getSections(), "Sections must be not nil")
    }

    func test_getSections_initialState_shouldGetArrayOfSectionType() {
        XCTAssertTrue((sut?.getSections() as Any) is [Section], "Sections have another type")
    }

    func test_getSectionIndex_initialState_shouldBeCompletedNotNil() {
        let section: Section = .completed

        XCTAssertNotNil(sut?.getSectionIndex(section: section), "Completed section index can't be nil")
    }

    func test_getSectionIndex_initialState_shouldBeUncompletedNotNil() {
        let section: Section = .uncompleted

        XCTAssertNotNil(sut?.getSectionIndex(section: section), "Uncompleted section index can't be nil")
    }

    func test_getSectionIndex_initialState_shouldGetIntType() {
        let section = sut?.getSections().first ?? .completed

        XCTAssertTrue((sut?.getSectionIndex(section: section) as Any) is Int, "Section index must have int type")
    }

    func test_getSectionIndex_initialState_shouldBeEqualCompletedSectionIndex() {
        let section: Section = .completed
        let sectionIndex = sut?.getSections().firstIndex(where: { $0 == section })

        XCTAssertTrue(
            sut?.getSectionIndex(section: section) == sectionIndex,
            "Completed section index is not equal real compelted section index"
        )
    }

    func test_getSectionIndex_initialState_shouldBeEqualUncompletedSectionIndex() {
        let section: Section = .uncompleted
        let sectionIndex = sut?.getSections().firstIndex(where: { $0 == section })

        XCTAssertTrue(
            sut?.getSectionIndex(section: section) == sectionIndex,
            "Uncompleted section index is not equal real uncompelted section index"
        )
    }

    func test_getSection_initialState_shouldBeCompletedNotNil() {
        let section: Section = .completed
        let sectionIndex = sut?.getSections().firstIndex(where: { $0 == section }) ?? 0

        XCTAssertNotNil(sut?.getSection(forIndex: sectionIndex), "Completed section can't be nil")
    }

    func test_getSection_initialState_shouldBeUncompletedNotNil() {
        let section: Section = .uncompleted
        let sectionIndex = sut?.getSections().firstIndex(where: { $0 == section }) ?? 0

        XCTAssertNotNil(sut?.getSection(forIndex: sectionIndex), "Uncompleted section can't be nil")
    }

    func test_getSection_initialState_shouldGetSectionType() {
        let section = sut?.getSections().first ?? .completed
        let sectionIndex = sut?.getSections().firstIndex(where: { $0 == section }) ?? 0

        XCTAssertTrue((sut?.getSection(forIndex: sectionIndex) as Any) is Section, "Section must have section type")
    }

    func test_getSection_initialState_shouldBeEqualCompletedSection() {
        let section: Section = .completed
        let sectionIndex = sut?.getSections().firstIndex(where: { $0 == section }) ?? 0

        XCTAssertTrue(
            sut?.getSection(forIndex: sectionIndex) == section,
            "Completed section is not equal real compelted section"
        )
    }

    func test_getSection_initialState_shouldBeEqualUncompletedSection() {
        let section: Section = .uncompleted
        let sectionIndex = sut?.getSections().firstIndex(where: { $0 == section }) ?? 0

        XCTAssertTrue(
            sut?.getSection(forIndex: sectionIndex) == section,
            "Uncompleted section is not equal real uncompelted section"
        )
    }

    func test_getTasksForSection_initialState_shouldBeCompletedSectionNotNil() {
        let section: Section = .completed

        XCTAssertNotNil(sut?.getTasksForSection(section: section), "Completed section can't be nil")
    }

    func test_getTasksForSection_initialState_shouldBeUncompletedSectionNotNil() {
        let section: Section = .uncompleted

        XCTAssertNotNil(sut?.getTasksForSection(section: section), "Uncompleted section can't be nil")
    }

    func test_getTasksForSection_initialState_shouldBeAllSectionNotNil() {
        let section: Section = .all

        XCTAssertNotNil(sut?.getTasksForSection(section: section), "All section can't be nil")
    }

    func test_getTasksForSection_initialState_shouldGetArrayOfTaskType() {
        let section: Section = .all

        XCTAssertTrue((sut?.getTasksForSection(section: section) as Any) is [Task], "Tasks have another type")
    }

    func test_getTasksForSection_withTasks_shouldHaveOnlyCompletedTasks() {
        taskManager?.addTasks(tasks: TaskStub.tasks)
        let section: Section = .completed

        XCTAssertTrue(
            sut?.getTasksForSection(section: section).filter { $0.isComplete == false }.isEmpty == true,
            "Tasks have uncompleted task"
        )
    }

    func test_getTasksForSection_withTasks_shouldHaveOnlyUncompletedTasks() {
        taskManager?.addTasks(tasks: TaskStub.tasks)
        let section: Section = .uncompleted

        XCTAssertTrue(
            sut?.getTasksForSection(section: section).filter { $0.isComplete == true }.isEmpty == true,
            "Tasks have completed task"
        )
    }

    func test_taskSectionAndIndex_initialState_shouldBeNil() {
        let task = TaskStub.singleTask

        XCTAssertNil(sut?.taskSectionAndIndex(task: task), "Tuple must be nil")
    }

    func test_taskSectionAndIndex_initialState_shouldGetTupleOfSectionAndIndexType() {
        let task = TaskStub.singleTask

        XCTAssertTrue(
            (sut?.taskSectionAndIndex(task: task) as Any) is (section: Section, index: Int)?,
            "Tuple has another type"
        )
    }

    func test_taskSectionAndIndex_withTasks_shouldBeNotNil() {
        let task = TaskStub.singleTask
        taskManager?.addTasks(tasks: [task])

        XCTAssertNotNil(sut?.taskSectionAndIndex(task: task), "Tuple must be not nil")
    }
}
