//
//  TeamStatsDetailView.swift
//  Petco Test
//
//  Created by Memo Rodriguez on 03/02/25.
//

import SwiftUI

struct TeamStatsDetailView: View {
    let teamStat: TeamStatistics
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 16) {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 100, height: 100)
                    .overlay(
                        Text("Logo")
                            .foregroundColor(.white)
                    )
                
                Text(teamStat.strTeam)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Posición: \(teamStat.intRank)")
                        Text("Jugados: \(teamStat.intPlayed)")
                        Text("Victorias: \(teamStat.intWin)")
                        Text("Empates: \(teamStat.intDraw)")
                        Text("Derrotas: \(teamStat.intLoss)")
                    }
                    Spacer()
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Goles a favor: \(teamStat.intGoalsFor)")
                        Text("Goles en contra: \(teamStat.intGoalsAgainst)")
                        Text("Diferencia: \(teamStat.intGoalDifference)")
                        Text("Puntos: \(teamStat.intPoints)")
                    }
                }
                .padding(.horizontal)
                
                if !teamStat.strDescription.isEmpty {
                    Text(teamStat.strDescription)
                        .font(.body)
                        .padding()
                }
            }
            .padding()
        }
        .navigationTitle(teamStat.strTeam)
        .navigationBarTitleDisplayMode(.inline)
    }
}
