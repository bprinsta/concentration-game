//
//  Card.swift
//  Concentration
//
//  Created by Benjamin Musoke-Lubega on 10/19/19.
//  Copyright © 2019 Ben Musoke-Lubega. All rights reserved.
//

import Foundation

struct Card: Hashable {
	var isFaceUp = false
	var isMatched = false
	var flipCount = 0
	private var identifier: Int
	
	private static var identifierFactory = 0
	
	func hash(into hasher: inout Hasher) {
		hasher.combine(identifier)
	}
	
	private static func getUniqueIdentifier() -> Int {
		identifierFactory += 1
		return Card.identifierFactory
	}
	
	static func ==(lhs: Card, rhs: Card) -> Bool {
		return lhs.identifier == rhs.identifier
	}
	
	init() {
		self.identifier = Card.getUniqueIdentifier()
	}
}
