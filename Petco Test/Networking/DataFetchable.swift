//
//  DataFetcherProtocol.swift
//  Petco Test
//
//  Created by Memo Rodriguez on 03/02/25.
//

import Foundation

protocol DataFetchable {
    func fetchTeamStatistics() async throws -> [TeamStatistics]
    func fetchTeamDetails(for team: String) async throws -> TeamDetail?
}
