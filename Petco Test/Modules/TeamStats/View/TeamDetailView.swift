//
//  TeamDetailView.swift
//  Petco Test
//
//  Created by Memo Rodriguez on 03/02/25.
//

import SwiftUI

struct TeamDetailView: View {
    @StateObject private var viewModel = TeamDetailViewModel()
    
    let teamName: String
    
    var body: some View {
        ScrollView {            
            switch viewModel.loadingState {
            case .loading:
                ProgressView("Loading....")
                    .padding()
            case .failed:
                if let error = viewModel.errorMessage {
                    Text("Error: \(error)")
                        .foregroundColor(.red)
                        .padding()
                }
            case .loaded:
                if let detail = viewModel.teamDetails {
                    VStack(spacing: 20) {
                        AsyncImage(url: URL(string: detail.strBadge)) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 120, height: 120)
                                    .clipShape(Circle())
                            } else if phase.error != nil {
                                Image(systemName: "xmark.octagon")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 120, height: 120)
                                    .foregroundColor(.red)
                            } else {
                                ProgressView()
                                    .frame(width: 120, height: 120)
                            }
                        }
                        
                        Text(detail.strTeam)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        VStack(alignment: .leading, spacing: 10) {
                            if let formed = detail.intFormedYear, !formed.isEmpty {
                                InfoRow(title: "Founded", value: formed)
                            }
                            if let stadium = detail.strStadium, !stadium.isEmpty {
                                InfoRow(title: "Stadium", value: stadium)
                            }
                            if let manager = detail.strManager, !manager.isEmpty {
                                InfoRow(title: "Manager", value: manager)
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color(UIColor.systemGray6))
                        )
                        .padding(.horizontal)
                        
                        if let description = detail.strDescriptionEN, !description.isEmpty {
                            Text(description)
                                .font(.body)
                                .padding()
                        }
                        
                        Spacer()
                    }
                    .padding()
                } else {
                    VStack {
                        Spacer()
                        Text("No information found for this team.")
                            .padding()
                        Spacer()
                    }
                    
                }
            }
        }
        .navigationTitle(teamName)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.loadTeamDetails(for: teamName)
        }
    }
}

private struct InfoRow: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text("\(title):")
                .font(.subheadline)
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
                .font(.subheadline)
                .fontWeight(.semibold)
        }
    }
}

#Preview {
    TeamDetailView(teamName: "Arsenal")
}
