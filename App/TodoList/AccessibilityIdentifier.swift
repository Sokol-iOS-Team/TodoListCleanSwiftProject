//
//  AccessibilityIdentifier.swift
//  TodoList
//
//  Created by Dmitry Troshkin on 04.04.2023.
//

import Foundation

enum AccessibilityIdentifier {
	enum Login {
		static let textFieldLogin = "textFieldLogin"
		static let textFieldPass = "textFieldPass"
		static let buttonLogin = "buttonLogin"
	}

	enum TodoList {
		static let tableView = "tableView"
		static let firstSectionHeader = "firstSectionHeader"
		static let secondSectionHeader = "secondSectionHeader"
		static func tableViewCell(indexPath: IndexPath) -> String {
			"cell-\(indexPath.section)-\(indexPath.row)"
		}
	}
}
