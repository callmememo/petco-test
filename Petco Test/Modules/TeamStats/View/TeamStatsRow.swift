import SwiftUI

struct TeamStatsRowView: View {
    private let padding: CGFloat = 8
    
    let team: TeamStatistics

    var body: some View {
        HStack(spacing: .zero) {
            Text(team.intRank)
                .frame(width: 50)
                .padding(padding)
            
            HStack(spacing: padding) {
                AsyncImage(url: URL(string: team.strBadge)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image.resizable()
                            .scaledToFit()
                    case .failure:
                        Image(systemName: "exclamationmark.triangle")
                            .resizable()
                            .scaledToFit()
                    @unknown default:
                        EmptyView()
                    }
                }
                .frame(width: 40, height: 40)
                .clipShape(Circle())
                
                Text(team.strTeam)
                    .font(.subheadline)
            }
            .frame(width: 200, alignment: .leading)
            .padding(padding)
            
            Text(team.intWin)
                .frame(width: 80)
                .padding(padding)
            
            Text(team.intDraw)
                .frame(width: 80)
                .padding(padding)
            
            Text(team.intLoss)
                .frame(width: 80)
                .padding(padding)
        }
        .padding(.horizontal, padding)
    }
}

#Preview {
    ScrollView(.horizontal) {
        TeamStatsRowView(team: TeamStatistics.mock)
    }
}
