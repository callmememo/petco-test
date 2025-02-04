//
//  TeamDetails.swift
//  Petco Test
//
//  Created by Memo Rodriguez on 03/02/25.
//

import Foundation

struct TeamsResponse: Decodable {
    let teams: [TeamDetail]
}

struct TeamDetail: Decodable, Identifiable {
    var id: String { idTeam }
    
    let idTeam: String
    let strTeam: String
    let strBadge: String
    let strDescriptionEN: String?
    let strStadium: String?
    let intFormedYear: String?
    let strManager: String?
}
