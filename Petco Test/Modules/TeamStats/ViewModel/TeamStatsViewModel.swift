//
//  TeamStatsViewModel.swift
//  Petco Test
//
//  Created by Memo Rodriguez on 03/02/25.
//

import Foundation

@MainActor
class TeamStatsViewModel: ObservableObject, Lodable {
    @Published var teamStatistics: [TeamStatistics] = []
    @Published var loadingState: LoadingState = .loading
    @Published var errorMessage: String? = nil
    @Published var selectedSortOption: SortOption = .wins
    
    private let dataProvider: DataFetchable
    
    init(dataProvider: DataFetchable = DataFetcher()) {
        self.dataProvider = dataProvider
    }
    
    func loadTeamStatisticsData() async {
        loadingState = .loading
        errorMessage = nil
        
        do {
            teamStatistics = try await dataProvider.fetchTeamStatistics()
            loadingState = .loaded
        } catch {
            errorMessage = error.localizedDescription
            loadingState = .failed
        }
    }
    
    var sortedTeamStatistics: [TeamStatistics] {
        teamStatistics.sorted { lhs, rhs in
            switch selectedSortOption {
            case .wins:
                return (Int(lhs.intWin) ?? 0) > (Int(rhs.intWin) ?? 0)
            case .draws:
                return (Int(lhs.intDraw) ?? 0) > (Int(rhs.intDraw) ?? 0)
            case .losses:
                return (Int(lhs.intLoss) ?? 0) > (Int(rhs.intLoss) ?? 0)
            }
        }
    }
}


enum SortOption: String, CaseIterable, Identifiable {
    case wins = "Wins"
    case draws = "Draws"
    case losses = "Losses"
    
    var id: String { self.rawValue }
}
