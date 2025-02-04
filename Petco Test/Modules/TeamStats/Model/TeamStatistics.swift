//
//  TeamStatistics.swift
//  Petco Test
//
//  Created by Memo Rodriguez on 03/02/25.
//

import Foundation

struct TableResponse: Decodable {
    let table: [TeamStatistics]
}

struct TeamStatistics: Decodable, Identifiable {
    var id: String { idStanding }
    
    let idStanding: String
    let intRank: String
    let idTeam: String
    let strTeam: String
    let strBadge: String
    let idLeague: String
    let strLeague: String
    let strSeason: String
    let strForm: String
    let strDescription: String
    let intPlayed: String
    let intWin: String
    let intLoss: String
    let intDraw: String
    let intGoalsFor: String
    let intGoalsAgainst: String
    let intGoalDifference: String
    let intPoints: String
}

#if DEBUG
extension TeamStatistics {
    static var mock: TeamStatistics {
        return TeamStatistics(
            idStanding: "1",
            intRank: "1",
            idTeam: "133613",
            strTeam: "Manchester City",
            strBadge: "https://www.thesportsdb.com/images/media/team/badge/vwpvry1467462651.png/tiny",
            idLeague: "4328",
            strLeague: "English Premier League",
            strSeason: "2020-2021",
            strForm: "WWLWD",
            strDescription: "Promoción - Fase de grupos de la Champions League",
            intPlayed: "38",
            intWin: "27",
            intLoss: "6",
            intDraw: "5",
            intGoalsFor: "83",
            intGoalsAgainst: "32",
            intGoalDifference: "51",
            intPoints: "86"
        )
    }
}
#endif
