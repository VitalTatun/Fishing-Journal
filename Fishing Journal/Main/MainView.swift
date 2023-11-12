//
//  MainView.swift
//  Fishing Journal
//
//  Created by Виталий Татун on 12.11.23.
//

import SwiftUI

struct MainView: View {
    
   
    
    var body: some View {
        NavigationStack {
            List {
                FishingItem()
                FishingItem()
                FishingItem()
                FishingItem()
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
}
