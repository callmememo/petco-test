//
//  Petco_TestTests.swift
//  Petco TestTests
//
//  Created by Memo Rodriguez on 03/02/25.
//

import XCTest
@testable import Petco_Test  // Asegúrate de que el nombre del módulo coincida con tu target

// MARK: - MockURLProtocol

class MockURLProtocol: URLProtocol {
    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data))?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        guard let handler = MockURLProtocol.requestHandler else {
            XCTFail("MockURLProtocol.requestHandler no está configurado")
            return
        }
        do {
            let (response, data) = try handler(request)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }
}

class TeamDetailDecodingTests: XCTestCase {
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
}

// MARK: - Test del ViewModel (Fetch exitoso y fallo)

class TeamDetailViewModelTests: XCTestCase {
    override func setUp() {
        super.setUp()
        // Registramos el protocolo mock para interceptar las peticiones de URLSession.shared.
        URLProtocol.registerClass(MockURLProtocol.self)
    }
    
    override func tearDown() {
        URLProtocol.unregisterClass(MockURLProtocol.self)
        MockURLProtocol.requestHandler = nil
        super.tearDown()
    }
    
    @MainActor
    func testFetchTeamDetailSuccess() async throws {
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
    func testFetchTeamDetailFailure() async throws {
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

