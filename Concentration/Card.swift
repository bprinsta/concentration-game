//
//  Card.swift
//  Concentration
//
//  Created by Benjamin Musoke-Lubega on 10/19/19.
//  Copyright © 2019 Ben Musoke-Lubega. All rights reserved.
//

import Foundation

struct Card: Hashable {
	
	var hashValue: Int {return identifier}
	
	static func ==(lhs: Card, rhs: Card) -> Bool {
		return lhs.identifier == rhs.identifier
	}
	
	var isFaceUp = false
	var isMatched = false
	private var identifier: Int
	var flipCount = 0
	
	// static var and funcs are for the type not individual card
	private static var identifierFactory = 0
	
	private static func getUniqueIdentifier() -> Int {
		identifierFactory += 1
		return Card.identifierFactory
	}
	
	init() {
		self.identifier = Card.getUniqueIdentifier()
	}
}
