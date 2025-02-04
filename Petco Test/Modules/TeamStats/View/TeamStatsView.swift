//
//  TeamStatsView.swift
//  Petco Test
//
//  Created by Memo Rodriguez on 03/02/25.
//

import SwiftUI

struct TeamStatsTableView: View {
    @StateObject private var viewModel = TeamStatsViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                TopTabBarView()
                switch viewModel.loadingState {
                case .loading:
                    VStack {
                        Spacer()
                        ProgressView("Loading....")
                            .padding()
                        Spacer()
                    }
                case .loaded:
                    HStack {
                        Menu {
                            ForEach(SortOption.allCases) { option in
                                Button(option.rawValue) {
                                    viewModel.selectedSortOption = option
                                }
                            }
                        } label: {
                            Label("Sort by: \(viewModel.selectedSortOption.rawValue)", systemImage: "arrow.up.arrow.down")
                                .padding(.horizontal)
                                .foregroundStyle(.orange)
                        }
                        Spacer()
                    }
                    .padding(.top)
                    ScrollView(.vertical, showsIndicators: false) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyVStack(alignment: .leading, spacing: .zero, pinnedViews: [.sectionHeaders]) {
                                Section(header:
                                            TeamStatsHeaderView()
                                ) {
                                    ForEach(viewModel.sortedTeamStatistics) { team in
                                        NavigationLink(destination: TeamDetailView(teamName: team.strTeam)) {
                                            TeamStatsRowView(team: team)
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                        Divider()
                                    }
                                }
                            }
                        }
                    }
                case .failed:
                    if let error = viewModel.errorMessage {
                        VStack {
                            Spacer()
                            VStack {
                                Text("Error: \(error)")
                                    .foregroundColor(.primary)
                                    .padding()
                                Button("Retry") {
                                    Task {
                                        await viewModel.loadTeamStatisticsData()
                                    }
                                }
                            }
                            Spacer()
                        }
                    }
                }
                CustomTabBar()
            }
            .refreshable {
                await viewModel.loadTeamStatisticsData()
            }
            .task {
                await viewModel.loadTeamStatisticsData()
            }
        }
        .tint(.orange)
    }
}

#Preview {
    TeamStatsTableView()
}

