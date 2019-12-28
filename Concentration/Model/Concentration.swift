//
//  Concentration.swift
//  Concentration
//
//  Created by Benjamin Musoke-Lubega on 10/19/19.
//  Copyright © 2019 Ben Musoke-Lubega. All rights reserved.
//

import Foundation

struct Concentration {
	
	private(set) var cards = [Card]()
	private(set) var score: Int
	var flipCount: Int
	var gameOver: Bool
	
	private var indexOfOneAndOnlyFaceUpCard: Int? {
		get {
			return cards.indices.filter {cards[$0].isFaceUp }.oneAndOnly
		}
		set(newValue) {
			for index in cards.indices {
				cards[index].isFaceUp = (index == newValue)
			}
		}
	}
	
	mutating func chooseCard(at index: Int) {
		assert(cards.indices.contains(index), "Concentration.chooseCard(at index: \(index)): chosen index not in the cards")
		
		if (!cards[index].isFaceUp) {
			flipCount += 1
		}
		
		if !cards[index].isMatched {
			if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
				if cards[matchIndex] == cards[index] {
					cards[matchIndex].isMatched = true
					cards[index].isMatched = true
					score += 20
				} else if cards[index].flipCount > 0 || cards[matchIndex].flipCount > 0 {
					score -= 10
				}
				cards[index].isFaceUp = true
				cards[index].flipCount += 1
				cards[matchIndex].flipCount += 1
			} else {
				indexOfOneAndOnlyFaceUpCard = index
			}
		}
		
		gameOver = isGameOver()
	}
	
	mutating func newGame() {
		score = 0
		flipCount = 0
		gameOver = false
		
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
		gameOver = false
		
		for _ in 1...numPairsOfCards {
			let card = Card();
			cards += [card, card]
		}
		cards.shuffle()
	}
	
	private func isGameOver() -> Bool {
		var allMatched = true
		for card in cards {
			if !card.isMatched {
				allMatched = false
				break
			}
		}
		return allMatched
	}
}
// MARK: Extensions
extension Collection {
	var oneAndOnly: Element? {
		return count == 1 ? first : nil
	}
}
