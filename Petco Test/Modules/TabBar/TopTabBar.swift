//
//  TopTabBar.swift
//  Petco Test
//
//  Created by Memo Rodriguez on 03/02/25.
//

import SwiftUI

struct TopTabBarView: View {
    @State private var selectedTab: TopTabBar = .table

    private enum TopTabBar: String, CaseIterable, Identifiable {
        case overview = "Overview"
        case matches = "Matches"
        case table = "Table"
        case news = "News"
        case playerStats = "Player Stats"
        
        var id: String { rawValue }
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(TopTabBar.allCases) { tab in
                    Button(action: {
                        withAnimation {
                            selectedTab = tab
                        }
                    }) {
                        Text(tab.rawValue)
                            .font(.subheadline)
                            .bold()
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                            .foregroundColor(selectedTab == tab ? .orange : .primary)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    TopTabBarView()
}
