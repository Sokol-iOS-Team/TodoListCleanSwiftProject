//
//  Sizes.swift
//  TodoList
//
//  Created by Вадим Гамзаев on 31.03.2023.
//
import Foundation
import PinLayout

enum Sizes {
	static let cornerRadius: CGFloat = 6
	static let borderWidth: CGFloat = 1
	static let topOffset: Percent = 30%
	
	enum Padding {
		static let half: CGFloat = 8
		static let normal: CGFloat = 16
		static let double: CGFloat = 32
	}
	
	enum L { // swiftlint:disable:this type_name
		static let maxWidth: Percent = 90%
		static let width: CGFloat = 200
		static let height: CGFloat = 50
	}
	
	enum M { // swiftlint:disable:this type_name
		static let maxWidth: Percent = 80%
		static let width: CGFloat = 100
		static let height: CGFloat = 40
	}
	
	enum S { // swiftlint:disable:this type_name
		static let maxWidth: Percent = 60%
		static let width: CGFloat = 80
		static let height: CGFloat = 30
	}
}
