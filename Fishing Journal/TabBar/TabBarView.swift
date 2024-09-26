//
//  TabBarView.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 20.11.23.
//

import Foundation
import SwiftUI

struct TabBarView: View {
    @State private var selection: TabBar = .home
    
    var body: some View {
        TabView(selection: $selection) {
            MainView()
                .tag(TabBar.home)
                .tabItem {
                    Image(systemName: TabBar.home.icon)
                    Text(TabBar.home.description)
                }
            MapView()
                .tag(TabBar.map)
                .tabItem {
                    Image(systemName: TabBar.map.icon)
                    Text(TabBar.map.description)
                }
            FeedView()
                .tag(TabBar.feed)
                .tabItem {
                    Image(systemName: TabBar.feed.icon)
                    Text(TabBar.feed.description)
                }
            ProfileView()
                .tag(TabBar.settings)
                .tabItem {
                    Image(systemName: TabBar.settings.icon)
                    Text(TabBar.settings.description)
                }
        }
        .tint(.primaryDeepBlue)
    }
}
#Preview {
    TabBarView()
        .environmentObject(FishingData())
}
