//
//  SectionHeaderView.swift
//  TodoList
//
//  Created by Вадим Гамзаев on 11.04.2023.
//

import UIKit
import PinLayout

class SectionHeaderView: UITableViewHeaderFooterView {
	private lazy var headerLabel = makeLabel()

	override init(reuseIdentifier: String?) {
		super.init(reuseIdentifier: reuseIdentifier)
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupContainerView()
	}
	
	override func layoutSubviews() {
		setupContainerView()
	}

	private func setupContainerView() {
		self.addSubview(headerLabel)
		headerLabel.translatesAutoresizingMaskIntoConstraints = false
		headerLabel
			.pin
			.top()
			.bottom()
			.right()
			.left(20)
	}

	func configure(text: String, accessibilityIdentifier: String) {
		headerLabel.text = text
		headerLabel.accessibilityIdentifier = accessibilityIdentifier
		layoutIfNeeded()
	}
	
	func makeLabel() -> UILabel {
		let label = UILabel()
		label.font = UIFont.preferredFont(forTextStyle: .headline)
		label.textColor = .lightGray
		
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}
}
