//
//  SectionHeaderView.swift
//  TodoList
//
//  Created by Вадим Гамзаев on 11.04.2023.
//

import UIKit
import PinLayout

class SectionHeaderView: UITableViewHeaderFooterView {
	
	// MARK: - Private properties

	private lazy var headerLabel = makeLabel()

	// MARK: - Lifecycle
	
	override init(reuseIdentifier: String?) {
		super.init(reuseIdentifier: reuseIdentifier)
		
		addSubviews()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	override func layoutSubviews() {
		headerLabel
			.pin
			.top()
			.bottom()
			.right()
			.left(20)	}
	
	// MARK: - Internal methods
	
	func configure(text: String, accessibilityIdentifier: String) {
		headerLabel.text = text
		headerLabel.accessibilityIdentifier = accessibilityIdentifier
		layoutIfNeeded()
	}
	
	// MARK: - Private methods
	private func addSubviews() {
		addSubview(headerLabel)
	}

	private func makeLabel() -> UILabel {
		let label = UILabel()
		label.font = UIFont.preferredFont(forTextStyle: .headline)
		label.textColor = .lightGray
		
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}
}
