//
//  DetailView.swift
//  HeroAnimationEffect
//
//  Created by M H on 23/01/2022.
//

import SwiftUI

struct DetailView: View {
	@EnvironmentObject var tabData: TabViewModel
	var animation: Namespace.ID
	
	// showing data with delay
	@State var showData = false
	
    var body: some View {
		// unrap card
		if let card = tabData.currentCard, tabData.showDetail {
			VStack(spacing: 0) {
				
				Image(systemName: card.image)
					.resizable()
					.scaledToFit()
					.matchedGeometryEffect(id: card.id + "IMAGE", in: animation)
					.padding(.bottom)
					.foregroundColor(.white)
					.background(
						LinearGradient(colors: card.cardColors, startPoint: .topLeading, endPoint: .bottomLeading)
							.cornerRadius(15)
							.matchedGeometryEffect(id: card.id + "BG", in: animation)
							.ignoresSafeArea()
					)
					.overlay(
						Button(action: {
							withAnimation(.spring()){
								tabData.showDetail = false
							}
						}, label: {
							Image(systemName: "xmark")
								.foregroundColor(.black)
								.padding(10)
								.background(.white, in: Circle())
						}) // bot
							.padding(10)
							.opacity(showData ? 1 : 0)
						,alignment: .topTrailing
					)
				ScrollView(.vertical,showsIndicators: false){
					VStack(alignment: .leading, spacing: 15) {
						Text(card.title)
							.font(.title2.bold())
							.matchedGeometryEffect(id: "\(card.id)TITLE", in: animation)
						
						ForEach(1...20, id: \.self) {index in
							HStack(spacing: 12) {
							Image(systemName: "swift")
								.padding()
								.background(.thinMaterial, in: RoundedRectangle(cornerRadius: 12))
								.shadow(radius: 2)
							
								Text("Day \(index) of swiftUI")
									.fontWeight(.semibold)
								Spacer()
								Image(systemName: "play.fill")
									.font(.title2)
									.foregroundColor(.red)
							} // h
							.padding(.vertical, 8)
							.padding(.horizontal)
							.background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 10))
						} // loop
						.opacity(showData ? 1 : 0)
					} // v
					.padding()
					.padding(.top)
				} // scrv
			} // v
			
			.background(.ultraThinMaterial)
			.onAppear{
				DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
					withAnimation{
						showData = true
					}
				})
				
			} // on app
			.onDisappear(perform: {
				withAnimation{
					showData = false
				}
			}) // on dis
		} // if
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
