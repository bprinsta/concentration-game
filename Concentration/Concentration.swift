//
//  Concentration.swift
//  Concentration
//
//  Created by Benjamin Musoke-Lubega on 10/19/19.
//  Copyright © 2019 Ben Musoke-Lubega. All rights reserved.
//

import Foundation

class Concentration {
	
	private(set) var cards = [Card]()
	private(set) var score: Int
	var flipCount: Int
	
	private var indexOfOneAndOnlyFaceUpCard: Int? {
		get {
			var foundIndex: Int?
			for index in cards.indices {
				if cards[index].isFaceUp {
					if foundIndex == nil {
						foundIndex = index
					} else {
						return nil
					}
				}
			}
			return foundIndex
		}
		
		set(newValue) {
			for index in cards.indices {
				cards[index].isFaceUp = (index == newValue)
			}
		}
	}
	
	func chooseCard(at index: Int) {
		assert(cards.indices.contains(index), "Concentration.chooseCard(at index: \(index)): chosen index not in the cards")
		
		if (!cards[index].isFaceUp) {
			flipCount += 1
		}
		
		if !cards[index].isMatched {
			if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
				if cards[matchIndex].identifier == cards[index].identifier {
					cards[matchIndex].isMatched = true
					cards[index].isMatched = true
					score += 2
				} else if cards[index].flipCount > 0 || cards[matchIndex].flipCount > 0 {
					score -= 1
				}
				cards[index].isFaceUp = true
				cards[index].flipCount += 1
			} else {
				indexOfOneAndOnlyFaceUpCard = index
			}
		}
	}
	
	func newGame() {
		score = 0
		flipCount = 0
		
		for index in cards.indices {
			cards[index].isMatched = false
			cards[index].isFaceUp = false
			cards[index].flipCount = 0
		}
		cards.shuffle()
	}
	
	init (numPairsOfCards: Int) {
		assert(numPairsOfCards > 0, "Concentration.init\(numPairsOfCards): you must have at least one pair of cards")
		
		score = 0
		flipCount = 0
		
		for _ in 1...numPairsOfCards {
			let card = Card();
			cards += [card, card]
		}
		cards.shuffle()
	}
}

extension Array {
	mutating func shuffle() {
		for _ in indices {
			sort { (_,_) in arc4random() < arc4random() }
		}
	}
}
