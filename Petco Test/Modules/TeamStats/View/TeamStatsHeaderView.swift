//
//  TeamStatsHeaderView.swift
//  Petco Test
//
//  Created by Memo Rodriguez on 03/02/25.
//

import SwiftUI

struct StatsHeaderTextView: View {
    let statText: String
    var alignment: Alignment = .center
    let containerWidth: CGFloat
    
    var body: some View {
        VStack {
            Text(statText)
                .frame(width: containerWidth, alignment: alignment)
                .font(.caption2)
                .bold()
                .padding(.bottom, 4)
                .padding(8)
        }
    }
}

struct TeamStatsHeaderView: View {
    private let padding: CGFloat = 8

    var body: some View {
        HStack(spacing: 0) {
            StatsHeaderTextView(statText: "#", containerWidth: 50)
            StatsHeaderTextView(statText: "TEAM", alignment: .leading, containerWidth: 200)
            StatsHeaderTextView(statText: "WINS", containerWidth: 80)
            StatsHeaderTextView(statText: "DRAWS", containerWidth: 80)
            StatsHeaderTextView(statText: "LOSSES", containerWidth: 80)
        }
        .padding(padding)
    }
}

#Preview {
    ScrollView(.horizontal) {
        TeamStatsHeaderView()
    }
}
