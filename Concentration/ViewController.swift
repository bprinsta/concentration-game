//
//  ViewController.swift
//  Concentration
//
//  Created by Benjamin Musoke-Lubega on 10/16/19.
//  Copyright © 2019 Ben Musoke-Lubega. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	private lazy var game = Concentration(numPairsOfCards: numberOfPairsOfCards)
	
	var numberOfPairsOfCards: Int {
			return (cardButtons.count + 1) / 2
	}
	
	private var themeBackgroundColor: UIColor?
	private var themeCardColor: UIColor?
	private var themeCardTitles: [String]?
	private var emoji = [Int: String]()
	
	private let smileyTheme = Theme.init(backgroundColor: Constants.lightPink, cardColor: Constants.navyBlue, cardTitles:["😎", "🤪", "😁", "😍", "😭", "🧐", "🤥", "😤"])
	private let animalTheme = Theme.init(backgroundColor: Constants.lightPink, cardColor: Constants.navyBlue, cardTitles:["🐶", "🐱", "🐭", "🐷", "🐮", "🐨", "🙉", "🦊"])
	private let foodTheme = Theme.init(backgroundColor: Constants.lightPink, cardColor: Constants.navyBlue, cardTitles:["🍎", "🍐", "🌶", "🥦", "🍆", "🥑", "🍌", "🍇"])
	private let spaceTheme = Theme.init(backgroundColor: Constants.lightPink, cardColor: Constants.navyBlue, cardTitles:["🌝", "🌗", "🌎", "🌚", "🌙", "💫", "🌍", "🌓"])
	private let itemsTheme = Theme.init(backgroundColor: Constants.lightPink, cardColor: Constants.navyBlue, cardTitles:["💍", "💄", "💋", "👄", "👅", "👣", "🧠", "👁"])
	private let randomTheme = Theme.init(backgroundColor: Constants.lightPink, cardColor: Constants.navyBlue, cardTitles:["🛁", "🎳", "🎭", "⚱️", "💣", "💡", "💊", "📌"])

	@IBOutlet private weak var flipCountLabel: UILabel!
	@IBOutlet private weak var scoreLabel: UILabel!
	@IBOutlet private(set) var cardButtons: [UIButton]!
	@IBOutlet private(set) var newGameButton: UIButton!
	@IBOutlet private(set) var gameTitleLabel: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setTheme()
		updateViewFromModel()
	}
	
	private func setTheme() {
		let themes: [Theme] = [smileyTheme, animalTheme, foodTheme, spaceTheme, itemsTheme, randomTheme]
		let selectedTheme = themes.count.arc4random
		
		themeBackgroundColor = themes[selectedTheme].backgroundColor
		themeCardColor = themes[selectedTheme].cardColor
		themeCardTitles = themes[selectedTheme].cardTitles
		
		view.backgroundColor = themeBackgroundColor
		scoreLabel.textColor = themeCardColor
		flipCountLabel.textColor = themeCardColor
		newGameButton.tintColor = themeCardColor
		newGameButton.backgroundColor = Constants.beige
		gameTitleLabel.textColor = themeCardColor
	}
	
	// MARK: Handle Card Touch Behavior
	@IBAction private func touchCard(_ sender: UIButton) {
		if let cardNumber = cardButtons.index(of: sender)
		{
			game.chooseCard(at: cardNumber)
			updateViewFromModel()
			
		} else {
			print("Chosen card was not in card buttons set")
		}
	}
	
	@IBAction private func newGame(_ sender: UIButton) {
		game.newGame()
		emoji.removeAll()
		setTheme()
		updateViewFromModel()
	}
	
	private func updateViewFromModel() {
		flipCountLabel.text = "Flips: \(game.flipCount)"
		scoreLabel.text = "Score: \(game.score)"
		
		for index in cardButtons.indices {
			let button = cardButtons[index]
			let card = game.cards[index]
			if card.isFaceUp {
				button.setTitle(emoji(for: card), for: UIControlState.normal)
				button.backgroundColor = Constants.beige
				button.isEnabled = false
			} else {
				button.setTitle("", for: UIControlState.normal)
				button.backgroundColor = card.isMatched ? UIColor.clear : Constants.navyBlue
				button.isEnabled = true
			}
		}
	}
		
	private func emoji(for card: Card) -> String {
		if emoji[card.identifier] == nil && themeCardTitles != nil {
			emoji[card.identifier] = themeCardTitles!.remove(at: themeCardTitles!.count.arc4random)
		}
		return emoji[card.identifier] ?? "?"
	}
}

// MARK: Extensions
extension Int {
	var arc4random: Int {
		if self > 0 {
			return Int(arc4random_uniform(UInt32(self)))
		} else if self < 0 {
			return -Int(arc4random_uniform(UInt32(self)))
		} else {
			return 0
		}
	}
}

extension UIColor {
	convenience init(red: Int, green: Int, blue: Int) {
		assert(red >= 0 && red <= 255, "Invalid red component")
		assert(green >= 0 && green <= 255, "Invalid green component")
		assert(blue >= 0 && blue <= 255, "Invalid blue component")
		
		self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
	}
	
	convenience init(rgb: Int) {
		self.init(
			red: (rgb >> 16) & 0xFF,
			green: (rgb >> 8) & 0xFF,
			blue: rgb & 0xFF
		)
	}
}


