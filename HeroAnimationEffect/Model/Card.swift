//
//  Card.swift
//  HeroAnimationEffect
//
//  Created by M H on 23/01/2022.
//

import SwiftUI

struct Card: Identifiable {
	var id = UUID().uuidString
	var title: String
	var image: String
	var cardColors: [Color]
}

var cards: [Card] = [
	Card(title: "2021 Best Course", image: "house", cardColors: [.red,.orange]),
	Card(title: "Full iOS Development", image: "gear", cardColors: [.blue,.green])
]
