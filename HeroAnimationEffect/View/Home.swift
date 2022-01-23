//
//  Home.swift
//  HeroAnimationEffect
//
//  Created by M H on 23/01/2022.
//

import SwiftUI

struct Home: View {
	
	@EnvironmentObject var tabData: TabViewModel
	
	// animation
	var animation: Namespace.ID
	
	var body: some View {
		ScrollView(.vertical, showsIndicators: false) {
			VStack(spacing: 18) {
				Text("Best Selling")
					.font(.system(size: 35).bold())
					.frame(maxWidth: .infinity, alignment: .leading)
					.padding(.bottom)
				// cards
				ForEach(cards) { card in
					Button(action: {
						withAnimation(.spring()){
							tabData.currentCard = card
							tabData.showDetail = true
						}
					}, label: {
						
						CardView(card: card)
						
							.padding()
							.background(
								cardBG(card: card)
							)
						
							.foregroundColor(.white)
					}) // but
						.buttonStyle(CardButtonStyle())
				} // loop
			} // v
			.padding()
			.padding(.bottom, 80)
		} // srcv
	}
	
	@ViewBuilder
	func cardBG(card: Card) -> some View {
		ZStack {
			if tabData.showDetail && tabData.currentCard?.id == card.id {
				LinearGradient(colors: card.cardColors, startPoint: .topLeading, endPoint: .bottomLeading)
					.cornerRadius(15)
					.opacity(0)
				//					.matchedGeometryEffect(id: card.id + "BG", in: animation)
			} else {
				LinearGradient(colors: card.cardColors, startPoint: .topLeading, endPoint: .bottomLeading)
					.cornerRadius(15)
					.matchedGeometryEffect(id: card.id + "BG", in: animation)
			} // if
		} // z
	} // f
	
	@ViewBuilder
	func CardView(card: Card)-> some View {
		VStack(spacing: 15) {
			if tabData.showDetail && tabData.currentCard?.id == card.id  {
				Image(systemName: card.image)
					.resizable()
					.scaledToFit()
				//					.matchedGeometryEffect(id: card.id + "IMAGE", in: animation)
					.padding(.bottom)
					.opacity(0)
				
				Text(card.title)
					.font(.title2.bold())
					.opacity(0)
				//					.matchedGeometryEffect(id: "\(card.id)TITLE", in: animation)
			} else {
				Image(systemName: card.image)
					.resizable()
					.scaledToFit()
					.matchedGeometryEffect(id: card.id + "IMAGE", in: animation)
					.padding(.bottom)
				
				Text(card.title)
					.font(.title2.bold())
					.matchedGeometryEffect(id: "\(card.id)TITLE", in: animation)
			} // if
		} // v
	} // f
}

struct Home_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}

struct CardButtonStyle: ButtonStyle {
	func makeBody(configuration: Configuration) -> some View {
		return configuration.label
			.scaleEffect(configuration.isPressed ? 0.96 : 1)
			.animation(.easeIn, value: configuration.isPressed)
	}
}
