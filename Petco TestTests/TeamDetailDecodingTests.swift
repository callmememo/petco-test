//
//  TeamDetailDecodingTests.swift
//  Petco TestTests
//
//  Created by Memo Rodriguez on 04/02/25.
//

import XCTest
@testable import Petco_Test

final class TeamDetailsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Register the simulated protocol to intercept requests
        URLProtocol.registerClass(MockURLProtocol.self)
    }
    
    override func tearDown() {
        // Clean up everthing
        URLProtocol.unregisterClass(MockURLProtocol.self)
        MockURLProtocol.requestHandler = nil
        super.tearDown()
    }
    
    func testTeamDetailResponseDecoding() throws {
        let json = """
            {
                "teams": [
                    {
                        "idTeam": "133604",
                        "strTeam": "Arsenal",
                        "strBadge": "https://www.thesportsdb.com/images/media/team/badge/arsenal.png",
                        "strDescriptionEN": "Arsenal Football Club is a professional football club...",
                        "strStadium": "Emirates Stadium",
                        "intFormedYear": "1886",
                        "strManager": "Mikel Arteta"
                    }
                ]
            }
            """.data(using: .utf8)!
        
        let response = try JSONDecoder().decode(TeamsResponse.self, from: json)
        XCTAssertNotNil(response.teams)
        XCTAssertEqual(response.teams.first?.idTeam, "133604")
        XCTAssertEqual(response.teams.first?.strTeam, "Arsenal")
        XCTAssertEqual(response.teams.first?.strManager, "Mikel Arteta")
    }
    
    @MainActor
    func testFetchTeamDetailsSuccess() async throws {
        let json = """
        {
            "teams": [
                {
                    "idTeam": "133604",
                    "strTeam": "Arsenal",
                    "strBadge": "https://www.thesportsdb.com/images/media/team/badge/arsenal.png",
                    "strDescriptionEN": "Arsenal Football Club is a professional club...",
                    "strStadium": "Emirates Stadium",
                    "intFormedYear": "1886",
                    "strManager": "Mikel Arteta"
                }
            ]
        }
        """.data(using: .utf8)!
        
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)!
            return (response, json)
        }
        
        let viewModel = TeamDetailViewModel()
        await viewModel.loadTeamDetails(for: "Arsenal")
        
        XCTAssertNotNil(viewModel.teamDetails)
        XCTAssertEqual(viewModel.teamDetails?.strTeam, "Arsenal")
        XCTAssertEqual(viewModel.loadingState, .loaded)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    @MainActor
    func testFetchTeamDetailsFailure() async throws {
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!,
                                           statusCode: 404,
                                           httpVersion: nil,
                                           headerFields: nil)!
            let data = Data()
            return (response, data)
        }
        
        let viewModel = TeamDetailViewModel()
        await viewModel.loadTeamDetails(for: "Arsenal")
        
        XCTAssertNil(viewModel.teamDetails)
        XCTAssertEqual(viewModel.loadingState, .failed)
        XCTAssertNotNil(viewModel.errorMessage)
    }
}
