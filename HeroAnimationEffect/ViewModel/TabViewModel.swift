//
//  TabViewModel.swift
//  HeroAnimationEffect
//
//  Created by M H on 23/01/2022.
//

import SwiftUI

class TabViewModel: ObservableObject {
	
	@Published var currentTab = "Home"
	
	// detail data
	@Published var currentCard: Card?
	@Published var showDetail: Bool = false
}
