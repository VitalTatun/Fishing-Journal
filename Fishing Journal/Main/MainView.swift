//
//  MainView.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 12.11.23.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var fishingData: FishingData
   
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(fishingData.mockFishings) { fishing in
                    FishingItem(fishing: fishing)
                        .swipeActions {
                            Button(role: .destructive) {
                                fishingData.delete(fishing)
                            } label: {
                                Image(systemName: "trash")
                            }
                        }
                }
            }
            .listStyle(.plain)
            .scrollIndicators(.hidden)
            .navigationTitle("Fishing Journal")
            .toolbar {
                // Filtering Button
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease.circle.fill")
                            .symbolRenderingMode(.hierarchical)
                    }
                }
                // New Fishing Log Button
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "plus")
                    })
                }
            }
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
