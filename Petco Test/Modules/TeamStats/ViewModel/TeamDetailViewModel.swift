//
//  TeamDetailViewModel.swift
//  Petco Test
//
//  Created by Memo Rodriguez on 03/02/25.
//

import Foundation
import SwiftUI

@MainActor
class TeamDetailViewModel: ObservableObject, Lodable {
    @Published var teamDetails: TeamDetail?
    @Published var loadingState: LoadingState = .loading
    @Published var errorMessage: String? = nil
    
    private let dataProvider: DataFetchable
    
    init(dataProvider: DataFetchable = DataFetcher()) {
        self.dataProvider = dataProvider
    }
    
    func loadTeamDetails(for team: String) async {
        loadingState = .loading
        errorMessage = nil        
        do {
            teamDetails = try await dataProvider.fetchTeamDetails(for: team)
            loadingState = .loaded
        } catch {
            errorMessage = error.localizedDescription
            loadingState = .failed
        }
    }
}
