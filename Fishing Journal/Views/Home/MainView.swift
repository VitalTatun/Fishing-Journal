//
//  MainView.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 12.11.23.
//

import SwiftUI


struct MainView: View {
    
    @EnvironmentObject var fishingData: FishingData
    
    @State private var showNewFishingView = false
    
    let listEdgeInsets = EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
    
    var body: some View {
        NavigationStack {
            List {
                ForEach($fishingData.mockFishings) { $fishing in
                    NavigationLink(destination: DetailFishingView(fishing: $fishing)) {
                        FishingItem(fishingData: _fishingData, fishing: $fishing)
                    }
                    .listRowInsets(listEdgeInsets)
                    .listRowBackground(RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                        .padding(2))
                }
            }
            .overlay {
                if fishingData.mockFishings.isEmpty {
                    UnavailableView(showNewFishingView: $showNewFishingView)
                }
            }
            .listStyle(.plain)
            .navigationLinkIndicatorVisibility(.hidden)
            .scrollIndicators(.hidden)
            .navigationTitle("Fishing Journal")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                // Filtering Button
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease.circle.fill")
                            .font(.title2)
                            .symbolRenderingMode(.hierarchical)
                            .tint(.primaryDeepBlue)
                    }
                }
                // Add new Fishing Log Button
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showNewFishingView = true
                    }, label: {
                        Image(systemName: "plus")
                            .foregroundStyle(.primaryDeepBlue)
                            .imageScale(.large)
                            .fontWeight(.semibold)
                    })
                }
            }
            .fullScreenCover(isPresented: $showNewFishingView, content: {
                AddFishingView(showAddFishingView: $showNewFishingView)
            })
        }
    }
    
    func formatDate(date: Date) -> String {
        let date = Date.now
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

#Preview {
    MainView()
        .environmentObject(FishingData())
}
#Preview("Empty List") {
    MainView()
        .environmentObject(FishingData())
}
