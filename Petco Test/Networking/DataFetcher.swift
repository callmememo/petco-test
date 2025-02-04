//
//  DataFetcher.swift
//  Petco Test
//
//  Created by Memo Rodriguez on 03/02/25.
//

import Foundation

class DataFetcher: DataFetchable {
    
    private let apiURL = "https://www.thesportsdb.com/api/v1/json/3"
    
    func fetchTeamStatistics() async throws -> [TeamStatistics] {
        guard let url = URL(string: "\(apiURL)/lookuptable.php?l=4328&s=2020-2021") else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let tableResponse = try JSONDecoder().decode(TableResponse.self, from: data)
        return tableResponse.table
    }
    
    func fetchTeamDetails(for team: String) async throws -> TeamDetail? {
        guard let url = URL(string: "\(apiURL)/searchteams.php?t=\(team)") else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let tableResponse = try JSONDecoder().decode(TeamsResponse.self, from: data)
        return tableResponse.teams.first
    }
}


