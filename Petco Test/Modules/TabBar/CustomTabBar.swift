//
//  CustomTabBar.swift
//  Petco Test
//
//  Created by Memo Rodriguez on 03/02/25.
//

import SwiftUI

struct CustomTabBarItem: View {
    let tab: CustomTabBar.TabBarItem
    let isSelected: Bool
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: tab.icon)
                .font(.system(size: 20))
            Text(tab.label)
                .font(.caption)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .foregroundColor(foregroundColor(isSelected: isSelected))
        .clipShape(Capsule())
        .background(
            Capsule().fill(backgroundColor(isSelected: isSelected))
        )
    }
    
    private func foregroundColor(isSelected: Bool) -> Color {
        if colorScheme == .dark {
            isSelected ? .black : .white
        } else {
            isSelected ? .white : .black
        }
    }
    
    private func backgroundColor(isSelected: Bool) -> Color {
        if colorScheme == .dark {
            isSelected ? .white : .clear
        } else {
            isSelected ? .black : .clear
        }
    }
}

struct CustomTabBar: View {
    @State var selectedTab: TabBarItem = .football
    
    enum TabBarItem: String, CaseIterable, Identifiable {
        case football, favorites, forYou
        
        var id: String { self.rawValue }
        
        var icon: String {
            switch self {
            case .football: return "soccerball.inverse"
            case .favorites: return "star"
            case .forYou: return "newspaper"
            }
        }
        
        var label: String {
            switch self {
            case .football: return "Football"
            case .favorites: return "Favorites"
            case .forYou: return "For You"
            }
        }
    }
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(TabBarItem.allCases) { tab in
                Button(action: {
                    withAnimation {
                        selectedTab = tab
                        print(selectedTab == tab)
                    }
                }) {
                    CustomTabBarItem(tab: tab, isSelected: selectedTab == tab)
                }
            }
        }
        .padding(8)
        .background(Color(UIColor.secondarySystemGroupedBackground))
    }
}


#Preview {
    HStack {
        CustomTabBar()
    }
}
