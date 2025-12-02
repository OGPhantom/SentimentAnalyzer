//
//  OverallSentimentSectionView.swift
//  SentimentAnalyzer
//
//  Created by Никита Сторчай on 30.11.2025.
//

import SwiftUI

struct OverallSentimentSectionView: View {
    let responses: [Response]
    @State private var showPills = false

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {

            if let overall {
                Button {
                    withAnimation(.spring(response: 0.35, dampingFraction: 0.78)) {
                        showPills.toggle()
                    }
                } label: {
                    HStack(spacing: 12) {
                        ZStack {
                            Circle()
                                .fill(overall.sentimentColor.opacity(0.18))
                                .frame(width: 40, height: 40)

                            Image(systemName: "chart.pie.fill")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundStyle(overall.sentimentColor)
                        }

                        VStack(alignment: .leading, spacing: 4) {
                            Text("Overall sentiment")
                                .font(.headline)
                                .foregroundStyle(.primary)
                                .fixedSize(horizontal: true, vertical: false)

                            HStack(spacing: 6) {
                                Image(systemName: overall.icon)
                                    .font(.system(size: 14, weight: .semibold))

                                Text("Leaning \(overall.rawValue)")
                                    .font(.headline)
                                    .fixedSize(horizontal: true, vertical: false)
                            }
                            .foregroundStyle(overall.sentimentColor)
                        }

                        Spacer()

                        VStack(alignment: .center) {
                            Text("\(responses.count)")
                                .font(.subheadline)
                                .foregroundStyle(.primary)

                            Text("responses")
                                .font(.subheadline)
                                .foregroundStyle(.primary)
                        }
                    }
                }
                .buttonStyle(.plain)

                if showPills {
                    HStack(spacing: 14) {
                        SecntimentPill(
                            sentiment: .positive,
                            percentage: getPercentage(.positive)
                        )

                        SecntimentPill(
                            sentiment: .moderate,
                            percentage: getPercentage(.moderate)
                        )

                        SecntimentPill(
                            sentiment: .negative,
                            percentage: getPercentage(.negative)
                        )
                    }
                    .transition(
                        .asymmetric(
                            insertion: .opacity.combined(with: .move(edge: .top)),
                            removal: .opacity.combined(with: .move(edge: .top))
                        )
                    )
                }
            } else {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Overall sentiment")
                        .font(.subheadline)
                        .foregroundStyle(.primary)

                    Text("No responses yet")
                        .font(.body)
                        .foregroundStyle(.primary)
                }
            }
        }
        .padding(16)
        .background(
            .ultraThinMaterial,
            in: RoundedRectangle(cornerRadius: 24, style: .continuous)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .strokeBorder(Color.white.opacity(0.08), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.12), radius: 8, x: 0, y: 4)
        .padding(.horizontal)
    }
}


struct SecntimentPill: View {
    let sentiment: Sentiment
    let percentage: Int

    var body: some View {
        VStack(spacing: 6) {
            HStack(spacing: 6) {
                Image(systemName: sentiment.icon)
                    .font(.system(size: 12, weight: .semibold))

                Text(sentiment.rawValue)
                    .font(.caption)
                    .fontWeight(.semibold)
            }

            Text("\(percentage)%")
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(
            sentiment.sentimentColor.opacity(0.14),
            in: Capsule(style: .continuous)
        )
        .overlay {
            Capsule(style: .continuous)
                .strokeBorder(sentiment.sentimentColor.opacity(0.35), lineWidth: 0.7)
        }
        .foregroundStyle(sentiment.sentimentColor)
    }
}

private extension OverallSentimentSectionView {
    var overall: Sentiment? {
        guard !responses.isEmpty else { return nil }

        let map = Dictionary(grouping: responses, by: \.sentiment)
            .mapValues(\.count)

        guard let maxValue = map.values.max() else { return nil }

        let leaders = map.filter { $0.value == maxValue }.map { $0.key }

        if leaders.count > 1 {
            return .mixed
        }

        return leaders.first
    }

    var sentimentMap: [Sentiment: Int] {
        Dictionary(grouping: responses, by: \.sentiment)
            .mapValues(\.count)
    }

    func getPercentage(_ sentiment: Sentiment) -> Int {
        guard !responses.isEmpty else { return 0 }
        let count = sentimentMap[sentiment, default: 0]
        return Int(round((Double(count) / Double(responses.count)) * 100))
    }
}

#Preview {
    OverallSentimentSectionView(
        responses: [
            Response(id: UUID().uuidString, text: Response.sampleResponses[0], score: 1.0),
            Response(id: UUID().uuidString, text: Response.sampleResponses[1], score: -1.0),
            Response(id: UUID().uuidString, text: Response.sampleResponses[2], score: 0.0),
            Response(id: UUID().uuidString, text: Response.sampleResponses[3], score: 0.7),
            Response(id: UUID().uuidString, text: Response.sampleResponses[4], score: -0.4)
        ]
    )
}
