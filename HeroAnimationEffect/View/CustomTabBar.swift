//
//  CustomTabBar.swift
//  HeroAnimationEffect
//
//  Created by M H on 23/01/2022.
//

import SwiftUI

struct CustomTabBar: View {
	
	@StateObject var tabData = TabViewModel()
	
	// hiding tab view
	init() {
		UITabBar.appearance().isHidden = true
	}
	
	@Namespace var animation
	
    var body: some View {
		TabView(selection: $tabData.currentTab, content: {
			
			Home(animation: animation)
				.environmentObject(tabData)
				.tag("Home")
			
			Text("Purchased")
				.tag("Purchased")
			
			Text("Settings")
				.tag("Settings")
		}) // tv
			.overlay(
				HStack {
					TabBarButton(title: "Home", image: "house", animation: animation)
					TabBarButton(title: "Purchased", image: "purchased.circle", animation: animation)
					TabBarButton(title: "Settings", image: "gear.circle", animation: animation)
				}
					.environmentObject(tabData)
					.padding(.vertical, 10)
					.padding(.horizontal)
					.background(.thinMaterial,in: Capsule())
					.padding(.horizontal, 20)
					.padding(.bottom, 20)
					.shadow(color: .black.opacity(0.09), radius: 5, x: 5, y: 5)
					.shadow(color: .black.opacity(0.09), radius: 5, x: -5, y: 0)
				// hiding tab bar
					.offset(y: tabData.showDetail ? 250 : 0)
				// always light tab bar
					.colorScheme(.light)
				, alignment: .bottom
			) // overlay
		// detail view
			.overlay(
				DetailView(animation: animation)
				.environmentObject(tabData)
			)
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar()
    }
}

struct TabBarButton: View {
	var title: String
	var image: String
	 // for slide tab animation
	var animation: Namespace.ID
	
	@EnvironmentObject var tabData: TabViewModel
	
	var body: some View {
		Button(action: {
			withAnimation{
				tabData.currentTab = title
			}
		}, label: {
			VStack {
				Image(systemName: image)
					.font(.title2)
				// same height for all images to avoid the animation glitch
					.frame(height: 18)
				Text(title)
					.font(.caption.bold())
			} // v
			.foregroundColor(tabData.currentTab == title ? .purple : .gray)
			.frame(maxWidth: .infinity)
			.overlay(
				ZStack{
					// only for current tab
					if tabData.currentTab == title {
						TabIndicator()
							.fill(.linearGradient(.init(colors: [
								.purple.opacity(0.2), .purple.opacity(0.1)
							]), startPoint: .top, endPoint: .bottom))
						// geometry effect
							.matchedGeometryEffect(id: "TAB", in: animation)
							.padding(.top, -10)
							.padding(.horizontal, 8)
					}
				}) // over
		}) // b
	}
}

// custom tab lighting indicator
// shape

struct TabIndicator: Shape {
	func path(in rect: CGRect) -> Path {
		return Path{ path in
			path.move(to: CGPoint(x: 0, y: 0))
			path.addLine(to: CGPoint(x: rect.width, y: 0))
			path.addLine(to: CGPoint(x: rect.width - 10, y: rect.height))
			path.addLine(to: CGPoint(x: 10, y: rect.height))
		}
	}
}
