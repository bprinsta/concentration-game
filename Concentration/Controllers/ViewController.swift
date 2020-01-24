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
	
	private var lastTouchedCardIndex: Int? = nil
	
	private var themeBackgroundColor: UIColor?
	private var themeCardColor: UIColor?
	private var themeCardFaceColor: UIColor?
	private var themeCardTitles: [String]?
	private var emoji = [Card: String]()
	
	private let smileyTheme = Theme.init(backgroundColor: ThemeColors.white, cardColor: ThemeColors.navyBlue, cardFaceColor: ThemeColors.teal, cardTitles: ThemeEmojis.faces)
	private let animalTheme = Theme.init(backgroundColor: ThemeColors.cream, cardColor: ThemeColors.brown, cardFaceColor: ThemeColors.darkCream, cardTitles: ThemeEmojis.animals)
	private let foodTheme = Theme.init(backgroundColor: ThemeColors.green, cardColor: ThemeColors.darkGreen, cardFaceColor: ThemeColors.forestCream, cardTitles: ThemeEmojis.fruit)
	private let spaceTheme = Theme.init(backgroundColor: ThemeColors.lightBeachBlue, cardColor: ThemeColors.beachCream, cardFaceColor: ThemeColors.beachBlue, cardTitles: ThemeEmojis.space)
	private let natureTheme = Theme.init(backgroundColor: ThemeColors.green, cardColor: ThemeColors.darkGreen, cardFaceColor: ThemeColors.forestCream,cardTitles: ThemeEmojis.nature)
	private let randomTheme = Theme.init(backgroundColor: ThemeColors.cream, cardColor: ThemeColors.brown, cardFaceColor: ThemeColors.darkCream,cardTitles: ThemeEmojis.random)
	private let sportsTheme = Theme.init(backgroundColor: ThemeColors.lightBeachBlue, cardColor: ThemeColors.beachCream, cardFaceColor: ThemeColors.beachBlue,cardTitles: ThemeEmojis.sports)

	@IBOutlet private weak var flipCountLabel: UILabel!
	@IBOutlet private weak var scoreLabel: UILabel!
	@IBOutlet private(set) var cardButtons: [UIButton]!
	@IBOutlet private weak var newGameButton: UIButton!
	@IBOutlet private weak var gameTitleLabel: UILabel!
		
	override func viewDidLoad() {
		super.viewDidLoad()
		setTheme()
		updateViewFromModel()
		endGame()
	}
	
	private func setTheme() {
		let themes: [Theme] = [smileyTheme, animalTheme, foodTheme, spaceTheme, natureTheme, randomTheme, sportsTheme]
		let selectedTheme = themes.count.arc4random
		
		// Set theme properties
		themeBackgroundColor = themes[selectedTheme].backgroundColor
		themeCardColor = themes[selectedTheme].cardColor
		themeCardTitles = themes[selectedTheme].cardTitles
		themeCardFaceColor = themes[selectedTheme].cardFaceColor
		
		// Set UI elements theme colors
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
		if let cardNumber = cardButtons.firstIndex(of: sender)
		{
			lastTouchedCardIndex = cardNumber
			game.chooseCard(at: cardNumber)
			updateViewFromModel()
			
		} else {
			print("Chosen card was not in card buttons set")
		}
		
		if game.gameOver {
			createParticles(view: self.view)
			endGame()
		}
	}
	
	@IBAction private func touchNewGameButton(_ sender: UIButton) {
		newGame()
	}
	
	private func newGame() {
		lastTouchedCardIndex = nil
		view.removeLayer(layerName: "confetti")
		game.newGame()
		emoji.removeAll()
		setTheme()
		updateViewFromModel()
	}
	
	@IBAction private func touchGameRulesButton(_ sender: UIButton) {
		let alertController = UIAlertController(title: "How To Play", message:
			"Match two of the same cards to score 20 points. If you flip over a card more than once without matching it, you lose 10 points. Put your concentration skills to the test and try to break your high score!", preferredStyle: .alert)
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
				button.setTitle(emoji(for: card), for: UIControl.State.normal)
				button.backgroundColor = themeCardFaceColor
				button.isEnabled = false
			} else {
				button.setTitle("", for: UIControl.State.normal)
				button.backgroundColor = card.isMatched ? UIColor.clear : themeCardColor
				button.isEnabled = card.isMatched ? false : true
			}
		}
		
		// play flip animation for last touched card
		if let index: Int = lastTouchedCardIndex {
			UIView.transition(with: cardButtons[index], duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
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


