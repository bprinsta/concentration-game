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
	private var themeCardFaceColor: UIColor?
	private var themeCardTitles: [String]?
	private var emoji = [Card: String]()
	
	private let smileyTheme = Theme.init(backgroundColor: Constants.white, cardColor: Constants.navyBlue, cardFaceColor: Constants.teal, cardTitles: Constants.faces)
	private let animalTheme = Theme.init(backgroundColor: Constants.cream, cardColor: Constants.brown, cardFaceColor: Constants.darkCream, cardTitles: Constants.animals)
	private let foodTheme = Theme.init(backgroundColor: Constants.green, cardColor: Constants.darkGreen, cardFaceColor: Constants.forestCream, cardTitles: Constants.fruit)
	private let spaceTheme = Theme.init(backgroundColor: Constants.lightBeachBlue, cardColor: Constants.beachCream, cardFaceColor: Constants.beachBlue, cardTitles: Constants.space)
	private let natureTheme = Theme.init(backgroundColor: Constants.green, cardColor: Constants.darkGreen, cardFaceColor: Constants.forestCream,cardTitles: Constants.nature)
	private let randomTheme = Theme.init(backgroundColor: Constants.cream, cardColor: Constants.brown, cardFaceColor: Constants.darkCream,cardTitles: Constants.random)
	private let sportsTheme = Theme.init(backgroundColor: Constants.lightBeachBlue, cardColor: Constants.beachCream, cardFaceColor: Constants.beachBlue,cardTitles: Constants.sports)

	@IBOutlet private weak var flipCountLabel: UILabel!
	@IBOutlet private weak var scoreLabel: UILabel!
	@IBOutlet private(set) var cardButtons: [UIButton]!
	@IBOutlet private weak var newGameButton: UIButton!
	@IBOutlet private weak var gameTitleLabel: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setTheme()
		updateViewFromModel()
	}
	
	private func setTheme() {
		let themes: [Theme] = [smileyTheme, animalTheme, foodTheme, spaceTheme, natureTheme, randomTheme, sportsTheme]
		let selectedTheme = themes.count.arc4random
		
		// Set theme properties
		themeBackgroundColor = themes[selectedTheme].backgroundColor
		themeCardColor = themes[selectedTheme].cardColor
		themeCardTitles = themes[selectedTheme].cardTitles
		themeCardFaceColor = themes[selectedTheme].cardFaceColor
		
		// Set UI elements theme colors and other properties
		view.backgroundColor = themeBackgroundColor
		scoreLabel.textColor = themeCardColor
		flipCountLabel.textColor = themeCardColor
		newGameButton.tintColor = themeCardColor
		newGameButton.backgroundColor = themeCardFaceColor
		newGameButton.layer.cornerRadius = 8.0
		gameTitleLabel.textColor = themeCardColor
		
		// Round card's corners
		for index in cardButtons.indices {
			cardButtons[index].layer.cornerRadius = 8.0
		}
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
		
		if game.gameOver {
			endGame()
		}
	}
	
	@IBAction private func newGame(_ sender: UIButton) {
		newGame()
	}
	
	private func newGame() {
		game.newGame()
		emoji.removeAll()
		setTheme()
		updateViewFromModel()
	}
	
	@IBAction private func gameRules(_ sender: UIButton) {
		let alertController = UIAlertController(title: "How To Play", message:
			"Match two of the same cards to score 2 points. If you flip over a card more than once without matching it, you lose 1 point. Put your concentration skills to the test and try to break your high score!", preferredStyle: .alert)
		alertController.addAction(UIAlertAction(title: "Play", style: .default))
		
		self.present(alertController, animated: true, completion: nil)
	}
	
	private func endGame() {
		let alertController = UIAlertController(title: "Congratulations!", message:
			"You finished the game with a score of \(game.score)!", preferredStyle: .alert)
		alertController.addAction(UIAlertAction(title: "Play New Game", style: .default, handler: { _ in
			self.newGame()
		}))
		
		self.present(alertController, animated: true, completion: nil)
	}
	
	private func updateViewFromModel() {
		flipCountLabel.text = "Flips: \(game.flipCount)"
		scoreLabel.text = "Score: \(game.score)"
		
		for index in cardButtons.indices {
			let button = cardButtons[index]
			let card = game.cards[index]
			if card.isFaceUp {
				button.setTitle(emoji(for: card), for: UIControlState.normal)
				button.backgroundColor = themeCardFaceColor
				button.isEnabled = false
			} else {
				button.setTitle("", for: UIControlState.normal)
				button.backgroundColor = card.isMatched ? UIColor.clear : themeCardColor
				button.isEnabled = card.isMatched ? false : true
			}
		}
	}
		
	private func emoji(for card: Card) -> String {
		if emoji[card] == nil && themeCardTitles != nil {
			emoji[card] = themeCardTitles!.remove(at: themeCardTitles!.count.arc4random)
		}
		return emoji[card] ?? "?"
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


