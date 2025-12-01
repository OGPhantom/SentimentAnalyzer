//
//  OverallSentimentSectionView.swift
//  SentimentAnalyzer
//
//  Created by Никита Сторчай on 30.11.2025.
//

import SwiftUI

struct OverallSentimentSectionView: View {
    let responses: [Response]
    var body: some View {
        GroupBox {
            if let overall {
                HStack {
                    Label("Leaning \(overall.self.rawValue)", image: "hyphen")
                        .font(.headline)
                        .foregroundStyle(overall.sentimentColor)

                    Spacer()

                    Text("\(responses.count) responses")
                }
                .padding(.bottom)

                HStack(spacing: 16) {
                    SecntimentPill(sentiment: .positive, percentage: getPercentage(.positive))

                    SecntimentPill(sentiment: .moderate, percentage: getPercentage(.moderate))

                    SecntimentPill(sentiment: .negative, percentage: getPercentage(.negative))
                }

            } else {
                Text("No resposes yet...")
            }
        } label: {
            Label("Overall Sentiment", systemImage: "chart.pie.fill")
        }
        .padding()

    }
}

struct SecntimentPill: View {
    let sentiment: Sentiment
    let percentage: Int
    var body: some View {
        VStack {
            HStack(spacing: 6) {
                Image(systemName: sentiment.icon)
                    .imageScale(.small)

                Text(sentiment.rawValue)
                    .font(.caption)
                    .fontWeight(.semibold)
            }

            Text("\(percentage)%")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(.vertical, 6)
        .padding(.horizontal, 10)
        .background(sentiment.sentimentColor.opacity(0.12), in: Capsule())
        .overlay {
            Capsule()
                .strokeBorder(sentiment.sentimentColor.opacity(0.35), lineWidth: 0.5)
        }
        .foregroundStyle(sentiment.sentimentColor)

    }
}

private extension OverallSentimentSectionView {
    var overall: Sentiment? {
        guard responses.count > 0 else { return nil }
        var map: [Sentiment: Int] = [:]

        for response in self.responses {
            map[response.sentiment, default: 0] += 1
        }

        var maxValue = 0
        var result: Sentiment?

        for (key, value) in map {
            maxValue = max(maxValue, value)

            if maxValue == value {
                result = key
            }
        }

        return result
    }

    var sentimentMap: [Sentiment: Int] {
        Dictionary (grouping: responses, by: \.sentiment).mapValues(\.count)
    }

    func getPercentage(_ sentiment: Sentiment) -> Int {
        guard !responses.isEmpty else { return 0 }
        let count = sentimentMap[sentiment, default: 0]
        return Int(round( (Double(count) / Double(responses.count)) * 100))
    }
}

#Preview {
    OverallSentimentSectionView(
        responses: [
            Response(
                id: UUID().uuidString,
                text: Response
                    .sampleResponses[0],
                score: 1.0
            ),
            Response(
                id: UUID().uuidString,
                text: Response
                    .sampleResponses[0],
                score: -1.0
            ),
            Response(
                id: UUID().uuidString,
                text: Response
                    .sampleResponses[0],
                score: 0.0
            ),
            Response(
                id: UUID().uuidString,
                text: Response
                    .sampleResponses[0],
                score: 0.74
            ),
            Response(
                id: UUID().uuidString,
                text: Response
                    .sampleResponses[0],
                score: -1.0
            ),
            Response(
                id: UUID().uuidString,
                text: Response
                    .sampleResponses[0],
                score: 1.0
            )
        ]
    )
}
