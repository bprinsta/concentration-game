//
//  ThemeColors.swift
//  Concentration
//
//  Created by Benjamin Musoke-Lubega on 12/17/19.
//  Copyright © 2019 Ben Musoke-Lubega. All rights reserved.
//

import UIKit

struct ScoringValues {
	static let correctMatch = 60
	static let wrongMatch = 40
	static let timeBonusHigh = 30
	static let timeBonusLow = 20
}

struct ThemeColors {
	// Main Theme Colors
	static let white = UIColor(hex: 0xFDFFFC)
	static let navyBlue = UIColor(hex: 0x022a4b)
	static let teal = UIColor(hex: 0x98e7df)
	
	// Brown Theme Colors
	static let brown = UIColor(hex: 0x856c56)
	static let darkCream = UIColor(hex: 0xffdeb3)
	static let cream = UIColor(hex: 0xfff4e6)
	
	// Green Theme Colors
	static let green = UIColor(hex: 0xc8d5b9)
	static let forestCream = UIColor(hex: 0xFAF3DD)
	static let darkGreen = UIColor(hex: 0x4A7C59)
	
	// Blue & Brown Theme Colors
	static let beachBlue = UIColor(hex: 0xb3d6ff)
	static let lightBeachBlue = UIColor(hex: 0xe3f0ff)
	static let beachCream = UIColor(hex: 0x663d00)
}

struct ThemeEmojis {
	static let faces = ["😎", "🤪", "😁", "😍", "🤑", "😷", "😫", "🤩", "😅", "🤐", "😛", "😬"]
	static let animals = ["🐶", "🐱", "🐭", "🐷", "🐮", "🐨", "🙉", "🦊", "🐻", "🐸", "🐙", "🐼"]
	static let fruit = ["🍎", "🍐", "🌶", "🥦", "🍆", "🥑", "🍌", "🍇", "🍑", "🌽", "🍉", "🍒"]
	static let space = ["🌝", "🌗", "🌎", "🌚", "🌙", "💫", "🌍", "🌓", "⭐️", "🌛", "☄️", "✨"]
	static let sports = ["⚽️", "🏀", "🏈", "🎳", "🏒", "🏐", "🥊", "🎾", "🎱", "🏓", "🏸", "⛳️"]
	static let nature = ["🌵", "🌲", "🌳", "🌴", "🎋", "💐", "🍀", "🍁", "🍄", "🥀", "🌸", "🌻"]
	static let random = ["👹", "💩", "👅", "👀", "💄", "💊", "🧠", "👑", "🎩", "🎁", "💡", "⚱️"]	
}

extension UIColor {
	convenience init(red: Int, green: Int, blue: Int) {
		assert(red >= 0 && red <= 255, "Invalid red component")
		assert(green >= 0 && green <= 255, "Invalid green component")
		assert(blue >= 0 && blue <= 255, "Invalid blue component")
		
		self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
	}
	
	convenience init(hex: Int) {
		self.init(
			red: (hex >> 16) & 0xFF,
			green: (hex >> 8) & 0xFF,
			blue: hex & 0xFF
		)
	}
}
